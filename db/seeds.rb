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
head_phone_category = admin.categories.build(name: 'Head Phone')

phone_category.save
watch_category.save
laptop_category.save
camera_category.save
head_phone_category.save

attr_name_size = ProductAttributesName.new(name: 'Size')
attr_name_size.save
attr_name_color = ProductAttributesName.new(name: 'Color')
attr_name_color.save

attr_value_small = attr_name_size.product_attributes_values.build(value: 'Small')
attr_value_small.save
attr_value_medium = attr_name_size.product_attributes_values.build(value: 'Medium')
attr_value_medium.save

attr_value_blue = attr_name_color.product_attributes_values.build(value: 'Blue')
attr_value_blue.save
attr_value_white = attr_name_color.product_attributes_values.build(value: 'White')
attr_value_white.save

images1 = [File.open("#{Rails.root}/public/uploads/product_meta/images/1/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/1/image_2.jpg", 'rb')]
images2 = [File.open("#{Rails.root}/public/uploads/product_meta/images/2/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/2/image_2.jpg", 'rb')]
images3 = [File.open("#{Rails.root}/public/uploads/product_meta/images/3/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/3/image_2.jpg", 'rb')]
images4 = [File.open("#{Rails.root}/public/uploads/product_meta/images/4/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/4/image_2.jpg", 'rb')]
images5 = [File.open("#{Rails.root}/public/uploads/product_meta/images/5/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/5/image_2.jpg", 'rb')]
images6 = [File.open("#{Rails.root}/public/uploads/product_meta/images/6/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/6/image_2.jpg", 'rb')]

params1 = {
  'product_meta_attributes' => {
    'product_detail_attributes' => { 'name' => 'Phone',
                                     'description' => '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>',
                                     'regular_price' => '600' }, 'images' => images1,
    'product_sale_price_attributes' => { 'sale_price' => '' },
    'product_inventory_attributes' => { 'sku' => 'PHO', 'manage_stock' => '0', 'stock_status' => '', 'sold_individually' => '0' },
    'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '', 'shipping_class' => '' },
    'product_linked_attributes' => { 'upsells' => '', 'cross_sells' => '' },
    'product_advanced_attributes' => { 'purchase_note' => '', 'enable_reviews' => '0' },
    'product_extra_attributes' => { 'product_video' => '' }
  },
  'category_id' => phone_category.id

}

params2 = {
  'product_meta_attributes' => {
    'product_detail_attributes' => { 'name' => 'Phone',
                                     'description' => '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>',
                                     'regular_price' => '500' }, 'images' => images2,
    'product_sale_price_attributes' => { 'sale_price' => '449' },
    'product_inventory_attributes' => { 'sku' => 'PHO', 'manage_stock' => '0', 'stock_status' => '', 'sold_individually' => '0' },
    'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '', 'shipping_class' => '' },
    'product_linked_attributes' => { 'upsells' => '', 'cross_sells' => '' },
    'product_advanced_attributes' => { 'purchase_note' => '', 'enable_reviews' => '0' },
    'product_extra_attributes' => { 'product_video' => '' }
  }

}
params3 = {
  'product_meta_attributes' => {
    'product_detail_attributes' => { 'name' => 'Laptop',
                                     'description' => '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>',
                                     'regular_price' => '1000' }, 'images' => images3,
    'product_sale_price_attributes' => { 'sale_price' => '' },
    'product_inventory_attributes' => { 'sku' => 'LAP', 'manage_stock' => '0', 'stock_status' => '', 'sold_individually' => '0' },
    'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '', 'shipping_class' => '' },
    'product_linked_attributes' => { 'upsells' => '', 'cross_sells' => '' },
    'product_advanced_attributes' => { 'purchase_note' => '', 'enable_reviews' => '0' },
    'product_extra_attributes' => { 'product_video' => '' }
  },
  'category_id' => laptop_category.id

}
params4 = {
  'product_meta_attributes' => {
    'product_detail_attributes' => { 'name' => 'Laptop Gaming',
                                     'description' => '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>',
                                     'regular_price' => '1200' }, 'images' => images4,
    'product_sale_price_attributes' => { 'sale_price' => '1099' },
    'product_inventory_attributes' => { 'sku' => 'PHO', 'manage_stock' => '0', 'stock_status' => '', 'sold_individually' => '0' },
    'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '', 'shipping_class' => '' },
    'product_linked_attributes' => { 'upsells' => '', 'cross_sells' => '' },
    'product_advanced_attributes' => { 'purchase_note' => '', 'enable_reviews' => '0' },
    'product_extra_attributes' => { 'product_video' => '' }
  },
  'category_id' => laptop_category.id

}
params5 = {
  'product_meta_attributes' => {
    'product_detail_attributes' => { 'name' => 'Watch',
                                     'description' => '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>',
                                     'regular_price' => '300' }, 'images' => images5,
    'product_sale_price_attributes' => { 'sale_price' => '' },
    'product_inventory_attributes' => { 'sku' => 'PHO', 'manage_stock' => '0', 'stock_status' => '', 'sold_individually' => '0' },
    'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '', 'shipping_class' => '' },
    'product_linked_attributes' => { 'upsells' => '', 'cross_sells' => '' },
    'product_advanced_attributes' => { 'purchase_note' => '', 'enable_reviews' => '0' },
    'product_extra_attributes' => { 'product_video' => '' }
  },
  'category_id' => watch_category.id

}

