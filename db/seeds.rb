# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# users.create(username: 'user1', password: bc)
include BCrypt

users = User

users.destroy_all

users.create!([{
                 username: "user1",
                 password: BCrypt::Password.create("pwduser1"),
               },
               {
                 username: "user2",
                 password: BCrypt::Password.create("pwduser2"),
               },
               {
                 username: "user3",
                 password: BCrypt::Password.create("pwduser3"),
               },
               {
                 username: "user4",
                 password: BCrypt::Password.create("pwduser4"),
               }])

p "Created #{users.count} users"
