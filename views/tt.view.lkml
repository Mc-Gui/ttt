view: add_a_unique_name_1642193335 {
# If necessary, uncomment the line below to include explore_source.
# include: "proyecto_copia.model.lkml"

    derived_table: {
      explore_source: order_items {
        column: statusss { field: orders.statusss }
        column: sino { field: users.sino }
        column: traffic_source { field: orders.traffic_source }
        column: count { field: inventory_items.count }
      }
    }
    dimension: statusss {}
    dimension: sino {
      label: "Users Sino (Yes / No)"
      type: yesno
    }
    dimension: traffic_source {}
    dimension: count {
      type: number
    }


 }
