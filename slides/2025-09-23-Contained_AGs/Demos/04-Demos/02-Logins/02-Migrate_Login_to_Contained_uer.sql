/* List local user on instance level */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [master]
GO
CREATE LOGIN [migrate_user] WITH PASSWORD = 'Start123';
GO

USE [contained1_db]
GO
CREATE USER [migrate_user] FROM LOGIN [migrate_user];
ALTER ROLE [db_owner] ADD MEMBER [migrate_user];
GO


/* List local user on instance level */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [contained1_db]
GO
EXECUTE sp_migrate_user_to_contained   
        @username = N'migrate_user',  
        @rename = N'keep_name',  
        @disablelogin = N'do_not_disable_login';  
GO

/* List users in daabse contained1_db */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [contained1_db]
GO
SELECT name
    , sid
    , type_desc
    , authentication_type_desc
FROM sys.database_principals
WHERE name = 'migrate_user'
GO

-- SID: 0x5FCDF65D5F6AD742BB4886ABCB73F33D

/* List local user on instance level */
:CONNECT 127.0.0.1,1435 -U migrate_user -P Start123 
USE [contained1_db]
GO
