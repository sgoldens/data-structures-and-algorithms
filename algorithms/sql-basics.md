# SQL Basics

SQL stands for Structured Query Language, and is used to communicate with databases.

ANSI (American National Standards Institute) declares SQL the standard for relational databases.

SQL commands for "Select", "Insert", "Update", "Delete", "Create", and "Drop" can be used to accomplish almost everything that one needs to do with a database.

Relational databases contains objects called tables, which stores the databases data using columns and rows. Columns contain the column name, data type, and any other attributes for that column. Rows contain the records (or data) for the columns.

## SELECT

The **select** statement is used to query the database to retrieve selected data matching the criteria you provide.

The **SELECT** statement has five main clauses to choose from, although, **FROM** is the only required clause. Each of the clauses have a vast selection of options, parameters, etc. The clauses will be listed below, but each of them will be covered in more detail later in the tutorial.

 Here is the format of the SELECT statement:

```SQL
 SELECT [ALL | DISTINCT] column1[,column2] 
  FROM table1[,table2] 
  [WHERE "conditions"] 
  [GROUP BY "column-list"] 
  [HAVING "conditions] 
  [ORDER BY "column-list" [ASC | DESC] ] 
```

```SQL
SELECT "column1"
  [,"column2",etc] 
  FROM "tablename"
  [WHERE "condition"];
  [] = optional
```

The column names that follow the select keyword determine which columns will be returned in the results. You can select as many column names that you'd like, or you can use a "\*" to select all columns.

Conditional selections used in the where clause:

```SQL
= Equal
> Greater than
< Less than
>=  Greater than or equal
<=  Less than or equal
<>  Not equal to
LIKE  *See note below
```

The LIKE pattern matching operator can also be used in the conditional selection of the where clause. Like is a very powerful operator that allows you to select only rows that are "like" what you specify. The percent sign "%" can be used as a wild card to match any possible character that might appear before or after the characters specified. For example:

```SQL
SELECT first, last, city
   FROM empinfo
   WHERE first LIKE 'Er%';
```

This SQL statement will match any first names that start with 'Er'. Strings must be in single quotes.

Or you can specify,

```SQL
SELECT first, last
   FROM empinfo
   WHERE last LIKE '%s';
```

This statement will match any last names that end in a 's'.

```SQL
SELECT first,
        last,
        city,
        age
FROM empinfo
WHERE city LIKE '%an Francisc%';
```

This statemnt will match any records which have a city containing 'an Francisc', e.g. 'San Francisco'

**ALL** and **DISTINCT** are keywords used to select either **ALL** (default) or the "**distinct**" or unique records in your query results. If you would like to retrieve just the unique records in specified columns, you can use the "**DISTINCT**" keyword. **DISTINCT** will discard the duplicate records for the columns you specified after the "SELECT" statement: For example:

```SQL
SELECT DISTINCT age 
 
FROM employee_info;
```

This statement will return all of the unique ages in the employee_info table.

**ALL** will display "all" of the specified columns including all of the duplicates. The **ALL** keyword is the default if nothing is specified.

## CREATE

The **CREATE TABLE** statement is used to create a new table. Here is the format of a simple create table statement:

```SQL
CREATE TABLE "tablename"
("column1" "data type",
 "column2" "data type",
 "column3" "data type");
```

with optional additional constraints:

```SQL
CREATE TABLE "tablename"
("column1" "data type" 
         [constraint],
 "column2" "data type" 
         [constraint],
 "column3" "data type" 
        [constraint]);
```

**Example:**
```SQL
CREATE TABLE employee
(first varchar(15),
 last varchar(20),
 age number(3),
 address varchar(30),
 city varchar(20),
 state varchar(20));
```

Here are the most common Data types:

 Data type | Description
 --- | ---
 char(size) | Fixed-length character string. Size is specified in parenthesis. Max 255 bytes.
 varchar(size) | Variable-length character string. Max size is specified in parenthesis.
 number(size) | Number value with a max number of column digits specified in parenthesis.
 date | Date value
 number(size,d) | Number value with a maximum number of digits of "size" total, with a maximum number of "d" digits to the right of the decimal.

Some popular constraints include:
  
Constraint | Description
--- | ---
'unique' | specifies that no two records can be the same in the specified column
'primary key' | defines a unique identification of each record (or row) in a table.
'not null' | specifies that the associated value must not be blank.

```SQL
CREATE TABLE 
 myemployees_sg0224(
   firstname varchar(20), 
   lastname varchar(20),
   title varchar(5), 
   age number(3), 
   salary number(10));
```

## INSERT

The **insert** statement is used to insert or add a row of data into the table.

```SQL
INSERT INTO "tablename"
 (first_column,...last_column)
  VALUES (first_value,...last_value);
```

Example:
```
INSERT INTO employee
  (first, last, age, address, city, state)
  VALUES ('Sasha', 'Goldenson', 35, '123 Fake St.', 'San Francisco', 'CA')
```

## UPDATE

The **update** statement is used to update or change records that match a specified criteria. This is accomplished by carefully constructing a where clause.

```SQL
UPDATE "tablename"
SET "columnname" = 
    "newvalue"
 [,"nextcolumn" = 
   "newvalue2"...]
WHERE "columnname" 
  OPERATOR "value" 
 [and|or "column" 
  OPERATOR "value"];

 [] = optional
```

Examples:

```SQL
UPDATE phone_book
  SET area_code = 623
  WHERE prefix = 979;

UPDATE phone_book
  SET last_name = 'Smith', prefix=555, suffix=9292
  WHERE last_name = 'Jones';

UPDATE employee
  SET age = age+1
  WHERE first_name='Mary' and last_name='Williams';
```

## DELETE

The **delete** statement is used to delete records or rows from the table.

```SQL
DELETE from "tablename"

WHERE "columnname" 
  OPERATOR "value" 
[and|or "column" 
  OPERATOR "value"];

[ ] = optional
```

**Note:** If you leave off the **where** clause for delete, all records will be deleted!


## DROP TABLE

The **drop table** command is used to delete a table and all rows in the table.

```SQL
DROP TABLE myemployees_sg0224;
```

#### Sources referenced:

- [SQLCourse.com](http://www.sqlcourse.com)
- 