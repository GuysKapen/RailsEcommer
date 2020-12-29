# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.create([{name: 'Phone', object_id: 1,
                 description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda atque commodi dolorem placeat quo? Dicta, eius error fugit minus non odit quae quas recusandae rem vitae! Fugit laboriosam numquam repudiandae?',
                 regular_price: 600,
                 ratings: 4,
                 images: ['product 1.jpg', 'product 2.jpg', 'product 3.jpg'], }])

Product.create([{name: 'IPhone', object_id: 2,
                 description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda atque commodi dolorem placeat quo? Dicta, eius error fugit minus non odit quae quas recusandae rem vitae! Fugit laboriosam numquam repudiandae?',
                 regular_price: 800,
                 ratings: 5,
                 images: ['product 4.jpg', 'product 7.jpg', 'product 5.jpg'], }])


Product.create([{name: 'Laptop', object_id: 3,
                 description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda atque commodi dolorem placeat quo? Dicta, eius error fugit minus non odit quae quas recusandae rem vitae! Fugit laboriosam numquam repudiandae?',
                 regular_price: 600,
                 ratings: 4,
                 images: ['product 1.jpg', 'product 2.jpg', 'product 3.jpg'], }])

Product.create([{name: 'Amply', object_id: 4,
                 description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda atque commodi dolorem placeat quo? Dicta, eius error fugit minus non odit quae quas recusandae rem vitae! Fugit laboriosam numquam repudiandae?',
                 regular_price: 800,
                 ratings: 5,
                 images: ['product 4.jpg', 'product 7.jpg', 'product 5.jpg'], }])
