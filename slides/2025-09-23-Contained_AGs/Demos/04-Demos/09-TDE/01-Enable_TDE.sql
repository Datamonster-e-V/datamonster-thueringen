/* create database master key in contained master database */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [master];
GO
IF NOT EXISTS (SELECT name FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'SuperStrongPasswordWith1Special#';
GO

/* create certifiacte for TDE */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [master];
GO
CREATE CERTIFICATE [TDE_Cert]
    WITH SUBJECT = 'Certificate for TDE';
GO

/* create datbabase encryption key */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [demo_db];
GO
CREATE DATABASE ENCRYPTION KEY
    WITH ALGORITHM = AES_256
    ENCRYPTION BY SERVER CERTIFICATE [TDE_Cert];
GO

/* enable encryption */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [master];
GO
ALTER DATABASE [demo_db]
    SET ENCRYPTION ON;
GO


/* check encryption state */
:CONNECT 127.0.0.1,1435 -U sa -P Start123
USE [master];
GO
SELECT DB_NAME(database_id) as [database_name]
    , encryption_state_desc
    , encryption_state
    , key_algorithm
    , key_length
    , encryptor_thumbprint
    , encryptor_type
FROM sys.dm_database_encryption_keys;
GO

/* disable encryption */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [master];
GO
ALTER DATABASE [demo_db]
    SET ENCRYPTION OFF;
GO


:CONNECT 127.0.0.1,1443 -U sa -P Start123

USE [master];
GO

EXEC sp_set_session_context @key = N'external_cluster', @value = N'yes';
ALTER AVAILABILITY GROUP [ag1] FAILOVER;
GO

/* check encryption state on sql2 */
:CONNECT 127.0.0.1,1445 -U sa -P Start123
USE [master];
GO
SELECT DB_NAME(database_id) as [database_name]
    , encryption_state_desc
    , encryption_state
    , key_algorithm
    , key_length
    , encryptor_thumbprint
    , encryptor_type
FROM sys.dm_database_encryption_keys;
GO


/* list certificates */
:CONNECT 127.0.0.1,1443 -U sa -P Start123
USE [master];
GO
SELECT name
    , pvt_key_encryption_type_desc
    , issuer_name
    , subject
    , thumbprint
FROM sys.certificates

USE [ag1_master];
GO
SELECT name
    , pvt_key_encryption_type_desc
    , issuer_name
    , subject
    , thumbprint
FROM sys.certificates
GO