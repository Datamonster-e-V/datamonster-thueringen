:CONNECT 127.0.0.1,1443 -U sa -P Start123

USE [master];
GO

EXEC sp_set_session_context @key = N'external_cluster', @value = N'yes';
ALTER AVAILABILITY GROUP [ag1] FAILOVER;
GO