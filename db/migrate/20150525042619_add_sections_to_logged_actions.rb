class AddSectionsToLoggedActions < ActiveRecord::Migration
  def up
    execute <<-SQL
select audit_table('sections');
    SQL
  end

  def down
    execute <<-SQL
DROP TRIGGER audit_trigger_row ON sections;
DROP TRIGGER audit_trigger_stm ON sections;
    SQL
  end
end
