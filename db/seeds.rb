# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
roles = Role.create([{ name: 'Customer' }, { name: 'EventOrganizer' }])
customer = User.create(first_name: "Rakesh", last_name: "Saini", email: "rkrakeshsaini.78@gmail.com", phone_number: "9455228712", role_id: roles.first.id)
organizer = User.create(first_name: "Organizer First Name", last_name: "Organizer First Name", email: "rkrakeshsaini.78+1@gmail.com", phone_number: "9455228713", role_id: roles.second.id)
