require 'will_paginate/array'
module MicropostsHelper
  def get_profile_items(user)
	  @from_users=[]
    @feed_posts=user.microposts  
    @feed_posts.each do |x|
      @from_users.push(User.find_by_id(x.from_id))
    end    
    @feed_items=@feed_posts.zip(@from_users)
    @micropost = Micropost.new(:from_id =>current_user.id,:user_id => user.id)
    @friends = user.friends.paginate(:page => params[:page],:per_page=>10)
  end
end
