# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# admin = User.new(email: 'guyskapen@gmail.com', password: 'password123')
# admin.save
# phone_category = admin.categories.build(name: 'Phone')
# watch_category = admin.categories.build(name: 'Watch')
# laptop_category = admin.categories.build(name: 'Laptop')
# camera_category = admin.categories.build(name: 'Camera')
#
# phone_category.save
# watch_category.save
# laptop_category.save
# camera_category.save

user = User.first

laptop_cat = Category.create(name: 'Laptop').save
watch_cat = Category.create(name: 'Watch').save
phone_cat = Category.create(name: 'Phone').save
head_phone_cat = Category.create(name: 'Head Phone').save

images1 = [File.open("#{Rails.root}/public/uploads/product_meta/images/253/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/253/image_2.jpeg", 'rb')]
images2 = [File.open("#{Rails.root}/public/uploads/product_meta/images/254/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/254/image_2.jpg", 'rb')]
images3 = [File.open("#{Rails.root}/public/uploads/product_meta/images/255/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/255/image_2.jpg", 'rb')]
images4 = [File.open("#{Rails.root}/public/uploads/product_meta/images/256/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/256/image_2.jpg", 'rb')]
images5 = [File.open("#{Rails.root}/public/uploads/product_meta/images/257/image_1.jpg", 'rb'),
           File.open("#{Rails.root}/public/uploads/product_meta/images/257/image_2.jpg", 'rb')]

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
  }
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
  'category_id' => laptop_cat.id

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
  'category_id' => laptop_cat.id

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
  'category_id' => watch_cat.id

}

list_params = [params1, params2, params3, params4, params5]

list_params.each do |params|
  product = user.products.build(params)
  print(product.errors.full_message) unless product.save
end

images = [File.open("#{Rails.root}/public/uploads/product_meta/images/264/image_1.jpg", 'rb')]
images_variation1 = [File.open("#{Rails.root}/public/uploads/product_meta/images/265/image_1.jpg", 'rb')]
images_variation2 = [File.open("#{Rails.root}/public/uploads/product_meta/images/266/image_1.jpg", 'rb')]
images_variation3 = [File.open("#{Rails.root}/public/uploads/product_meta/images/267/image_1.jpg", 'rb')]
images_variation4 = [File.open("#{Rails.root}/public/uploads/product_meta/images/268/image_1.jpg", 'rb')]
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
  'category_id' => '11',
  'product_variations_attributes' => [
    { 'product_meta_attributes' => {
      'product_detail_attributes' => { 'description' => '', 'regular_price' => '300' },
      'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '',
                                         'shipping_class' => '' },
      'product_inventory_attributes' => { 'stock_status' => '', 'sku' => 'SML-WHI' },
      'product_sale_price_attributes' => { 'sale_price' => '249' },
      'images' => images_variation1
    },
      'product_attributes_value_ids' => ['', '38', '', '40'] },
    { 'product_meta_attributes' =>
         { 'product_detail_attributes' => { 'description' => '', 'regular_price' => '310' },
           'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '',
                                              'shipping_class' => '' },
           'product_inventory_attributes' => { 'stock_status' => '', 'sku' => 'SML-BLU' },
           'product_sale_price_attributes' => { 'sale_price' => '249' },
           'images' => images_variation2 },
      'product_attributes_value_ids' => ['', '38', '', '41'] },
    { 'product_meta_attributes' => {
      'product_detail_attributes' => { 'description' => '', 'regular_price' => '320' },
      'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '',
                                         'shipping_class' => '' },
      'product_inventory_attributes' => { 'stock_status' => '', 'sku' => 'MED-WHI' },
      'product_sale_price_attributes' => { 'sale_price' => '259' },
      'images' => images_variation3
    },
      'product_attributes_value_ids' => ['', '39', '', '40'] },
    { 'product_meta_attributes' => {
      'product_detail_attributes' => { 'description' => '', 'regular_price' => '310' },
      'product_shipping_attributes' => { 'weight' => '', 'width' => '', 'height' => '', 'length' => '',
                                         'shipping_class' => '' },
      'product_inventory_attributes' => { 'stock_status' => '', 'sku' => 'MED-BLU' },
      'product_sale_price_attributes' => { 'sale_price' => '249' },
      'images' => images_variation4
    },
      'product_attributes_value_ids' => ['', '39', '', '41'] }
  ]
}

product = user.products.build(params_variation)
print(product.errors.full_message) unless product.save
