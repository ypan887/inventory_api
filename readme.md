# Inventory Management Api

This api is built for Inventory Management App V3. 

The first two inventoy managment apps are regular rails app. I was inspired by a group project that I was working on recently, and I wanted to seprate the inventory managment app into an api and a front-end app. 

I am building this app becasue my girl need a easy to use solution for her small oversea trading business.


## Installation

```
bundle install
rake db:migrate
rake db:setup  # Only if you want to play around with seeded data to see how everything is working in this api
rails s
```

## Features
This api serves as a tool to keep an record on the products inventory. That includes all the information on custermers and their orders, products with categories, shipments of products, and supplies of product inventory.

## Examples

If you choose to seed the database, you can start explore the api

### checkout categories and the products
```
curl localhost:3000/categoris
curl localhost:3000/category/1/products
```

### checkout customers, and their orders

```
curl localhost:3000/customers
curl localhost:3000/customer/1/orders
```

### checkout supplier merchants, and their supply records
```
curl localhost:3000/merchants
curl localhost:3000/merchant/1/supplies
```

### checkout monthly statement. 
Statement will be updated whenever any relative sales information has changed on that paticular month. For example, if a orders record on Apr 12 2016 has changed, the income statement for that month will be recalculated and updated. If the price or cost of a product has changed, every monthly statements that happens after the created date of the product will be updated as well.

```
curl localhost:3000/statements
```

you can also modify your sales record like this:
```
curl -v -H "Content-Type: application/json" -X PATCH http://localhost:3000/shipments/1 -d '{ "ship_cost": "20" }'

curl -v -H "Content-Type: application/json" -X PATCH http://localhost:3000/orders/1 -d '{ "order_date": "2016-04-05", "order_details_attributes": [{ "id": "6", "product_id": "1", "quantity": "4"}]}'
```