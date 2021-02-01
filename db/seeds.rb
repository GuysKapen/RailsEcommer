# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.new(email: 'guyskapen@gmail.com', password: 'password123')
admin.save
phone_category = admin.categories.build(name: 'Phone')
watch_category = admin.categories.build(name: 'Watch')
laptop_category = admin.categories.build(name: 'Laptop')
camera_category = admin.categories.build(name: 'Camera')

phone_category.save
watch_category.save
laptop_category.save
camera_category.save
# noinspection RubyNilAnalysis
# admin.products.build({name: 'Phone', images: JSON.dump(%w[phone-1.jpg phone-2.jpg phone-3.jpg]), category_id: phone_category.id, description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda atque commodi dolorem placeat quo? Dicta, eius error fugit minus non odit quae quas recusandae rem vitae! Fugit laboriosam numquam repudiandae?'})
#     .build_product_meta(regular_price: 600, ratings: 4, sale_price: 499).save
# noinspection RubyNilAnalysis
product1 = admin.products.build({ name: 'Watch', category_id: watch_category.id, description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda atque commodi dolorem placeat quo? Dicta, eius error fugit minus non odit quae quas recusandae rem vitae! Fugit laboriosam numquam repudiandae?' })
product1.images = [File.open("#{Rails.root}/app/assets/images/phone_1.jpeg", 'rb'),]
product1.save
product1.build_product_meta(regular_price: 600, ratings: 4, sale_price: 499).save
# noinspection RubyNilAnalysis
product2 = admin.products.build({ name: 'IPhone', category_id: phone_category.id, description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda atque commodi dolorem placeat quo? Dicta, eius error fugit minus non odit quae quas recusandae rem vitae! Fugit laboriosam numquam repudiandae?' })
product2.images = [File.open("#{Rails.root}/app/assets/images/Image-20.jpg", 'rb'), File.open("#{Rails.root}/app/assets/images/product_4.jpg", 'rb'),]
                  product2.save
product2.build_product_meta(regular_price: 600, ratings: 4, sale_price: 499).save
# noinspection RubyNilAnalysis
product3 = admin.products.build({ name: 'Laptop', category_id: laptop_category.id, description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda atque commodi dolorem placeat quo? Dicta, eius error fugit minus non odit quae quas recusandae rem vitae! Fugit laboriosam numquam repudiandae?' })
product3.images = [File.open("#{Rails.root}/app/assets/images/laptop-1.jpg", 'rb'), File.open("#{Rails.root}/app/assets/images/laptop-2.jpg", 'rb'),]
                  product3.save
product3.build_product_meta(regular_price: 600, ratings: 4, sale_price: 499).save
# noinspection RubyNilAnalysis
product4 = admin.products.build({ name: 'Samsung Phone', category_id: phone_category.id, description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda atque commodi dolorem placeat quo? Dicta, eius error fugit minus non odit quae quas recusandae rem vitae! Fugit laboriosam numquam repudiandae?' })
product4.images = [File.open("#{Rails.root}/app/assets/images/phone_4.jpg", 'rb'), File.open("#{Rails.root}/app/assets/images/phone_5.jpeg", 'rb'),]
                  product4.save
product4.build_product_meta(regular_price: 600, ratings: 4, sale_price: 499).save
# noinspection RubyNilAnalysis
product5 = admin.products.build({ name: 'Camera', category_id: camera_category.id, description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda atque commodi dolorem placeat quo? Dicta, eius error fugit minus non odit quae quas recusandae rem vitae! Fugit laboriosam numquam repudiandae?' })
product5.images = [File.open("#{Rails.root}/app/assets/images/camera.jpg", 'rb'),]
                  product5.save
product5.build_product_meta(regular_price: 600, ratings: 4, sale_price: 499).save
