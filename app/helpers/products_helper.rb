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

  # @param attrs_values: values for first element
  # @param product_attrs: remain element for calling recursive
  # noinspection MissingYardReturnTag
  def product_cartesian(attrs_values, product_attrs)
    merge = {value: [], attrs_list_values: []}
    # loop through all values consecutive elements to build cartesian product for those two elements
    # NOTE: for first time value1 will be just value but when call recursive it is array (of all value so far)
    attrs_values.each do |value1|
      product_attrs[0][:value].split('|').each do |value2|
        # push all values (need to decompose value1 - it can be array) - see ruby array decompose
        merge[:value].push([*value1, value2])
      end
    end
    # save attrs for using in views
    merge[:attrs_list_values].push(*attrs_values)
    # recursive call for remaining
    return product_cartesian(merge[:value], product_attrs[1..]) if product_attrs.length > 1

    # push last attrs to complete all attrs
    merge[:attrs_list_values].push(product_attrs[0][:value].split('|'))
    merge
  end

  def products_cartesian(product_attrs)
    return product_attrs[0].value.split('|') if product_attrs.length == 1

    product_cartesian(product_attrs[0][:value].split('|'), product_attrs[1..])
  end

  # Get all set of attr_name: [attr_value] for product that have product_variations
  def attrs_of_product_variation(product)
    hash_attrs = {}
    product.product_variations.each do |v|
      v.product_attributes_values.each do |attr|
        name = attr.product_attributes_name.name
        hash_attrs[name] = if hash_attrs.key?(name)
                             hash_attrs[name].add(attr.value)
                           else
                             Set[attr.value]
                           end
      end
    end
    hash_attrs
  end
end
