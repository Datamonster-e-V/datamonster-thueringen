:SETVAR database_name local_db

:CONNECT 127.0.0.1,1433 -U sa -P Start123

USE [master];
GO

CREATE DATABASE [$(database_name)]
 CONTAINMENT = NONE
 ON  PRIMARY 
    ( NAME = N'$(database_name)_db', FILENAME = N'/var/opt/mssql/data/$(database_name).mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
    ( NAME = N'$(database_name)_log', FILENAME = N'/var/opt/mssql/data/$(database_name)_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB );
GO
ALTER DATABASE [$(database_name)] SET RECOVERY FULL;
GO

:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [master];
GO
CREATE LOGIN [admin_user] WITH PASSWORD = 'Start123';
ALTER SERVER ROLE [sysadmin] ADD MEMBER [admin_user];
GO