/* what can a sysadmin do on AG level */

:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [local_db];
GO
SELECT DB_NAME();
GO
SELECT name FROM sys.databases;
GO

/* create database user in local database mapped from a AG User */
:CONNECT 127.0.0.1,1435 -U sa -P Start123
USE [local_db];
GO
CREATE USER [demo_user] FROM LOGIN [demo_user];
ALTER ROLE [db_owner] ADD MEMBER [demo_user];
GO

/* hwo does it look like from AG level */
:CONNECT 127.0.0.1,1435 -U sa -P Start123
USE [local_db];
GO
sp_helpuser;
GO

/* hwo does it look like from instance level */
:CONNECT 127.0.0.1,1433 -U sa -P Start123

USE [local_db];
GO
sp_helpuser;
GO

/* logon AG with demo_user and access local_db */
:CONNECT 127.0.0.1,1435 -U demo_user -P Start123

USE [local_db];
GO
SELECT DB_NAME();
GO