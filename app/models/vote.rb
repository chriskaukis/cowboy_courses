class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, :polymorphic => true

  validates_presence_of :user_id, :voteable_id, :voteable_type
  validates_uniqueness_of :voteable_id, :scope => [:user_id, :voteable_type]

  after_create :increment_votes_cache
  after_update :update_votes_cache
  before_destroy :decrement_votes_cache

  def self.up!(voteable_object, user)
    vote = voteable_object.votes.find_or_initialize_by_user_id(user.id)
    vote.points = 1
    vote.save
    vote
  end

  def self.down!(voteable_object, user)
    vote = voteable_object.votes.find_or_initialize_by_user_id(user.id)
    vote.points = -1
    vote.save
    vote
  end

  protected

    def update_votes_cache
      if points_was > 0 && points < 0
        voteable.increment!(:downs, points.abs)
        voteable.decrement!(:ups, points_was) if voteable.ups > 0
      elsif points_was < 0 && points > 0
        voteable.increment(:ups, points)
        voteable.decrement!(:downs, points_was.abs) if voteable.downs > 0
      end
    end

    def increment_votes_cache
      if points > 0 && voteable.respond_to?(:ups)
        voteable.increment!(:ups, points)
      elsif points < 0 && voteable.respond_to?(:downs)
        voteable.increment!(:downs, points.abs)
      end
    end

    def decrement_votes_cache
      if points > 0 && voteable.respond_to?(:ups)
        voteable.decrement!(:ups, points) if voteable.ups > 0
      elsif points < 0 && voteable.respond_to?(:downs)
        voteable.decrement!(:downs, points.abs) if voteable.downs > 0
      end
    end
end
