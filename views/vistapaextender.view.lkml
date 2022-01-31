view: vistapaextender {
  extension: required #which means that this view cannot be joined to other views,
                      #and thus will not be visible to users.
                      #To use this view, you must integrate it into another view using the extends parameter,
                      #which you do in the next section.


  #sql_table_name: looker_db.events ;; si se quiere extender de la misma vista (cre0)
  #3the extending view will use its own settings, overriding the settings of the view being extended.

 }
