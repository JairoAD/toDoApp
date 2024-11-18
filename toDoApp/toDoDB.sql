CREATE DATABASE toDoDB;
USE toDoDB;

CREATE TABLE Tasks (
	id INT AUTO_INCREMENT PRIMARY KEY,      
    title VARCHAR(255) NOT NULL,             
    description TEXT,                       
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    userID INT,
    FOREIGN KEY (userID) REFERENCES Users(userID),
    is_completed BOOLEAN
);

CREATE TABLE Users (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
);