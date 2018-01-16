CREATE TABLE corgis (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER,

  FOREIGN KEY(owner_id) REFERENCES human(id)
);

CREATE TABLE humans (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  house_id INTEGER,

  FOREIGN KEY(house_id) REFERENCES human(id)
);

CREATE TABLE houses (
  id INTEGER PRIMARY KEY,
  address VARCHAR(255) NOT NULL
);

INSERT INTO
  houses (id, address)
VALUES
  (1, "100 Main St"), (2, "10 Columbus Dr");

INSERT INTO
  humans (id, fname, lname, house_id)
VALUES
  (1, "John", "Smith", 1),
  (2, "Odell", "Beckham", 1),
  (3, "Aaron", "Rodgers", 2),
  (4, "Dogless", "Human", NULL);

INSERT INTO
  corgis (id, name, owner_id)
VALUES
  (1, "Bark Obama", 1),
  (2, "J.K. Growling", 2),
  (3, "William Shakespaw", 3),
  (4, "A-fleas Ansari", 3),
  (5, "Brad Sit", NULL);
