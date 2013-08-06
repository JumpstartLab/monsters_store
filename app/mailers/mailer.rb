class Mailer < ActionMailer::Base
  default from: "frank@franks-monsterporium.com"

  def welcome_email(user_data)
    @user_data = user_data
    mail(to: user_data["email"], subject: "Welcome to Frank's Monsterporium!")
  end

  def order_confirmation(order_data)
    @order_data = order_data
    mail(to: order_data["email"], subject: "Thanks for your purchase!")
  end
end
