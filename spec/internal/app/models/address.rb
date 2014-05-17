class Address
  include Mongoid::Document
  include Mongoid::Timestamps

  field :street,   type: String
  field :city,     type: String
  field :state,    type: String
  field :zip_code, type: String

  belongs_to :user
  belongs_to :user, inverse_of: :primary_address

end
