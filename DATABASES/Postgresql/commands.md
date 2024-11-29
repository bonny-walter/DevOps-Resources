Connecting to PostgreSQL

### Connect to PostgreSQL shell

        psql -U <username> -d <database_name>

You will be prompted to enter the password.

### Connect to PostgreSQL on a specific host and port

        psql -h <host> -p <port> -U <username> -d <database_name>

### Exit the PostgreSQL shell

        \q

Database Management

### Show all databases

        \l

### Create a new database

        CREATE DATABASE <database_name>;

### Switch to a database

        \c <database_name>

### Drop a database

        DROP DATABASE <database_name>;

Table Management

Show all tables in the current database

        \dt

### Create a table

        CREATE TABLE <table_name> (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100),
            age INT
        );

### Describe a table's structure

        \d <table_name>

### Rename a table

        ALTER TABLE <old_table_name> RENAME TO <new_table_name>;

### Drop a table

        DROP TABLE <table_name>;

Insert, Select, Update, and Delete Data

### Insert data into a table

        INSERT INTO <table_name> (name, age) VALUES ('Alice', 30);

### Select all rows from a table

        SELECT * FROM <table_name>;

### Filter data with a condition

        SELECT * FROM <table_name> WHERE age > 25;

### Update data in a table

        UPDATE <table_name> SET age = 35 WHERE name = 'Alice';

### Delete data from a table

        DELETE FROM <table_name> WHERE name = 'Alice';

Constraints and Indexing

### Add a unique constraint to a column

        ALTER TABLE <table_name> ADD CONSTRAINT unique_name UNIQUE (name);

### Create an index

        CREATE INDEX idx_name ON <table_name> (name);

### Drop an index

        DROP INDEX idx_name;

User and Role Management

### Create a new user

        CREATE USER <username> WITH PASSWORD '<password>';

### Grant privileges to a user

        GRANT ALL PRIVILEGES ON DATABASE <database_name> TO <username>;

### Revoke privileges from a user

        REVOKE ALL PRIVILEGES ON DATABASE <database_name> FROM <username>;

### List all users and roles

        \du

### Drop a user

        DROP USER <username>;

Backup and Restore

### Backup a database

        pg_dump -U <username> -d <database_name> > backup.sql

### Restore a database

        psql -U <username> -d <database_name> < backup.sql

### Backup all databases

        pg_dumpall -U <username> > all_databases.sql

### Restore all databases

        psql -U <username> < all_databases.sql

Server Information and Monitoring

### Show the current database name

        SELECT current_database();

### Show current user

        SELECT current_user;

### Check server version

        SELECT version();

### List all active connections

        SELECT * FROM pg_stat_activity;

### Terminate a specific connection

        SELECT pg_terminate_backend(<pid>);

Query Optimization

### Analyze and explain a query

        EXPLAIN ANALYZE SELECT * FROM <table_name>;

Extensions

### List installed extensions

        \dx

### Install an extension (e.g., uuid-ossp)

        CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

### Drop an extension

        DROP EXTENSION <extension_name>;
