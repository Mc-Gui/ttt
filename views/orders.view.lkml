# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.orders ;;
  drill_fields:[source*, id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
      year,day_of_week
    ]
    sql: ${TABLE}.created_at ;;
  }

measure:maximafecha
{
  type: date
  sql: MAX(${created_date}) ;;
  convert_tz: no

}

measure: diffecha
{
  type: number
  sql: datediff(day,${maximafecha},GETDATE()) ;;
}


  #crea un picker
  parameter: timeframe_picker {
    label: "Date Granularity"
    type: string
    allowed_value: { value: "Date" label: "To aggregate by Event Date"}
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Year" }
    default_value: "Date"
  }

dimension: fechadinamica {
  label_from_parameter: timeframe_picker
    sql:
        CASE
          WHEN {% parameter timeframe_picker %} = 'Date' THEN TO_CHAR(${created_date}, 'YYYY/MM/DD')
          WHEN {% parameter timeframe_picker %} = 'Month' THEN ${created_month}
          WHEN {% parameter timeframe_picker %} = 'Quarter' THEN ${created_quarter}
          WHEN {% parameter timeframe_picker %} = 'Year' THEN TO_CHAR(${created_year},'9999')
          ELSE NULL
        END ;;
}



  #crea un picker
  parameter: dimension_picker {
    type: string
    allowed_value: { value: "statusss" }
    allowed_value: { value: "traffic_source" }
    allowed_value: { value: "user_id" }
    default_value: "Date"
  }

  dimension: dimensiondinamica {
    label_from_parameter: dimension_picker
    sql:
        CASE
          WHEN {% parameter dimension_picker %} = 'statusss' THEN ${statusss}
          WHEN {% parameter dimension_picker %} = 'traffic_source' THEN ${traffic_source}
          WHEN {% parameter dimension_picker %} = 'user_id' THEN TO_CHAR(${user_id},'9999')
          ELSE NULL
        END ;;
  }


#esto aplica un filtro en un otro campo
filter: esteesunfiltro {
  type: string
  sql: {% condition esteesunfiltro %}  {% endcondition %} ;;
}




  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Status" in Explore.

  dimension: statusss {
    type: string
    sql: ${TABLE}.status ;;
    drill_fields: [id, users.id, users.first_name]
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
  }

  set: source {

    fields: [traffic_source, created_date]

  }

}
# These sum and average measures are hidden by default.
# If you want them to show up in your explore, remove hidden: yes.
# These sum and average measures are hidden by default.
# If you want them to show up in your explore, remove hidden: yes.
# These sum and average measures are hidden by default.
# If you want them to show up in your explore, remove hidden: yes.

# These sum and average measures are hidden by default.
# If you want them to show up in your explore, remove hidden: yes.
