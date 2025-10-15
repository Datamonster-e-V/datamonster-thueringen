/* get service master key from instance sql1 */
:CONNECT 127.0.0.1,1433 -U sa -P Start123

USE [master]
GO
SELECT name
	, key_guid
	, create_date
FROM sys.symmetric_keys
WHERE name = '##MS_ServiceMasterKey##'
GO

/* get service master key from instance sql2 */
:CONNECT 127.0.0.1,1443 -U sa -P Start123

USE [master]
GO
SELECT name
	, key_guid
	, create_date
FROM sys.symmetric_keys
WHERE name = '##MS_ServiceMasterKey##'
GO

/* get service master key from availablility group ag1 */
:CONNECT 127.0.0.1,1435 -U sa -P Start123

USE [master]
GO
SELECT name
	, key_guid
	, create_date
FROM sys.symmetric_keys
WHERE name = '##MS_ServiceMasterKey##'
GO