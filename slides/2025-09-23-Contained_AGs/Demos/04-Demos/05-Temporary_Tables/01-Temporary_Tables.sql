/* Tempdb usgae from contained database 

Connection: 127.0.0.1,1435 
Username:   contained_user 
Password:   Start123
Database:   contained1_db

*/

USE [contained1_db];
GO
/* create global temporary table */
CREATE TABLE ##global_temp_table (some_text	NVARCHAR(200));
GO

/* create local temporary table */
CREATE TABLE #local_temp_table (some_text	NVARCHAR(200));
GO

/* get column information from temp tasble */
SELECT o.name as object_name
	, type_desc as object_type
	, c.name as column_name
	, t.name as type_name
	, c.max_length 
	, c.precision
	, c.collation_name
FROM tempdb.sys.objects o
INNER JOIN tempdb.sys.columns c
	ON o.object_id = c.object_id
INNER JOIN sys.types t
	ON c.system_type_id = t.system_type_id
		AND c.user_type_id = t.user_type_id
WHERE o.name like '%temp_table%';
GO

/* insert row into gobal temp table */
INSERT INTO ##global_temp_table (some_text)
VALUES ( 'This Entry is from database ' + QUOTENAME(DB_NAME()));

SELECT * FROM ##global_temp_table;

/* drop tables */
DROP TABLE ##global_temp_table;
DROP TABLE #local_temp_table;
GO



/* Access temporary table from second contained database

Connection: 127.0.0.1,1435 
Username:   contained_user 
Password:   Start123
Database:   contained2_db

*/
USE [contained2_db]
GO

SELECT * FROM ##global_temp_table
GO

INSERT INTO ##global_temp_table (some_text)
VALUES ('This Entry is from database ' + QUOTENAME(DB_NAME()));
GO