/* view database properties of both master databases */

:CONNECT 127.0.0.1,1433 -U sa -P Start123

USE [master]
GO
SELECT name
	, database_id
	, compatibility_level
	, collation_name
	, snapshot_isolation_state_desc
	, recovery_model_desc
	, is_fulltext_enabled
	, is_trustworthy_on
	, is_db_chaining_on
	, is_master_key_encrypted_by_server
	, is_broker_enabled
FROM sys.databases
WHERE name in ('master','ag1_master');

/* view database properties of both msdb databases */

:CONNECT 127.0.0.1,1433 -U sa -P Start123

USE [master]
GO
SELECT name
	, database_id
	, compatibility_level
	, collation_name
	, snapshot_isolation_state_desc
	, recovery_model_desc
	, is_fulltext_enabled
	, is_trustworthy_on
	, is_db_chaining_on
	, is_master_key_encrypted_by_server
	, is_broker_enabled
FROM sys.databases
WHERE name in ('msdb','ag1_msdb');