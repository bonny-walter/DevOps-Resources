Basic MySQL Commands

### Connect to MySQL server

        mysql -u <username> -p

        You will be prompted to enter the password.

### Show all databases

        SHOW DATABASES;

### Switch to a database

        USE <database_name>;

### Show all tables in the current database

        SHOW TABLES;

### Create a new database

        CREATE DATABASE <database_name>;

### Drop a database

        DROP DATABASE <database_name>;

Table Operations

### Create a table

        CREATE TABLE <table_name> (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            age INT NOT NULL
        );

### View table structure (schema)

        DESCRIBE <table_name>;

### Rename a table

        RENAME TABLE <old_table_name> TO <new_table_name>;

### Drop a table

            DROP TABLE <table_name>;

Insert, Select, Update, and Delete Data

### Insert data into a table

        INSERT INTO <table_name> (name, age) VALUES ('Alice', 30);

### Select all data from a table

        SELECT * FROM <table_name>;

### Filter data with a condition

        SELECT * FROM <table_name> WHERE age > 25;

### Update data in a table

        UPDATE <table_name> SET age = 35 WHERE name = 'Alice';

### Delete data from a table

        DELETE FROM <table_name> WHERE name = 'Alice';

Indexes

### Create an index

        CREATE INDEX idx_name ON <table_name> (name);

### Show indexes on a table

        SHOW INDEX FROM <table_name>;

### Drop an index

        DROP INDEX idx_name ON <table_name>;

User Management

### Create a new user

        CREATE USER '<username>'@'localhost' IDENTIFIED BY '<password>';

### Grant privileges to a user

        GRANT ALL PRIVILEGES ON <database_name>.* TO '<username>'@'localhost';
        FLUSH PRIVILEGES;

### Revoke privileges from a user

        REVOKE ALL PRIVILEGES, GRANT OPTION FROM '<username>'@'localhost';

### Show all users

        SELECT User, Host FROM mysql.user;

### Drop a user

        DROP USER '<username>'@'localhost';

Performance and Monitoring

### Show running processes

        SHOW PROCESSLIST;

### Kill a process

        KILL <process_id>;

### nable query logging

        SET GLOBAL general_log = 'ON';

### Disable query logging

        SET GLOBAL general_log = 'OFF';

Backup and Restore

### Backup a database

        mysqldump -u <username> -p <database_name> > backup.sql

### Restore a database

        mysql -u <username> -p <database_name> < backup.sql

Exit MySQL Shell

### Quit MySQL

        EXIT;
