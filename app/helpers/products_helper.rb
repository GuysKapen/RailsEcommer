# frozen_string_literal: true

module ProductsHelper
  #  Compute the cartesian set product
  # @param attrs: an array
  # @param arr_attrs: an array of array to compute cartesian product
  def cartesian(attrs, arr_attrs)
    merge = []
    attrs.each do |attr1|
      arr_attrs[0].each do |attr2|
        merge.push([*attr1, attr2])
      end
    end
    return cartesian(merge, arr_attrs[1..]) if arr_attrs.length > 1

    merge
  end

  def product_cartesian(attrs, product_attrs)
    merge = { value: [], attrs: [] }
    # attrs = []
    # attrs.push(product_attrs[0][:value].split('|'))
    attrs.each do |attr1|
      product_attrs[0][:value].split('|').each do |attr2|
        merge[:value].push([*attr1, attr2])
      end
    end
    merge[:attrs].push(attrs)
    return product_cartesian(merge, product_attrs[1..]) if product_attrs.length > 1

    # merge[:value]
    merge[:attrs].push(product_attrs[0][:value].split('|'))
    merge
  end

  def products_cartesian(product_attrs)
    return product_attrs[0].value.split('|') if product_attrs.length == 1

    product_cartesian(product_attrs[0][:value].split('|'), product_attrs[1..])
  end
end
