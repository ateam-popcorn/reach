# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# coding: utf-8



research = Research.create(title: 'Test Research', start_at: '2015-11-13 15:00:00', end_at: '2015-11-13 16:00:00', reward: 1000, max_users: 4, min_users: 2)

Meeting.create(start_at: '2015-11-13 15:00:00', end_at: '2015-11-13-16:00:00', research: research.id)



