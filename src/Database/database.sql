DROP DATABASE IF EXISTS mydb;
CREATE DATABASE mydb;

USE mydb;

CREATE TABLE test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL
);

DELIMITER //

CREATE PROCEDURE SelectAllFromTable(IN tableName VARCHAR(255))
BEGIN
    SET @query = CONCAT('SELECT * FROM ', tableName);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

INSERT INTO test (message) VALUES ('Hi from database');