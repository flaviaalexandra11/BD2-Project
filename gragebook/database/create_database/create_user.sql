CREATE USER 'flavia'@'localhost' IDENTIFIED BY 'parola';
GRANT ALL PRIVILEGES ON * . * TO 'flavia'@'localhost';

SET GLOBAL log_bin_trust_function_creators = 1;