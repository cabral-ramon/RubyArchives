# RubyArchives

Ruby Archives is a lightweight module that allows you to interact with your Sqlite3 database in a simple way without using much SQL code.

##Methods included:

###Instance methods:
*#save - saves a new row into the database.
*#find(:id) - queries the table and finds the row at the given ID.
*#all - returns all of the data for the given table.
*#update(*attr) - updates attributes of an entry in a table.
*#destroy - Removes the column from the table

###Association and relational functions
*belongs_to
*has_many
*has_one_through
