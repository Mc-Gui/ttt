view: derivedtofilterameasure {

    derived_table: {
      explore_source: order_items {
        column: count {}
        column: first_name { field: users.first_name }
        filters: {
          field: orders.statusss
          value: "complete"
        }
        filters: {
          field: order_items.count
          value: ">6000"
        }
      }
    }
    dimension: count {
      type: number
    }

  #  dimension: first_name {}
   # measure: sumCounts {
    #  type: sum_distinct
    #  sql: ${count} ;;
    #}

  }
