# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# User seeds
users = User.create([

  {
    name: 'Brandon Kwong',
    email: 'brandonjk@gmail.com',
    password: '********'
  },

  {
    name: 'Grace Young',
    email: 'graceyoung1@gmail.com',
    password: '********'
  }

])


# Group seeds
groups = Group.create([

  {
    name: 'Friends',
    description: 'To the homies'
  },

  {
    name: 'Shops',
    description: 'Buy all the things'
  },

  {
    name: 'Restaurants',
    description: 'For the foodies'
  }

])


# Location seeds
locations = Location.create([

  {
    name: 'Alejandro',
    address: '1803 Malcolm Ave, Los Angeles, CA 90025',
    description: 'Westwood hangout',
    # group: @groups.name = 'Friends'
  },

  {
    name: 'The Hundreds',
    address: '416 Broadway St, Santa Monica, CA 90401',
    description: 'Bobby Hundreds Adam Bomb'
  },

  {
    name: 'Buffalo Exchange',
    address: '2449 Main St, Santa Monica, CA 90405',
    description: 'Best consignment clothing'
  },

  {
    name: 'Sugarfish',
    address: '1345 2nd St, Santa Monica, CA 90401',
    description: 'Super dope sushi'
  },

  {
    name: 'Bay Cities Deli',
    address: '1517 Lincoln Blvd, Santa Monica, CA 90401',
    description: 'All for the Godmother'
  }

])