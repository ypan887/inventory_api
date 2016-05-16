[![Build Status](https://travis-ci.org/ypan887/inventory_api.svg?branch=master)](https://travis-ci.org/ypan887/inventoy_api)
[![Coverage Status](https://coveralls.io/repos/github/ypan887/inventoy_api/badge.svg?branch=master)](https://coveralls.io/github/ypan887/inventoy_api?branch=master)

# Introduction

I write this app becasue my wife needs an easy-to-use solution to help manage her small oversea trading business. The solution has two parts, an api and a front end app that consumes the api. 

# The demos

You can visit the demo client app [here](https://inv-client.herokuapp.com/)
Or visit the demo api [here](http://52.37.73.85/)

## Installation

```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed  # Only if you want to play around with seeded data to see how everything is working in this api
rails s
```

You can verify if the api is setup correctly by 

```
    curl localhost:3000/
```

You should see a response with welcome messages

## Features
You can use this api to keep a record on your product inventory, which includes all the information on products and its categories, custermers and their orders, shipments of products, and supplies of products.

## Examples

If you choose to seed the database, you can start explore the api

#### view all products or the products under specific category
```
curl localhost:3000/categories
curl localhost:3000/categories/1/products
```

#### view list of customers, or order history of each customer
```
curl localhost:3000/customers
curl localhost:3000/customers/1/orders
```

### view list of supplier merchants, or supply records of each merchant
```
curl localhost:3000/merchants
curl localhost:3000/merchants/1/supplies
```

### view monthly statements. 
Statement will be updated whenever the related sales information for that month changes. For example, if the quantity of an item in an order made on Apr-12-2016 changed, the income statement for that month will be recalculated and updated in database. However, if changes is on the product itself, like the price or cost of a product, the api will only query and update monthly statements that may be affected by the change of information.

```
curl localhost:3000/statements
```


### post or update to api
you can modify your sales record like this:
```
curl -v -H "Content-Type: application/json" -X PATCH http://localhost:3000/shipments/1 -d '{ "ship_cost": "20" }'

curl -v -H "Content-Type: application/json" -X PATCH http://localhost:3000/orders/1 -d '{ "order_date": "2016-04-05", "order_details_attributes": [{ "id": "6", "product_id": "1", "quantity": "4"}]}'
```