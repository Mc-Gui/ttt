view:eje2{
    derived_table: {
      explore_source: order_items {
        column: id { field: users.id }
        column: count { field: orders.count }
        column: user { field: users.count }
        filters: {
          field: orders.count
          value: ">=30"
        }
      }
    }
    dimension: id {}

    dimension: count {
      type: number
    }

    dimension: user {
      type: number
    }
    measure: suma {
      type:sum
      sql: ${user} ;;
    }

 }
