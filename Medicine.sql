CREATE DATABASE Medicine;

USE Medicine;

CREATE TABLE requesting_chemist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL
);

CREATE TABLE supplying_chemist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL
);

CREATE TABLE delivery_person (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT ,              
    supplying_chemist_id INT ,  
    medicine_name VARCHAR(100) ,     
    quantity INT , 
    price FLOAT  ,  
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Accepted', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    requesting_chemist_address VARCHAR(255) ,
    supplying_chemist_address VARCHAR(255),
    delivery_person_id INT,              
    FOREIGN KEY (request_id) REFERENCES requesting_chemist(id),  
    FOREIGN KEY (supplying_chemist_id) REFERENCES supplying_chemist(id),
    FOREIGN KEY (delivery_person_id) REFERENCES delivery_person(id)     
);

DROP TABLE orders;
select * from orders;
select * from delivery_person;
select * from requesting_chemist;
select * from supplying_chemist;
