DROP DATABASE IF EXISTS tinylink;
CREATE DATABASE tinylink;
USE tinylink;

CREATE TABLE redirects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  destination VARCHAR(512) NOT NULL
);

INSERT INTO redirects (destination) VALUES ('https://example.com');
