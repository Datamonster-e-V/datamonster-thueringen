/* Try to create database on contained availability group */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

CREATE DATABASE [demo_ag_db];
GO



/* Create database on instance level and add to contained availability group */
:CONNECT 127.0.0.1,1433 -U sa -P Start123

CREATE DATABASE [demo_ag_db];
GO
BACKUP DATABASE [demo_ag_db] TO DISK = 'Nul';
BACKUP LOG [demo_ag_db] TO DISK = 'Nul';
GO
ALTER AVAILABILITY GROUP [ag1] ADD DATABASE [demo_ag_db];
GO