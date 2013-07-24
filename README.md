# ActsAsHasDefault

## Description

This `acts_as` extension provides the capabilities for selecting default model. The class that has this specified needs to have a `default` column defined as a boolean on the mapped database table.

## Installation

In your Gemfile:

```ruby
gem 'acts_as_has_default'
```

## Example

At first, you need to add a `default` column to desired table:

```console
rails g migration AddDefaultToAddress default:boolean
rake db:migrate
````

After that you can use `acts_as_has_default` method in the model:

```ruby
class Customer < ActiveRecord::Base
  has_many :addresses
end
    
class Address < ActiveRecord::Base
  belongs_to :customer
  acts_as_has_default scope: :customer_id
end
```
