# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

league_manager = User.create(first_name: "League Manager", email: "lm@hokey.com", password: "ligahokeja")
Membership.create(user: league_manager, team: nil, role: 3)
Team.create([{ name: 'Chicago' }, { name: 'Washington' }, { name: 'Toronto' }, { name: 'Arizona' }])
