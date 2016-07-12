- connection: thelook

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: events
  joins:               
    - join: users
      type: left_outer 
      sql_on: ${events.user_id} = ${users.id}
      relationship: many_to_one


- explore: inventory_items
  joins:
    - join: products
      type: left_outer 
      sql_on: ${inventory_items.product_id} = ${products.id}
      relationship: many_to_one


- explore: order_items #only need always_join in fringe cases. but, always put the view_name.dimension
  sql_always_where: ${orders.created_date} >= '2016-01-01'
  
  label: 'Order Itemz (Look ma I changed the name)'
  joins: 
    - join: orders
    #  fields: [orders.id] #fields must always be scoped. filtered measures only need what the measure depends on - not supposed to happen
      view_label: "Orders (nick)"
      type: left_outer 
      sql_on: ${order_items.order_id} = ${orders.id}
      relationship: many_to_one

    - join: users
      type: left_outer 
      sql_on: ${orders.user_id} = ${users.id}
      relationship: many_to_one

    - join: inventory_items
      type: left_outer 
      sql_on: ${order_items.inventory_item_id} = ${inventory_items.id}
      relationship: many_to_one

    - join: products
      type: left_outer 
      sql_on: ${inventory_items.product_id} = ${products.id}
      relationship: many_to_one


- explore: orders
  joins:
    - join: users
      type: left_outer 
      sql_on: ${orders.user_id} = ${users.id}
      relationship: many_to_one


- explore: returned_analysis #where the URL is defined. always will be this
  from: order_items #base table
  view: order_items #what you're calling the base table in THIS explore
  #view_label: 'marcell'
  #label: 'fubar'
  
  joins:
    - join: inventory_items
      type: inner #would need to check if inventory_items.id stays the same no matter how many times something was returned. Doubtful
                  #ex. orders can be returned multiple times, new inventory_item_id every time? Many to many?
      relationship: one_to_one
      sql_on: |
        ${order_items.inventory_item_id} = ${inventory_items.id} 
  
    - join: products
      type: left_outer 
      sql_on: ${inventory_items.product_id} = ${products.id}
      relationship: many_to_one  
      

- explore: products
  persist_for: 4 hours
  joins: 
    - join: inventory_items
      type: inner
      sql_on: ${products.id} = ${inventory_items.product_id}
      relationship: one_to_one

- explore: user_data
  
  joins:
    - join: users
      type: left_outer 
      sql_on: ${user_data.user_id} = ${users.id}
      relationship: many_to_one


- explore: users
  description: 'this explore has an always filter'
  always_filter: 
    first_name: Alex, Ben
  
  


- explore: users_nn




