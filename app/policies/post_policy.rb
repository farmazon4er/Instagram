class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def edit?
    user.posts.where(id: post.id).exists?
  end

  def update?
    user.posts.where(id: post.id).exists?
  end

  def destroy?
    user.posts.where(id: post.id).exists?
  end


end