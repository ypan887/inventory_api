[![Build Status](https://travis-ci.org/ypan887/inventoy_api.svg?branch=master)](https://travis-ci.org/ypan887/inventoy_api)

# Inventory Management Api

I am building a tool for my wife who is in need of an easy-to-use solution for managing her small oversea trading business.

This is solution version 3.0 and it will have two parts, an inventory api and a front end app to cosume that api. This new setup was inspired by a group project that I was currently working on. I am aiming for a better overall performance than the previous version.

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

#### view categories and the products
```
curl localhost:3000/categoris
curl localhost:3000/category/1/products
```

#### view customers, and their orders

```
curl localhost:3000/customers
curl localhost:3000/customer/1/orders
```

### view supplier merchants, and their supply records
```
curl localhost:3000/merchants
curl localhost:3000/merchant/1/supplies
```

### view monthly statement. 
Statement will be updated whenever the relative sales information for that month was changed. For example, if quantity of items in an order made on Apr-12-2016 has changed, the income statement for that month will be recalculated and updated number will be saved. If the price or cost of a product has changed, every monthly statements that happens after the created date of the product will be updated as well.

```
curl localhost:3000/statements
```

you can also modify your sales record like this:
```
curl -v -H "Content-Type: application/json" -X PATCH http://localhost:3000/shipments/1 -d '{ "ship_cost": "20" }'

curl -v -H "Content-Type: application/json" -X PATCH http://localhost:3000/orders/1 -d '{ "order_date": "2016-04-05", "order_details_attributes": [{ "id": "6", "product_id": "1", "quantity": "4"}]}'
```