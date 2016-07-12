- view: order_items
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: inventory_item_id
    type: number
    # hidden: true
    sql: ${TABLE}.inventory_item_id

  - dimension: order_id
    type: number
    label: Order ID amended
    # hidden: true
    sql: ${TABLE}.order_id

  - dimension_group: returned
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.returned_at

  - dimension: sale_price
    type: number
    sql: ${TABLE}.sale_price

  - measure: count
    type: count
    drill_fields: [id, orders.id, inventory_items.id]

  - dimension: is_returned
    type: yesno
    sql: ${returned_raw} IS NOT NULL #yesnos put in case statement if needed, or just go in where
    
    
  - dimension: item_net_margin
    type: number
    sql: ${sale_price} - ${inventory_items.cost}

  - measure: total_net_margin
    type: sum
    sql: ${item_net_margin}
    value_format_name: usd
    
    #what's best practice here - should I put this in inventory_items? Could go either way, but one product can have many different sales prices
  - dimension: percent_markdown
    type: number
    sql: (${products.retail_price} * 1.3 - ${sale_price}) / ${products.retail_price}
    value_format_name: percent_2
    
  - measure: count_distinct
    type: count_distinct
    sql: ${TABLE}.id
    
  - measure: avg_percent_markdown
    type: avg
    sql: ${percent_markdown}
    value_format_name: percent_2
  
    
    #am i doing weighted avg correctly? Whiteboard this.
  - measure: weighted_avg_markdown
    type: number
    sql: ${percent_markdown} / (${count_distinct}/${count})
    value_format_name: percent_2
    
    
    
    
  
    
    
    
    
    