- view: products
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: brand
    type: string
    sql: ${TABLE}.brand

  - dimension: category
    type: string
    sql: ${TABLE}.category

  - dimension: department
    type: string
    sql: ${TABLE}.department

  - dimension: item_name
    type: string
    sql: ${TABLE}.item_name

  - dimension: rank
    type: number
    sql: ${TABLE}.rank

  - dimension: retail_price
    type: number
    sql: ${TABLE}.retail_price

  - dimension: sku
    type: string
    sql: ${TABLE}.sku

  - measure: count
    type: count
    drill_fields: [id, item_name, inventory_items.count]
    
  - measure: count_of_distinct_products
    type: count_distinct
    sql: ${id}
    
  - measure: sum_retail_price
    type: sum
    sql: ${retail_price}
    

