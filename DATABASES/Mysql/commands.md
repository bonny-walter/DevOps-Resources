Connecting to the MySQL Server with the mysql Client

Once your MySQL server is up and running, you can connect to it as the superuser root with the mysql client.

###  On Linux, enter the following command at the command line terminal (for installation using generic binaries, you might need to go first to the bin folder under the base directory of your MySQL installation):

     mysql -u root -p

### On Windows, click Start, All Programs, MySQL, MySQL 5.7 Command Line Client (or MySQL 8.0 Command Line Client, respectively). If you did not install MySQL with the MySQL Installer, open a command prompt, go to the bin folder under the base directory of your MySQL installation, and issue the following command:

    C:\> mysql -u root -p

### You are then asked for the root password, which was assigned in different manners according to the way you installed MySQL. The installation and initialization instructions given above already explain the root password, but here is a quick summary:

### For installations using the MySQL Yum repository, MySQL SUSE repository, or RPM packages directly downloaded from Oracle, the generated root password is in the error log. View it with the following command:

    sudo grep 'temporary password' /var/log/mysqld.log

### For installations using the MySQL APT repository or Debian packages directly downloaded from Oracle, you should have already assigned the root password yourself

### Note

   1- Depending on the configuration you used to initialize the MySQL server, the error output might have been directed to the MySQL error log; go there and check for the password if you do not see the above message on your screen. The error log is a file with a .err extension, usually found under the server's data directory (the location of which depends on the server's configuration, but is likely to be the data folder under the base directory of your MySQL installation, or the /var/lib/mysql folder).

    2- If you have initialized the data directory with mysqld --initialize-insecure instead, the root password is empty.

### For installations on Windows using the MySQL Installer and OS X using the installer package, you should have assigned a root password yourself. 

### If you have forgotten the root password you have chosen or have problems finding the temporary root password generated for you, see How to Reset the Root ### Password.

### Once you are connected to the MySQL server, a welcome message is displayed and the mysql> prompt appears, which looks like this:

        Welcome to the MySQL monitor.  Commands end with ; or \g.
        Your MySQL connection id is 4
        Server version: 5.7.32 MySQL Community Server (GPL)

        Copyright (c) 2000, 2020, Oracle and/or its affiliates.

        Oracle is a registered trademark of Oracle Corporation and/or its
        affiliates. Other names may be trademarks of their respective
        owners.

        Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

        mysql>

### At this point, if you have logged in using a temporary root password that was generated during the installation or initialization process (which will be the case if you installed MySQL using the MySQL Yum repository, or using RPM packages or generic binaries from Oracle), change your root password by typing the following statement at the prompt:

        mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';

### Until you change your root password, you will not be able to exercise any of the superuser privileges, even if you are logged in as root.

### Here are a few useful things to remember when using the mysql client:

    You can type your SQL statements on multiple lines by pressing Enter in the middle of it. 
    Typing a semicolon (;) followed by an Enter ends an SQL statement and sends it to the server for execution; 
    the same happens when a statement is ended with \g or \G (with the latter, returned results are displayed vertically). 
    However, client commands (for example, help, quit, and clear) do not require a terminator. 

### To disconnect from the MySQL server, type QUIT or \q at the client:

        mysql> QUIT

### Some Basic Operations with MySQL

### Here are some basic operations with the MySQL server. SQL Statements explains in detail the rich syntax and functionality of the SQL statements that are illustrated below.

### Showing existing databases.  Use a SHOW DATABASES statement:

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)

### Creating a new database.  Use a CREATE DATABASE statement:

mysql> CREATE DATABASE pets;
Query OK, 1 row affected (0.01 sec)

### Check if the database has been created:

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| pets               |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

### Creating a table inside a database.  First, pick the database in which you want to create the table with a USE statement:

mysql> USE pets
Database changed

The USE statement tells MySQL to use pets as the default database for subsequent statements. Next, create a table with a CREATE TABLE statement:

CREATE TABLE cats
(
  id              INT unsigned NOT NULL AUTO_INCREMENT, # Unique ID for the record
  name            VARCHAR(150) NOT NULL,                # Name of the cat
  owner           VARCHAR(150) NOT NULL,                # Owner of the cat
  birth           DATE NOT NULL,                        # Birthday of the cat
  PRIMARY KEY     (id)                                  # Make the id the primary key
);


