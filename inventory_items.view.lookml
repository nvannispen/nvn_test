- view: inventory_items
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: cost
    type: number
    sql: ${TABLE}.cost

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month, raw] #raw primarily used for joining tables on a date
    sql: ${TABLE}.created_at

  - dimension: product_id
    type: number
    # hidden: true
    sql: ${TABLE}.product_id

  - dimension_group: sold
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sold_at
    
  - dimension: is_sold
    type: yesno
    sql: ${sold_date} IS NOT NULL

#measures are ALWAYS aggregations

  - measure: count
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
    
  - measure: count_distinct
    type: count_distinct
    sql: ${TABLE}.id
    
  
    
  - dimension: days_in_inventory
    type: number
    sql: ${sold_date} - ${created_date}
    
    #talk to guys about hijacking filtering to allow user input
    #what's best practice if i'm building this out and then want to connect
    #a warehouse/cost table to this after a POC?
  - filter: input_cost_per_day
    
  - dimension: carry_cost_per_day
    type: number
    value_format_name: usd
    sql: |
      CAST({% parameter input_cost_per_day %} as decimal)
    
    
  - dimension: carry_cost
    type: number
    sql: ${days_in_inventory} * ${carry_cost_per_day}
    
  - measure: total_carry_cost
    type: sum
    sql: ${carry_cost}
    value_format_name: usd
    
  
  # tiered measures require a derived table
  
  

