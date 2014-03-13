class UserLevelPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def premium?
    user.created_at < Date.new(2010, 1, 1) || user.plan.premium?
  end
end
