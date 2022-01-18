view: persistente {

  derived_table: {
    distribution_style: all
    sql: SELECT
          country as pais,
          id as id,
          email as email

      FROM
          users
       ;;

     persist_for: "2 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: pais {
    type: string
    sql: ${TABLE}.pais ;;
  }

  dimension: iddelquery {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: email {
    type: string
    sql: CONCAT ( ${TABLE}.email,'persistente');;
  }

  set: detail {
    fields: [pais, iddelquery, email]
  }
}
# }
