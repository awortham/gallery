class Address < ActiveRecord::Base
  belongs_to :user

  validates :zip, length: { maximum: 5}, format: { with: %r{\A\d{5}\z} }
  validates :street_number, presence: true, format: { with: %r{\A/\d+/\z}}
  validates :state, presence: true, allow_nil: false, inclusion: { in: :valid_state_code}

  def valid_state_code
    %w(AK AL AR AS AZ CA CO CT DC DE FL GA GU HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA PR RI SC SD TN TX UT VA VI VT WA WI WV WY)
  end

end
