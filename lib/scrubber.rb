# TODO: Remove all ActiveRecord requirements. 
module Scrubber 
  class << self

    # Queue all the subjects.
    def process_terms_and_subjects
      agent = WWW::Mechanize.new

      terms_page = agent.get(OSU_URL)
      terms = parse_terms(terms_page)
      terms_form = terms_page.form('StuForm')

      subjects_page = terms_form.submit
      subjects = parse_subjects(subjects_page)
      subjects_form = subjects_page.form('StuForm')

      courses_page = subjects_form.submit

      terms.each do |term_identifier, term_attributes|
        term = create_or_update_term(term_identifier, term_attributes)
        subjects.each do |subject_identifier, subject_attributes|
          subject = create_or_update_subject(subject_identifier, subject_attributes)
          Delayed::Job.enqueue(SyncJob.new(term.id, subject.id))
          # Scrubber.process_courses_and_sections_for_term_and_subject(term, subject)
        end
      end
    end
    
    # ActiveRecord objects
    def process_courses_and_sections_for_term_and_subject(term, subject)
      agent = WWW::Mechanize.new

      terms_page = agent.get(OSU_URL)
      terms_form = terms_page.form('StuForm')
      terms_form['Term'] = term.identifier

      subjects_page = terms_form.submit
      subjects_form = subjects_page.form('StuForm')
      subjects_form['Subject'] = subject.identifier

      courses_page = subjects_form.submit
      courses_form = courses_page.form('courselist')

      courses = parse_courses(courses_page, term.identifier, subject.identifier)
      courses.each do |course_identifier, course_attributes|
        course_attributes.merge!(:subject => subject)
        course = create_or_update_course(course_identifier, course_attributes)

        fixed_course_identifier = fix_course_identifier(course.identifier)
        courses_form['CourseID'] = fixed_course_identifier

        sections_page = courses_form.submit
        sections = parse_sections(sections_page)
        sections.each do |section_identifier, section_attributes|
          section_attributes.merge!(:term_id => term.id, :course_id => course.id)
          section = create_or_update_section(section_identifier, section_attributes)
        end
      end
    end

    protected

      def fix_course_identifier(identifier)
        parts = identifier.split('-')
        return sprintf('%-4s-%s', parts[0], parts[1])
      end

      def parse_terms(terms_page)
        terms = {}
        terms_form = terms_page.form('StuForm')
        terms_form.field_with(:name => 'Term').options.each do |option|
          identifier = option.value.strip
          name = option.text.strip
          next if name.blank? || identifier.blank?
          terms[identifier] = { :name => name }
          Rails.logger.debug "Found Term: #{name} (#{identifier})"
        end
        Rails.logger.debug "Found #{terms.length} terms"
        return terms
      end

      def create_or_update_term(identifier, attributes)
        term = Term.find_or_initialize_by_identifier(identifier)
        term.attributes = attributes
        if term.new_record?
          term.disabled = true
          # Notifier.deliver_admin_message('New Term', "New term found: #{term.name}")
          puts "New term found: " + term.name
        end
        term.save
        return term
      end

      def parse_subjects(subjects_page)
        subjects = {}
        subjects_form = subjects_page.form('StuForm')
        subjects_form.field_with(:name => 'Subject').options.each do |option|
          name = option.text.strip
          identifier = option.value.strip
          next if name.blank? || identifier.blank?
          subjects[identifier] = { :name => name  }
          Rails.logger.debug "Found Subject: #{name} (#{identifier})"
        end
        Rails.logger.debug "Found #{subjects.length} subjects"
        return subjects
      end
      
      def create_or_update_subject(identifier, attributes)
        subject = Subject.find_or_initialize_by_identifier(identifier)
        subject.attributes = attributes
        subject.save
        return subject
      end

      def parse_courses(courses_page, term_identifier = nil, subject_identifier = nil)
        courses = {}
        hidden_fields = if subject_identifier.blank? || term_identifier.nil?
          courses_page.search('//input[@name="HTM"]')
        else
          hidden_field_id = %Q{#{subject_identifier}#{term_identifier}HTM}
          courses_page.search(%Q{//input[@id="#{hidden_field_id}"]})
        end
      
        hidden_fields.each do |hidden_field|
          
          options = hidden_field['value'].scan(/value='(.+)'.*>(.+)</i)

          options.each do |option|
            course = {}
            identifier = option[0].gsub(/\s+/, '')
            name = option.length > 1 ? option[1].strip : identifier
            courses[identifier] = { :name => name }
            Rails.logger.debug "Found Course: #{name} (#{identifier})"
          end  
        end
        Rails.logger.debug "Found #{courses.length} courses"
        return courses
      end
      
      def create_or_update_course(identifier, attributes)
        course = Course.find_or_initialize_by_identifier(identifier)
        course.attributes = attributes
        course.save
        return course
      end
    
      def parse_sections(sections_page)
        sections = {}
        trs = sections_page.search('table.datadisplaytable tr')
        trs.each do |tr|
          section = {}
          identifier = nil
          tds = tr.search('td')
          tds.each do |td|
            if td['headers'] == 'CourseID'
              if td.inner_text =~ /([ a-z]+-[ 0-9]+-[0-9]+)\s*(.*)/im
                identifier = $1.gsub(/\s+/, '')
                unless $2.blank?
                  section[:name] = $2.strip
                else
                  section[:name] = identifier
                end
              end
            elsif td['headers'] == 'CallNumber'
              section[:call_number] = td.text.gsub(/[^0-9]/, '')
            elsif td['headers'] == 'StatusAndSeats'
              if td.text =~ /open[^0-9]*([0-9]+)[^0-9]*([0-9]+)/im
                section[:status] = 'open'
                section[:open_seats] = $1 unless $1.blank?
                section[:total_seats] = $2 unless $2.blank?
              elsif td.text =~ /unlimited/im
                section[:status] = 'unlimited'
              else
                section[:status] = td.text.strip.downcase
              end
            elsif td['headers'] == 'DaysTimeLocation'
              if td.text =~ /([a-z]+)[^0-9]*(([0-9]+):([0-9]+)([a-z]*))\s*-\s*(([0-9]+):([0-9]+)([a-z]*))/im
                # $1 => days
                # $2 => start time
                # $3 => start hour
                # $4 => start minutes
                # $5 => start am/pm
                # $6 => end time
                # $7 => end hour
                # $8 => end minutes
                # $9 => end am/pm
                # 11:30 - 1:30PM => 11:30 - 13:30
                # 7:00 - 8:00PM => 07:00 - 20:00 (incorrect)
                # 7:00 - 8:00AM => 07:00 - 08:00
                section[:starts_at] = Time.parse($2)
                section[:ends_at] = Time.parse($6)
                section[:starts_at] = section[:starts_at] + 12.hours if section[:ends_at].hour > 12 && (section[:ends_at].hour - 12) > section[:starts_at].hour
                section[:days] = $1.gsub(/\s+/, '')
              end
            elsif td['headers'] == 'Instructor'
              if td.text =~ /([a-z]+[ -_a-z]*[a-z]*)/im
                name = $1.strip
                unless name.blank?
                  section[:instructor] = name
                end
              end
            end
            # TODO: Start and end dates
            # TODO: Credits
            # TODO: Prerequisites with links
            # TODO: Notes with links to sections / courses
            # TODO: Name (displayed after the Courseidentifier)
          end

          unless identifier.blank?
            sections[identifier] = section
            Rails.logger.debug "Found Section: #{section[:name]} (#{identifier})"
          end
        end
        Rails.logger.debug "Found #{sections.length} sections"
        return sections
      end
      
      def create_or_update_section(identifier, attributes)
        section = Section.find_or_initialize_by_identifier_and_term_id({ :identifier => identifier, :term_id => attributes[:term_id] })
        if attributes.has_key?(:instructor)
          instructor = Instructor.find_or_create_by_name(attributes.delete(:instructor))
          section.instructor = instructor
        end
        section.attributes = attributes
        section.save
        return section
      end

  end
end
