class Credit
  attr_accessor :credit_balance, :user

  def initialize(user)
    @credit_balance = user.current_credit_balance
    @user = user
  end

  def -(number)
    credit_balance = credit_balance - number
  end

  def save
    user.current_credit_balance = credit_balance
    user.save
  end

  def depleted?
    credit_balance < 0
  end

  def low_balance?
    credit_balance < 10
  end



end
