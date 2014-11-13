class RequestBusinessJob
  @queue = :email

  def self.perform(business_id)
      User.where(platform_admin: true).each do |pa|
        Notifier.request_business(business_id, pa.id).deliver
      end
  end
end
