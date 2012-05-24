# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

site_one = Site.create(title: "first site", host: "one.codehog.com")
site_one.pages.create(title: "/", body: "home page for site one")


site_two = Site.create(title: "second site", host: "two.codehog.com")
site_two.pages.create(title: "/", body: "home page for site two")
