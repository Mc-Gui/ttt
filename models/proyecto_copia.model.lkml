# Define the database connection to be used for this model.
connection: "thelook"

# include all the views
include: "/views/**/*.view"
include: "/**/**/*.view"
include: "dashboardcreadodesdelookml.dashboard.lookml"
# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: proyecto_copia_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

datagroup: datagroup_probandoando{
  label: "soy una etiqueta"
  description: "probando datagroup"
  max_cache_age: "5 hours"
  sql_trigger: SELECT (EXTRACT(MONTH FROM DATEADD( day, 1, GETDATE())));;
}

datagroup: envio_ultimo_dia_mes{
  sql_trigger: SELECT max(id) FROM  inventory_items;;
}

persist_with: datagroup_probandoando
#persist_for: "1 hour"

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Proyecto Copia"

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
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

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

# always_filter: {
 #  filters: [orders.statusss: "complete"]
  #}

  sql_always_where: ${orders.statusss}="complete" ;;
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

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: products {}

explore: users {}

explore: test1{}
explore: test2{}
explore: filtrofiltro {}
