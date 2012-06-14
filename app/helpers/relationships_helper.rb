module RelationshipsHelper
  def get_friends(user)
	@senders=user.senders
    @friends = user.friends.paginate(:page => params[:page],:per_page=>10)
  end
end
