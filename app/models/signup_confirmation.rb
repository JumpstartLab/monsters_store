class SignupConfirmation
  def self.create(user)
    data = {"name" => user.full_name, "email" => user.email}
    message = {"type" => "signup_confirmation", "data" => data}
    $redis.publish("email_notifications", message.to_json)
  end
end