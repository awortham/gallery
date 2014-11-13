class ApprovalJob
  @queue = :email

  def self.perform(business_id)
    Notifier.approval(business_id).deliver
  end
end
