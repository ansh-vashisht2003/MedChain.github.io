
CREATE DATABASE Medicine;

USE Medicine;

CREATE TABLE requesting_chemist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) ,
    username VARCHAR(100) UNIQUE,
    password VARCHAR(100) ,
    email VARCHAR(100)  UNIQUE,
    phone_number VARCHAR(100)
);

CREATE TABLE supplying_chemist (
     id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) ,
    username VARCHAR(100) UNIQUE,
    password VARCHAR(100) ,
    email VARCHAR(100)  UNIQUE,
    phone_number VARCHAR(100)
);

CREATE TABLE delivery_person (
     id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) ,
    username VARCHAR(100) UNIQUE,
    password VARCHAR(100) ,
    email VARCHAR(100)  UNIQUE,
    phone_number VARCHAR(100)
);
drop table delivery_person;
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    request_chemist_id INT, 
    requesting_chemist_name VARCHAR(100),
    requesting_chemist_address VARCHAR(100),
    requesting_chemist_phone VARCHAR(100),
    supplying_chemist_id INT,  
    supplying_chemist_name VARCHAR(100),
    supplying_chemist_address VARCHAR(100),
    supplying_chemist_phone VARCHAR(100),
    medicine_name VARCHAR(100),     
    quantity INT, 
    price FLOAT,  
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Accepted', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    delivery_person_id INT,              
    delivery_person_name VARCHAR(100),
    delivery_person_phone VARCHAR(100),
    FOREIGN KEY (request_chemist_id) REFERENCES requesting_chemist(id),  
    FOREIGN KEY (supplying_chemist_id) REFERENCES supplying_chemist(id),
    FOREIGN KEY (delivery_person_id) REFERENCES delivery_person(id)
);

CREATE TABLE hidden_orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    hidden_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    UNIQUE(order_id)
);


drop table supplying_chemist;
drop table requesting_chemist;
drop table delivery_person;
drop table hidden_orders;
DROP TABLE orders;


select * from hidden_orders;
select * from orders;
select * from delivery_person;
select * from requesting_chemist;
select * from supplying_chemist;
