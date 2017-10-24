DROP DATABASE IF EXISTS user_activity;

CREATE DATABASE user_activity;

USE user_activity;

CREATE TABLE user (
  id INT NOT NULL AUTO_INCREMENT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(255),
  password VARCHAR(255) NOT NULL,
  UNIQUE(email),
  PRIMARY KEY (id)
);

CREATE TABLE login (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  logged_in_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  device_name VARCHAR(255),
  device_os VARCHAR(255),
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE address (
  id INT NOT NULL AUTO_INCREMENT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  user_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  zip INT NOT NULL,
  type ENUM('billing', 'shipping'),
  is_default TINYINT DEFAULT 0,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE card (
  id INT NOT NULL AUTO_INCREMENT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  user_id INT NOT NULL,
  num VARCHAR(255) NOT NULL,
  expires DATE NOT NULL,
  holder VARCHAR(255) NOT NULL,
  billing_address_id INT NOT NULL,
  cvs INT NOT NULL,
  is_default TINYINT DEFAULT 0,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (billing_address_id) REFERENCES address(id)
);

CREATE TABLE user_order (
  id INT NOT NULL AUTO_INCREMENT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  purchased_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  user_id INT NOT NULL,
  status ENUM('in_process', 'placed'),
  card_id INT NOT NULL,
  shipping_address_id INT NOT NULL,
  billing_address_id INT NOT NULL,
  delivery_type ENUM('next_day', 'standard', 'expedited'),
  delivery_cost INT DEFAULT 0,
  total_price INT,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (card_id) REFERENCES card(id),
  FOREIGN KEY (shipping_address_id) REFERENCES address(id),
  FOREIGN KEY (billing_address_id) REFERENCES address(id)
);

CREATE TABLE order_item (
  id INT NOT NULL AUTO_INCREMENT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  order_id INT NOT NULL,
  item_id INT NOT NULL,
  quantity INT DEFAULT 1,
  listed_price INT,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES user_order(id)
);

CREATE TABLE search (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  searched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  query VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE search_result (
  id INT NOT NULL AUTO_INCREMENT,
  search_id INT NOT NULL,
  item_id INT NOT NULL,
  position INT NOT NULL,
  clicked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (search_id) REFERENCES search(id)
);