ActiveRecord::Schema.define(version: 0) do
  create_table :users, force: true do |t|
    t.timestamps
  end
  
  create_table :addresses, force: true do |t|
    t.references :user
    t.boolean    :default
    t.timestamps
  end
end