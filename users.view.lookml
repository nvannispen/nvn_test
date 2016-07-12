- view: users
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: age
    type: number
    sql: ${TABLE}.age

  - dimension: age_tier
    type: tier
    sql: ${age} #do this because we've already defined age dimension
    tiers: [0,10,20,30,40,50,60,70,80]
    style: integer
    
  - dimension: city
    type: string
    sql: ${TABLE}.city

  - dimension: country
    type: string
    sql: ${TABLE}.country

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension: first_name
    type: string
    sql: ${TABLE}.first_name

  - dimension: gender
    type: string
    sql: ${TABLE}.gender
    

  - dimension: last_name
    type: string
    sql: ${TABLE}.last_name

  - dimension: state
    type: string
    sql: ${TABLE}.state

  - dimension: zip
    type: number
    hidden: true
    sql: ${TABLE}.zip
    
  - dimension: zipcode #can zipcode follow from zip?
    type: zipcode
    sql: ${zip}

  - measure: count
    type: count
    drill_fields: detail*
    
  - measure: count_women_in_NJ
    type: count
    description: 'This is a filtered measure, selects only women from NJ'
    filters:
      gender: f
      state: New Jersey
    drill_fields: [id, first_name, last_name]
  
  


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - id
    - last_name
    - first_name
    - events.count
    - orders.count
    - user_data.count

