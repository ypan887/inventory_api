def order_as(customer, options = {})
  FactoryGirl.create(:order,
    options.merge(:customer => FactoryGirl.create(:customer, :name => "Jobs"))
  )
end
