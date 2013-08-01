# Mongoid Document Editor

Mongoid Document Editor is Rails Engine that provides a DSL for setting up simple admin interfaces to edit MongoDB documents.  No configuration is required in order to get a basic form, however you can override any form you want to provide a more custom and usable interface.

### Configuration
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
    field :visitied_city_ids: values: ->(user) { user.visited_cities }, label: :name, value: :id
  end

  index_configuration_for User do
    column :name
    column :email
    column :city
  end

end
```

### Usage
In your application visit: **/documents**

### Options
`authenticate_with`: Provide a controller filter for granting / denying access  
`form_configuration_for Class`: Allows you to specify the fields that you want on the form for the specified class  
`index_configuration_for Class`: Allows you to specify the columns that are displayed on the index page

### Notes
In development mode set `preload_models: true`
### TODO

* Customize endpoint (/documents)
* Rails generator
* Remove simple_form dependency


Styled using [Base](http://matthewhartman.github.io/base/docs/index.html)