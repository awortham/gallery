class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def welcome(user, business)
    @business = business
    @user = user
    mail(to: @user.email, subject: 'test welcome email')
  end

  def order_confirmation
  end

  def approval
  end

  def denial
  end
end
