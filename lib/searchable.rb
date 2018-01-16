require_relative 'db_connection'
require_relative 'sql_object'

module Searchable
  def where(params)
    if params.keys.count > 1
      where_line = params.keys.map { |key| "#{key} = ?"}.join(' AND ')
    else
      where_line = params.keys.map { |key| "#{key} = ?"}.join('')
    end

    query_results = DBConnection.execute(<<-SQL, params.values)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{where_line}
    SQL

    parse_all(query_results)
  end
end
