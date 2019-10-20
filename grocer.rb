require 'pp'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  
  # pp name, collection
  matching_hash = {}
  index = 0 
  while index < collection.length do 
    if name == collection[index][:item]
      matching_hash = collection[index]
      return matching_hash
    else
      matching_hash = nil 
    end
    index += 1 
  end
  # pp matching_hash
  matching_hash 
end

def consolidate_cart(cart)
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  # cart = [
  #   {:item => "AVOCADO", :price => 3.00, :clearance => true },
  #   {:item => "AVOCADO", :price => 3.00, :clearance => true },
  #   {:item => "KALE", :price => 3.00, :clearance => false}
  # ]
  
  con_cart = []
  index = 0
  # hash where :key is item's name and its value is old hash + :count
  temp_cart = {}
  # list of names (:keys) in 'temp_cart' hash
  names_list = []
  while index < cart.length do 
    name = cart[index][:item]
    hash = cart[index]
    if !temp_cart[name]
      temp_cart[name] = hash
      temp_cart[name][:count] = 1 
      names_list << name
    else
      temp_cart[name][:count] += 1
    end
    index += 1 
  end
  
  # temp_cart = {
  #   "AVOCADO" => {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 2},
  #   "KALE"    => {:item => "KALE", :price => 3.00, :clearance => false, :count => 1}
  # }
  
  index = 0 
  while index < names_list.length do
    con_cart_item = temp_cart[names_list[index]]
    con_cart << con_cart_item
    index += 1 
  end
  
  # con_cart = [
  #   {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 2},
  #   {:item => "KALE", :price => 3.00, :clearance => false, :count => 1}
  # ]  
  
  con_cart
end

def calculation(item, coupon)
  # pp item
  # pp coupon
  two_hashes = []
  
  items_count_without = 0
  items_count_with = 0
  item_price_with = coupon[:cost] / coupon[:num]
  
  if item[:count] >= coupon[:num]
    items_count_without = item[:count] % coupon[:num]
    if items_count_without == 0 
      # without = item
      # without[:count] = 0
      # two_hashes << without
      
      with = item
      with[:item] += " W/COUPON"
      with[:price] = item_price_with
      two_hashes << with
      # pp two_hashes
    else
      items_count_with = item[:count] - items_count_without
      
      without = item
      without[:count] = items_count_without
      two_hashes << without
      # pp two_hashes
      
      with = item
      pp with
      with[:item] += " W/COUPON"
      pp with
      with[:price] = item_price_with
      pp with
      with[:count] = items_count_with
      two_hashes << with
      # pp two_hashes
    end
  else
    two_hashes << item
    # pp two_hashes
    
    # with = item
    # with[:item] += " W/COUPON"
    # with[:price] = item_price_with
    # with[:count] = 0
    # two_hashes << with
  end
  
  two_hashes
end

def apply_coupons(cart, coupons)
  # REMEMBER: This method **should** update cart
  
  cart_coupons = []
  coupons_hash = {}
  index = 0 
  
  while index < coupons.length do
    coupons_hash[coupons[index][:item]] = coupons[index]
    index += 1 
  end
  index = 0 
  
  while index < cart.length do
    if !coupons_hash[cart[index][:item]]
      cart_coupons << cart[index]
    else
      item = cart[index]
      # pp item
      coupon = coupons_hash[item[:item]]
      # pp coupon
      two_hashes = calculation(item, coupon)
      cart_coupons += two_hashes
    end
    index += 1 
  end
  # pp cart_coupons
  cart_coupons
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
