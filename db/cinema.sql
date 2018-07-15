
DROP TABLE films;
DROP TABLE customers;
DROP TABLE screenings;
DROP TABLE tickets;

CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR,
  funds INT4
);

CREATE TABLE films (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR (255),
  price INT4
);

CREATE TABLE screenings (
  id SERIAL8 PRIMARY KEY,
  sart_time INT4,
  film_id INT8,
  seats INT4
);

CREATE TABLE tickets (
  id SERIAL8 PRIMARY KEY,
  customer_id INT8,
  film_id INT8
  -- customer_id INT8 REFERENCES customers(id) ON DELETE CASCADE,
  -- film_id INT8 REFERENCES film(id) ON DELETE CASCADE
);
