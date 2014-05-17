class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name,  type: String
  field :email,      type: String
  field :slug,       type: String
  field :admin,      type: Boolean
  field :color,      type: String

  has_many :addresses
  belongs_to  :primary_address, class_name: "Address"

end
