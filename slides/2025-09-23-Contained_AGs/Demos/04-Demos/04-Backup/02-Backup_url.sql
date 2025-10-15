/* Create Credentials for URL backup to Azure storage account */
:CONNECT 127.0.0.1,1435 -U sa -P Start123


USE [master]
GO
CREATE CREDENTIAL [https://...]
    WITH IDENTITY='SHARED ACCESS SIGNATURE'
    , SECRET = '***' 
 GO

 /* backup database to Azure storage accounts */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [master]
GO
BACKUP DATABASE [demo_db] TO URL = 'https://.../demo_db_AG.bak' WITH INIT, COMPRESSION; 
GO


/* DO a failover and repeat backup again*/
:CONNECT 127.0.0.1,1443 -U sa -P Start123

USE [master];
GO

EXEC sp_set_session_context @key = N'external_cluster', @value = N'yes';
ALTER AVAILABILITY GROUP [ag1] FAILOVER;
GO

 /* backup database to Azure storage accounts */
:CONNECT 127.0.0.1,1445 -U sa -P Start123

USE [master]
GO
BACKUP DATABASE [demo_db] TO URL = 'https://.../demo_db_AG.bak' WITH INIT, COMPRESSION; 
GO

/* try to alter the credential on sql2 */
:CONNECT 127.0.0.1,1445 -U sa -P Start123
USE [master]
GO
ALTER CREDENTIAL [https://...]
    WITH IDENTITY='SHARED ACCESS SIGNATURE'
    , SECRET = '***' 
 GO


 :CONNECT 127.0.0.1,1433 -U sa -P Start123

USE [master];
GO

EXEC sp_set_session_context @key = N'external_cluster', @value = N'yes';
ALTER AVAILABILITY GROUP [ag1] FAILOVER;
GO