### Check if the table has been created with a SHOW TABLES statement:

mysql> SHOW TABLES;
+----------------+
| Tables_in_pets |
+----------------+
| cats           |
+----------------+
1 row in set (0.00 sec)

### DESCRIBE shows information on all columns of a table:

mysql> DESCRIBE cats;
+-------+------------------+------+-----+---------+----------------+
| Field | Type             | Null | Key | Default | Extra          |
+-------+------------------+------+-----+---------+----------------+
| id    | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| name  | varchar(150)     | NO   |     | NULL    |                |
| owner | varchar(150)     | NO   |     | NULL    |                |
| birth | date             | NO   |     | NULL    |                |
+-------+------------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

### Adding records into a table.  Use, for example, an INSERT...VALUES statement:

INSERT INTO cats ( name, owner, birth) VALUES
  ( 'Sandy', 'Lennon', '2015-01-03' ),
  ( 'Cookie', 'Casey', '2013-11-13' ),
  ( 'Charlie', 'River', '2016-05-21' );

### See Literal Values for how to write string, date, and other kinds of literals in MySQL.

### Retrieving records from a table.  Use a SELECT statement, and “*” to match all columns:

mysql> SELECT * FROM cats;
+----+---------+--------+------------+
| id | name    | owner  | birth      |
+----+---------+--------+------------+
|  1 | Sandy   | Lennon | 2015-01-03 |
|  2 | Cookie  | Casey  | 2013-11-13 |
|  3 | Charlie | River  | 2016-05-21 |
+----+---------+--------+------------+
3 rows in set (0.00 sec)

### To select specific columns and rows by a certain condition using the WHERE clause:

mysql> SELECT name FROM cats WHERE owner = 'Casey';
+--------+
| name   |
+--------+
| Cookie |
+--------+
1 row in set (0.00 sec)

### Deleting a record from a table.  Use a DELETE statement to delete a record from a table, specifying the criterion for deletion with the WHERE clause:

mysql> DELETE FROM cats WHERE name='Cookie';
Query OK, 1 row affected (0.05 sec)

mysql> SELECT * FROM cats;
+----+---------+--------+------------+
| id | name    | owner  | birth      |
+----+---------+--------+------------+
|  1 | Sandy   | Lennon | 2015-01-03 |
|  3 | Charlie | River  | 2016-05-21 |
+----+---------+--------+------------+
2 rows in set (0.00 sec)

### Adding or deleting a column from a table.  Use an ALTER TABLE...ADD statement to add a column. You can use, for example, an AFTER clause to specify the location of the new column:

mysql> ALTER TABLE cats ADD gender CHAR(1) AFTER name;
Query OK, 0 rows affected (0.24 sec)
Records: 0  Duplicates: 0  Warnings: 0

Use DESCRIBE to check the result:

mysql> DESCRIBE cats;
+--------+------------------+------+-----+---------+----------------+
| Field  | Type             | Null | Key | Default | Extra          |
+--------+------------------+------+-----+---------+----------------+
| id     | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| name   | varchar(150)     | NO   |     | NULL    |                |
| gender | char(1)          | YES  |     | NULL    |                |
| owner  | varchar(150)     | NO   |     | NULL    |                |
| birth  | date             | NO   |     | NULL    |                |
+--------+------------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

### SHOW CREATE TABLE shows a CREATE TABLE statement, which provides even more details on the table:

mysql> SHOW CREATE TABLE cats\G
*************************** 1. row ***************************
       Table: cats
Create Table: CREATE TABLE `cats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `owner` varchar(150) NOT NULL,
  `birth` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1
1 row in set (0.00 sec)

### Use ALTER TABLE...DROP to delete a column:

mysql> ALTER TABLE cats DROP gender;
Query OK, 0 rows affected (0.19 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> DESCRIBE cats;
+-------+------------------+------+-----+---------+----------------+
| Field | Type             | Null | Key | Default | Extra          |
+-------+------------------+------+-----+---------+----------------+
| id    | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| name  | varchar(150)     | NO   |     | NULL    |                |
| owner | varchar(150)     | NO   |     | NULL    |                |
| birth | date             | NO   |     | NULL    |                |
+-------+------------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

