view: nomatche {
  derived_table: {
    sql: SELECT
         order_items.*
      FROM
          order_items AS "order_items"
      full join orders as "orders"
      on order_items.order_id = orders.id
      where order_items.order_id is null or  orders.id is null
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension_group: returned_at {
    type: time
    sql: ${TABLE}.returned_at ;;
  }

  set: detail {
    fields: [id, order_id, sale_price, inventory_item_id, returned_at_time]
  }
}