param_sale_price = {
  'product_meta_attributes' => {
    'product_detail_attributes' =>
                           { 'name' => 'Samsung Watch', 'description' => "<p>A beautiful Samsung Watch</p>\r\n",
                             'regular_price' => '350' },
    'images' => images6,
    'product_sale_price_attributes' => { 'sale_price' => '299',
                                         'sale_date_start' => '2021-05-20 08:00', 'sale_date_end' => '2021-06-24 12:00' },
    'product_inventory_attributes' => { 'sku' => '', 'manage_stock' => '0', 'stock_status' => '',
                                        'sold_individually' => '0' },
    'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '',
                                       'length' => '', 'shipping_class' => '' },
    'product_linked_attributes' => { 'upsells' => '', 'cross_sells' => '' },
    'product_advanced_attributes' => { 'purchase_note' => '', 'enable_reviews' => '0' },
    'product_extra_attributes' => { 'product_video' => '' }
  }, 'category_id' => watch_category.id
}

list_params = [params1, params2, params3, params4, params5, param_sale_price]

list_params.each do |params|
  product = admin.products.build(params)
  # noinspection RubyNilAnalysis
  print(product.errors.full_message) unless product.save
end

images = [File.open("#{Rails.root}/public/uploads/product_meta/images/7/image_1.jpg", 'rb')]
images_variation1 = [File.open("#{Rails.root}/public/uploads/product_meta/images/8/image_1.jpg", 'rb')]
images_variation2 = [File.open("#{Rails.root}/public/uploads/product_meta/images/9/image_1.jpg", 'rb')]
images_variation3 = [File.open("#{Rails.root}/public/uploads/product_meta/images/10/image_1.jpg", 'rb')]
images_variation4 = [File.open("#{Rails.root}/public/uploads/product_meta/images/11/image_1.jpg", 'rb')]
params_variation = {
  'product_meta_attributes' => {
    'product_detail_attributes' => { 'name' => 'Head Phone Conial',
                                     'description' => "<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n" },
    'images' => images,
    'product_inventory_attributes' => { 'sku' => '', 'manage_stock' => '0', 'stock_status' => '',
                                        'sold_individually' => '0' },
    'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '',
                                       'shipping_class' => '' },
    'product_linked_attributes' => { 'upsells' => '', 'cross_sells' => '' },
    'product_advanced_attributes' => { 'purchase_note' => '', 'enable_reviews' => '0' },
    'product_extra_attributes' => { 'product_video' => '' }
  },
  'category_id' => head_phone_category.id,
  'product_variations_attributes' => [
    { 'product_meta_attributes' => {
      'product_detail_attributes' => { 'description' => '', 'regular_price' => '300' },
      'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '',
                                         'shipping_class' => '' },
      'product_inventory_attributes' => { 'stock_status' => '', 'sku' => 'SML-WHI' },
      'product_sale_price_attributes' => { 'sale_price' => '249' },
      'images' => images_variation1
    },
      'product_attributes_value_ids' => ['', attr_value_small.id, '', attr_value_blue.id] },
    { 'product_meta_attributes' =>
         { 'product_detail_attributes' => { 'description' => '', 'regular_price' => '310' },
           'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '',
                                              'shipping_class' => '' },
           'product_inventory_attributes' => { 'stock_status' => '', 'sku' => 'SML-BLU' },
           'product_sale_price_attributes' => { 'sale_price' => '249' },
           'images' => images_variation2 },
      'product_attributes_value_ids' => ['', attr_value_small.id, '', attr_value_white.id] },
    { 'product_meta_attributes' => {
      'product_detail_attributes' => { 'description' => '', 'regular_price' => '320' },
      'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '',
                                         'shipping_class' => '' },
      'product_inventory_attributes' => { 'stock_status' => '', 'sku' => 'MED-WHI' },
      'product_sale_price_attributes' => { 'sale_price' => '259' },
      'images' => images_variation3
    },
      'product_attributes_value_ids' => ['', attr_value_medium.id, '', attr_value_blue.id] },
    { 'product_meta_attributes' => {
      'product_detail_attributes' => { 'description' => '', 'regular_price' => '310' },
      'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '',
                                         'shipping_class' => '' },
      'product_inventory_attributes' => { 'stock_status' => '', 'sku' => 'MED-BLU' },
      'product_sale_price_attributes' => { 'sale_price' => '249' },
      'images' => images_variation4
    },
      'product_attributes_value_ids' => ['', attr_value_medium.id, '', attr_value_white.id] }
  ]
}

product = admin.products.build(params_variation)
# noinspection RubyNilAnalysis
print(product.errors.full_message) unless product.save
