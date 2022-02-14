# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: "example@example.pl", 
             password: "password", password_confirmation: "password")

cars  = Category.create!(name: "Samochody")
tyres = Category.create!(name: "Opony")


cars.subcategories.create!(name: "Osobowe")
cars.subcategories.create!(name: "Dostawcze")
tyres.subcategories.create!(name: "Opony 20 cali")
tyres.subcategories.create!(name: "Opony 18 cali")
tyres.subcategories.create!(name: "Opony 16 cali")