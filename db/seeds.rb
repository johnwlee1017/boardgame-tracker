# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: 'neurodynamic', password: 'password')
Boardgame.create(name: 'Banana Grams', description: 'make anagrams out of bananas', genre: 'grammar', players: 4, owner_id: User.first.id, image: 'http://bit.ly/2ybIa68')
Boardgame.create(name: 'Scrabble', description: 'make regular words out of bananas', genre: 'grammar', players: 6, owner_id: User.first.id, image: 'http://bit.ly/2xzH3sC')

User.create(username: 'john1017', password: 'password')

User.last.boardgames.create(name: 'Scrabble', description: 'make regular words out of bananas', genre: 'grammar', players: 6, image: 'http://bit.ly/2xzH3sC')
