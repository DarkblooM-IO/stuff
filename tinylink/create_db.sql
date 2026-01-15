-- create base db
DROP DATABASE IF EXISTS tinylink;
CREATE DATABASE tinylink;
USE tinylink;

-- initiate table for redirections
CREATE TABLE redirects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  destination VARCHAR(512) NOT NULL
);

-- create example entry (remove this for production)
INSERT INTO redirects (destination) VALUES ('https://example.com');
