module PostsHelper
  def liked?(post)
    like_status = post.likes.find_by(user_id: current_user.id)
    like_status ? like_status.status : false
  end
end