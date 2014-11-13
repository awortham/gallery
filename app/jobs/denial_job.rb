class DenialJob
  @queue = :email

  def self.perform(business_id)
    Notifier.denial(business_id).deliver
  end
end

