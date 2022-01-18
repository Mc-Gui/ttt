# The name of this view in Looker is "Inventory Items"
view: inventory_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.inventory_items ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

filter: filtrodefecha {
  type: date

}


  dimension: liquidObject {
    type: string
    link: {
      url: " https://help.looker.com/hc/en-us/articles/360023722974-A-Simple-Explanation-of-Symmetric-Aggregates-or-Why-On-Earth-Does-My-SQL-Look-Like-That-"
    }

    #sql: '{{ link}}' ;;<------no supe
    #sql: '{{_model._name}}' ;;  #----> imprime el nombre del proyecto
    #sql:'{{_field._name}}'  ;;
    #sql: '{{_query._query_timezone}}' ;;
    #sql:'{{inventory_items._in_query}}'---->este no jalo tal cual por que noes una dimension tipica/mal definida
    #sql: {% if order_items.fecha._parameter_value==null%}'yes'{%endif%} ;;
  }

  dimension: liquidTag {
    # sql:{%if _model._name!="hol"%} 'diferente' {% endif %};;
    #sql: {%if products._in_query!= true%} 'notrue'{% endif %};;
    #sql: {%date_start order_items.fecha %};;#--->si se le pone' imprime como cadena :/ ppp lo dice la documentacion
    #sql: {%date_start created_date %};;---->este no jalo



  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cost" in Explore.

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: [id, products.id, products.item_name, order_items.count]
  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_cost {
    type: sum
    hidden: yes
    sql: ${cost} ;;
  }

  measure: average_cost {
    type: average
    hidden: yes
    sql: ${cost} ;;
  }
}
