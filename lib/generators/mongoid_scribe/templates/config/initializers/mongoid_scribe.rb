Mongoid::Scribe.configure do

##  authenticate_with :admin_required

##  mount_at "/documents"

##  resources include: [:user]

##  form_configuration_for User do
##    field :first_name
##    field :last_name
##    field :email, type: :email
##    field :city_id, values: -> { City.all }, label: :name, value: :id
##    field :favorite_color, values: User::COLORS
##  end

##  index_configuration_for User do
##    column :first_name
##    column :last_name
##    column :email, value: ->(user) { "<a href='mailto:#{user.email}'>#{user.email}</a>".html_safe }
##  end

end
