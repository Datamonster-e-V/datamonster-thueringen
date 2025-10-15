/*Backup locally on instasnce level*/
:CONNECT 127.0.0.1,1433 -U sa -P Start123

BACKUP DATABASE [demo_db] TO DISK = '/var/opt/mssql/data/demo_db.bak' WITH INIT, COMPRESSION; 
GO

/*List backups on instasnce level*/
:CONNECT 127.0.0.1,1433 -U sa -P Start123

USE [msdb]
GO
SELECT bs.server_name
    , bs.database_name
    , bs.type
    , bs.backup_start_date
    , bmf.physical_device_name
FROM dbo.backupset bs
    INNER JOIN dbo.backupmediafamily bmf
        ON bs.media_set_id = bmf.media_set_id
WHERE bs.database_name = 'demo_db'
ORDER BY bs.backup_start_date desc
GO

USE [ag1_msdb]
GO
SELECT bs.server_name
    , bs.database_name
    , bs.type
    , bs.backup_start_date
    , bmf.physical_device_name
FROM dbo.backupset bs
    INNER JOIN dbo.backupmediafamily bmf
        ON bs.media_set_id = bmf.media_set_id
WHERE bs.database_name = 'demo_db'
ORDER BY bs.backup_start_date desc
GO

/*backup locally on contained availability group*/
:CONNECT 127.0.0.1,1435 -U sa -P Start123
BACKUP DATABASE [demo_db] TO DISK = '/var/opt/mssql/data/demo_db_AG.bak' WITH INIT, COMPRESSION; 
GO

/*backup locally on contained availability group*/
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [msdb]
GO
SELECT bs.server_name
    , bs.database_name
    , bs.type
    , bs.backup_start_date
    , bmf.physical_device_name
FROM dbo.backupset bs
    INNER JOIN dbo.backupmediafamily bmf
        ON bs.media_set_id = bmf.media_set_id
WHERE bs.database_name = 'demo_db'
ORDER BY bs.backup_start_date desc
GO


