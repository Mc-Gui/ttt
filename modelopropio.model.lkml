connection: "thelook"

           # include all views in the views/ folder in this project
include: "/**/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

explore: inventory_items {
  join: products {
    type: left_outer
    foreign_key:inventory_items.product_id
    relationship: many_to_one
  }
}

explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }


  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: sql_runner_query2 {
    type: inner
    sql_on: ${orders.user_id}=${sql_runner_query2.iddelquery} ;;
    relationship: one_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

# always_filter: {
 #   filters: [orders.statusss: "complete"]
  #}

  sql_always_where: ${orders.statusss}='complete' ;;

  #conditionally_filter: {
   #filters: [orders.statusss: "complete"]
  #unless: [products.brand]
  #}


}


explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: product_facts {
  join: products {
    type: left_outer
    sql_on: ${product_facts.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
  }


explore: products {}

explore: users {}

explore: test1{}
explore:  test2{}

explore: filtrofiltro {}
