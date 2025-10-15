
:SETVAR database_name contained1_db

:CONNECT 127.0.0.1,1433 -U sa -P Start123

USE [master];
GO

CREATE DATABASE [$(database_name)]
 CONTAINMENT = PARTIAL
 ON  PRIMARY 
    ( NAME = N'$(database_name)_db', FILENAME = N'/var/opt/mssql/data/$(database_name).mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
    ( NAME = N'$(database_name)_log', FILENAME = N'/var/opt/mssql/data/$(database_name)_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 COLLATE German_PhoneBook_CI_AS;
GO
ALTER DATABASE [$(database_name)] SET RECOVERY FULL; 
GO

BACKUP DATABASE [$(database_name)] to DISK = 'NUL';
BACKUP LOG [$(database_name)] to DISK = 'NUL';
GO

ALTER AVAILABILITY GROUP [ag1] ADD DATABASE [$(database_name)];
GO

:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [$(database_name)];
GO
CREATE USER [contained_user] WITH PASSWORD = 'Start123';
ALTER ROLE [db_owner] ADD MEMBER [contained_user];
GO

