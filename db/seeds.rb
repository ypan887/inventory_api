customers = Customer.create([{ name: "Robert C Motyka", address: "1012 Maryland Avenue, Pinellas city", zip_code: "34624", country: "USA" },{ name: "Willie L Gage", address: "3589 Terra Cotta Street, Federal Dam city", zip_code: "56641", country: "USA" }])

categories = Category.create([{ name: "Vitamins & Supplements", description:"General vitamins and health supplements" },{ name:"Small appliance ", description:"Portable or semi-portable machines for kitchen and home" }])

merchants = Merchant.create([{ name: "Amazon"},{ name: "Bloomingdales" }])

products = Product.create([{ name: "Enfamil Liquid Vitamin D", category_id: categories.first.id , price: 10, cost: 6.85 },{ name: "Baby Ddrops liquid Vitamin D", category_id: categories.first.id, price: 16, cost: 12},{ name: "Irobot 880", category_id: categories.last.id , price: 800, cost:600 }])

Order.create([{ customer_id: customers.first.id, order_date: "2016-03-06", :order_details_attributes => [{ product_id: products[0].id, quantity: 4 },{ product_id: products[1].id, quantity: 4 },{ product_id: products[2].id, quantity: 1 }]}, { customer_id: customers.last.id, order_date: "2016-04-01", :order_details_attributes => [{ product_id: products[2].id, quantity: 2 }]}])

Shipment.create([{ tracking_number: "6KUV67845987KI", ship_cost: 40, ship_date: "2016-03-10", :shipment_details_attributes => [{ product_id: products[0].id, quantity: 4 },{ product_id: products[1].id, quantity: 4 },{ product_id: products[2].id, quantity: 1 }]}, { tracking_number: "4HGT34596837TF", ship_cost: 100, ship_date: "2016-04-06", :shipment_details_attributes => [{ product_id: products[2].id, quantity: 1 }]}])

Supply.create([{ order_date: "2016-03-07", merchant_id: merchants.first.id, :supply_details_attributes => [{ product_id: products[0].id, quantity: 4 },{ product_id: products[1].id, quantity: 4 }]},{ order_date: "2016-03-07", merchant_id: merchants.first.id, :supply_details_attributes => [{ product_id: products[2].id, quantity: 1 }]}, { order_date: "2016-04-02", merchant_id: merchants.last.id, :supply_details_attributes => [{ product_id: products[2].id, quantity: 2 }]}])