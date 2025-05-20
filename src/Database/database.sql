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

INSERT INTO `address` (`street`, `houseNumber`, `postalCode`, `place`) VALUES
('Musterstraße', '10', '8000', 'Zürich'),
('Beispielweg', '5A', '3000', 'Bern'),
('Hauptstraße', '23', '4000', 'Basel');

INSERT INTO `product` (`name`, `description`, `price`, `discount`, `stock`, `categoryID`) VALUES
('Fankappe', 'Schwarze Kappe mit Logo', 19.90, 0.00, 100, 1),
('Trikot 2025', 'Offizielles Heimtrikot der Saison 2025', 79.90, 5.00, 50, 2),
('Schal', 'Winter-Schal in Vereinsfarben', 24.90, 2.00, 80, 1);

INSERT INTO `ticket` (`name`, `description`, `date`, `time`, `price`, `stock`) VALUES
('Heimspiel gegen FC X', 'Saisonspiel', '2025-06-01', '18:00:00', 29.90, 200),
('Auswärtsspiel bei FC Y', 'Reisespiel', '2025-06-10', '20:00:00', 24.90, 150);

INSERT INTO `order` (`userID`, `addressDeliveryID`, `totalPrice`, `status`, `isPickup`, `pickupCode`, `pickupConfirmed`) VALUES
(1, 1, 99.80, 'pending', 1, 'PICKUP123', 0),
(1, 2, 59.90, 'shipped', 0, 'PICKUP456', 1);

INSERT INTO `order_product` (`orderID`, `productID`, `quantity`, `price`, `discount`) VALUES
(1, 1, 2, 19.90, 0.00),
(1, 3, 1, 24.90, 2.00);

INSERT INTO `order_ticket` (`orderID`, `ticketID`, `quantity`, `price`, `pickupCode`, `scanned`) VALUES
(2, 1, 2, 29.90, 'TICKET001', 0),
(2, 2, 1, 24.90, 'TICKET002', 1);

INSERT INTO `image` (`productID`, `imagePath`, `isMain`) VALUES
(1, '/images/kappe1.jpg', 1),
(2, '/images/trikot1.jpg', 1),
(3, '/images/schal1.jpg', 1);

INSERT INTO `review` (`productID`, `userID`, `rating`, `comment`) VALUES
(1, 1, 5, 'Top Qualität, passt perfekt!'),
(2, 1, 4, 'Sehr gut, aber etwas teuer.'),
(3, 1, 3, 'Okay, aber etwas zu dünn für den Winter.');

INSERT INTO `user` (`surname`, `name`, `email`, `password`, `addressID`, `addressDeliveryID`, `roleID`, `member`) VALUES
('Müller', 'Anna', 'anna.mueller@example.com', '$2a$12$pX1BEAEy7srV.k79I86GzO1kW1nEdYxWSeae4Hdn05xzv8N4hGXq2', 1, 2, 4, 1),
('Schneider', 'Ben', 'ben.schneider@example.com', '$2a$12$pX1BEAEy7srV.k79I86GzO1kW1nEdYxWSeae4Hdn05xzv8N4hGXq2', 2, 3, 1, 1),
('Weber', 'Clara', 'clara.weber@example.com', '$2a$12$pX1BEAEy7srV.k79I86GzO1kW1nEdYxWSeae4Hdn05xzv8N4hGXq2', 3, 1, 2, 0),
('Keller', 'David', 'david.keller@example.com', '$2a$12$pX1BEAEy7srV.k79I86GzO1kW1nEdYxWSeae4Hdn05xzv8N4hGXq2', 1, 3, 3, 1);
