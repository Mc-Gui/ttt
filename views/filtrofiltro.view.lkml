view: filtrofiltro {
    derived_table: {
      sql:
      SELECT
        customer_id,
        SUM(sale_price) AS lifetime_spend
      FROM
        order
      WHERE
        {% condition order_region %} order.region {% endcondition %}
      GROUP BY 1
    ;;
    }
    filter: order_region {
      type: string
      sql: {% condition order_region %} ${region} {% endcondition %} ;;
    }
    dimension: region {
      type: string
      sql: ${TABLE}.region ;;
    }
 }
#probando git 1
