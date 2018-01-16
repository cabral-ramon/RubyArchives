require_relative 'db_connection'
require_relative 'associatable'
require_relative 'searchable'
require 'active_support/inflector'

class SQLObject

  extend Associatable
  extend Searchable

  def self.columns
    return @columns if @columns
    cols = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT
        0
      SQL
    cols.map!(&:to_sym)
    @columns = cols
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) do
        self.attributes[col]
      end

      define_method("#{col}=") do |value|
        self.attributes[col] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= "#{self.to_s.downcase}s"
  end

  def self.all
    table = DBConnection.execute(<<-SQL)
    SELECT *
    FROM #{self.table_name}
    SQL
    self.parse_all(table)
  end

  def self.parse_all(results)
    list = []
    results.each do |attr_hash|
      list << self.new(attr_hash)
    end
    list
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL)
    SELECT * FROM #{self.table_name} WHERE id == #{id}
    SQL
    result.empty? ? nil : self.new(result[0])
  end

  def initialize(params = {})
    params.each do |col, val|
      col = col.to_sym
      if self.class.columns.include?(col)
        att = "#{col}=".to_sym
        self.send att, val
      else
        raise "unknown attribute '#{col}'"
      end
    end

  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map{ |col| self.send "#{col}"}
  end

  def insert
    col_names = self.class.columns.drop(1).map(&:to_s).join(",")
    num_question_marks = self.class.columns.drop(1).count
    question_marks = (["?"] * num_question_marks).join(',')

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
    INSERT INTO #{self.class.table_name} (#{col_names})
    VALUES (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    col_names = self.class.columns.drop(1).map{|x| x.to_s + '=?'}.join(',')
    DBConnection.execute(<<-SQL, *attribute_values.rotate)
    UPDATE #{self.class.table_name}
    SET #{col_names}
    WHERE id = ?
    SQL
  end

  def save
    self.id.nil? ? insert : update
  end
end
