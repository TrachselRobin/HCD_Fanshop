DROP DATABASE IF EXISTS `sektor1921-test`;
CREATE DATABASE `sektor1921-test`;

USE `sektor1921-test`;

CREATE TABLE `user` (
	`ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `surname` VARCHAR(30),
    `name` VARCHAR(30),
    `email` VARCHAR(50),
    `password` VARCHAR(255),
    `addressID` INT,
    `addressDeliveryID` INT,
    `roleID` INT,
    `member` BOOLEAN DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `address` (
    `ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `street` VARCHAR(50),
    `houseNumber` VARCHAR(10),
    `postalCode` VARCHAR(10),
    `place` VARCHAR(30)
);

CREATE TABLE `role` (
    `ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `name` VARCHAR(30)
);

CREATE TABLE `product` (
    `ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `name` VARCHAR(50),
    `description` TEXT,
    `price` DECIMAL(10, 2),
    `discount` DECIMAL(10, 2),
    `stock` INT,
    `categoryID` INT,
    `visible` BOOLEAN DEFAULT 1,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `ticket` (
    `ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `name` VARCHAR(100),
    `description` TEXT,
    `date` DATE,
    `time` TIME,
    `price` DECIMAL(10,2),
    `stock` INT,
    `visible` BOOLEAN DEFAULT 1,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE `category` (
    `ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `name` VARCHAR(50)
);

CREATE TABLE `order` (
    `ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `userID` INT,
    `addressDeliveryID` INT,
    `totalPrice` DECIMAL(10, 2),
    `status` ENUM('pending', 'shipped', 'delivered', 'cancelled'),
    `isPickup` BOOLEAN DEFAULT 0,
    `pickupCode` VARCHAR(255) UNIQUE,
    `pickupConfirmed` BOOLEAN DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `order_product` (
    `ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `orderID` INT,
    `productID` INT,
    `quantity` INT,
    `price` DECIMAL(10, 2),
    `discount` DECIMAL(10, 2),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `order_ticket` (
    `ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `orderID` INT,
    `ticketID` INT,
    `quantity` INT,
    `price` DECIMAL(10, 2),
    `pickupCode` VARCHAR(255) UNIQUE,
    `scanned` BOOLEAN DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `image` (
    `ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `productID` INT,
    `imagePath` VARCHAR(255),
    `isMain` BOOLEAN DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `review` (
    `ID` INT AUTO_INCREMENT, PRIMARY KEY (`ID`),
    `productID` INT,
    `userID` INT,
    `rating` INT CHECK (rating >= 1 AND rating <= 5),
    `comment` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE PROCEDURE SelectAllFromTable(IN tableName VARCHAR(255))
BEGIN
    SET @query = CONCAT('SELECT * FROM ', tableName);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

CREATE PROCEDURE SelectFromTableByID(IN tableName VARCHAR(255), IN id INT)
BEGIN
    SET @query = CONCAT('SELECT * FROM ', tableName, ' WHERE ID = ?');
    PREPARE stmt FROM @query;
    SET @id = id;
    EXECUTE stmt USING @id;
    DEALLOCATE PREPARE stmt;
END //

CREATE PROCEDURE InsertIntoTable(IN tableName VARCHAR(255), IN columns VARCHAR(255), IN values VARCHAR(255))
BEGIN
    SET @query = CONCAT('INSERT INTO ', tableName, ' (', columns, ') VALUES (', values, ')');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

CREATE PROCEDURE UpdateTableByID(IN tableName VARCHAR(255), IN id INT, IN columnsValues VARCHAR(255))
BEGIN
    SET @query = CONCAT('UPDATE ', tableName, ' SET ', columnsValues, ' WHERE ID = ?');
    PREPARE stmt FROM @query;
    SET @id = id;
    EXECUTE stmt USING @id;
    DEALLOCATE PREPARE stmt;
END //

CREATE PROCEDURE DeleteFromTableByID(IN tableName VARCHAR(255), IN id INT)
BEGIN
    SET @query = CONCAT('DELETE FROM ', tableName, ' WHERE ID = ?');
    PREPARE stmt FROM @query;
    SET @id = id;
    EXECUTE stmt USING @id;
    DEALLOCATE PREPARE stmt;
END //

CREATE PROCEDURE SelectFromTableByColumn(IN tableName VARCHAR(255), IN columnName VARCHAR(255), IN value VARCHAR(255))
BEGIN
    SET @query = CONCAT('SELECT * FROM ', tableName, ' WHERE ', columnName, ' = ?');
    PREPARE stmt FROM @query;
    SET @value = value;
    EXECUTE stmt USING @value;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- insrt some values for category role etc.
INSERT INTO `role` (`name`) VALUES
('Administrator'),
('Moderator'),
('Mitglied'),
('Benutzer');

-- categories for some fanshop products
INSERT INTO `category` (`name`) VALUES
('Fanartikel'),
('Kleidung'),
('Zubehör'),
('Sonderangebote');

