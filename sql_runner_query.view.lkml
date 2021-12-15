view: sql_runner_query2 {
  derived_table: {
    sql: SELECT
          country as pais,
          id as id,
          email as email

      FROM
          users
       ;;
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
    sql: CONCAT ( ${TABLE}.email,'bbb');;
  }

  set: detail {
    fields: [pais, iddelquery, email]
  }
}
