# RubyArchives

Ruby Archives is a lightweight module that allows you to interact with your Sqlite3 database in a simple way without using much SQL code.

## Getting Started:

### For a quick preview:

** You need to have Ruby installed in your machine.

1. Download or copy the repo.
2. Run ```bundle install``` in the directory.
3. To get the sqlite3 test database set up run ```cat corgis.sql | sqlite3 corgis.db```.
4. run ```pry``` to start the pry repl and then ```load 'sample.rb'``` to load the file.
5. Try the different instance and class methods below and discover the power of Ruby Archives!

examples:
![Pry Sample](https://github.com/cabral-ramon/RubyArchives/tree/master/images/Pry_sample.png)

association examples:
![Association_samples](https://github.com/cabral-ramon/RubyArchives/tree/master/images/Association_samples.png)
## Methods included:

### Instance methods:
* #save - saves a new row into the database.
* #update(*attr) - updates attributes of an entry in a table.
* #destroy - Removes the column from the table

### Association and relational functions
* belongs_to(method_name, optional_hash)
* has_many(method_name, optional_hash)
* has_one_through(method_name, through_source, end_source)

Below are some examples how you would write associations using these methods:
![Gorgi Associations](https://github.com/cabral-ramon/RubyArchives/tree/master/images/Corgi_class.png)

Adding these associations to your models will give them access to the methods passed
in to each function respectively.

### Class methods:
* ::where(col_name: val) - searches for columns in a table that match the value given
* ::find(:id) - queries the table and finds the row at the given ID.
* ::all - returns all of the data for the given table.
* ::columns - returns the column titles of the table.
* ::first - returns the first row in the table.
* ::last - return the last row in the table.
