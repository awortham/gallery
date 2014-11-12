class WelcomeNotifier
  @queue = :email

  def self.perform(user_id, business_id)
    Notifier.welcome(user_id, business_id).deliver
  end
end
