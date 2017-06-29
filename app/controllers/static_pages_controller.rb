class StaticPagesController < ApplicationController
  layout false
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      render layout: "application"
    else
      render layout: "landing"
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
