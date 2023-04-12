module PostsHelper
  def liked?(post)
    if Like.where(post_id: post.id, user_id: current_user.id).exists?
      Like.where(post_id: post.id, user_id: current_user.id).first.status
    else
      false
    end
  end
end
