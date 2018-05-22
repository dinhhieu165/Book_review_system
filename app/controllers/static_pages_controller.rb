class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @activities = Activity.by_following_from(current_user.id)
  end

  def about
  end

  def contact
  end
end
