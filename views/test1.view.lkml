view: test1 { derived_table: {
    sql: SELECT
        email, created_at,
        ROW_NUMBER() OVER (ORDER BY created_at) as row_number
      FROM public.users

      GROUP BY 1,2
      ORDER BY 3 ASC;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: row_number {
    type: number
    sql: ${TABLE}.row_number ;;
  }

  set: detail {
    fields: [email, created_at_time, row_number]
  }
}
