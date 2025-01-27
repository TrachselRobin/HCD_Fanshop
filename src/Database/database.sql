DROP DATABASE IF EXISTS mydb;
CREATE DATABASE mydb;

USE mydb;

CREATE TABLE test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL
);

INSERT INTO test (message) VALUES ('Hi from database');