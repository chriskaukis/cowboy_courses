class SubscriptionsController < ApplicationController
  before_filter :require_user
  
  def index
    @subscriptions = current_user.subscriptions.includes(:section).all
  end
  
  def create
    section = Section.find(params[:section_id])
    if current_user.subscriptions.include?(section)
      flash[:info] = "You are already subscribed to #{section.name}"
    else
      current_user.subscriptions.create(section: section)
      flash[:success] = "You subscribed to #{section.name} (#{section.call_number})"
    end
    redirect_to request.referrer || subscriptions_url
  end
  
  def destroy
    section = Section.find(params[:section_id])
    if current_user.subscribed_to?(section)
      current_user.subscriptions.where(section: section).destroy_all
      flash[:success] = "Unsubscribed to #{section.name} (#{section.call_number})"
    else
      flash[:info] = "You aren't subscribed to #{section.name} (#{section.call_number}"
    end
    redirect_to request.referrer || subscriptions_url
  end
end
