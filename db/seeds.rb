# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

t = Tenant.create({
  name: "Dev",
  hostname: "localhost",
  id: 1
})

Tenant.current_id = 1

User.new do |u|
  u.username = "Admin"
  u.email = "admin@example.net"
  u.password = "supersecret"
  u.password_confirmation = "supersecret"
  u.role = :admin
  u.approved = true
end.save

Tenant.current_id = nil
