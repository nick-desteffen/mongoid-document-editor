# Mongoid Document Editor

Mongoid Document Editor is Rails Engine that provides a DSL for setting up simple admin interfaces to edit MongoDB documents.  No configuration is required in order to get a basic form, however you can override any form you want to provide a more custom and usable interface.

## Usage
Create an initializer and configure your admin interface.  

```ruby
Mongoid::DocumentEditor.configure do

  authenticate_with :admin_required

  form_configuration_for User do
  	field :name
    field :email
    field :favorite_color, values: User::COLORS
    field :email, type: :email
    field :home_city_id, values: -> { City.all }, label: :name, value: :id
    field :visitied_city_ids: values: ->(user) { user.visited_cities.collect(&:id) }, label: :name, value: :id
  end

  index_configuration_for User do
    column :name
    column :email
    column :city
  end

end
```

### Options
`authenticate_with`: Provide a controller filter for granting access  
`form_configuration_for Class`: This allows you to specify the fields that you want on the form for the specified class  
`index_configuration_for Class`: This allows you to specify the columns that are displayed on the index page

## TODO

* Rails generator