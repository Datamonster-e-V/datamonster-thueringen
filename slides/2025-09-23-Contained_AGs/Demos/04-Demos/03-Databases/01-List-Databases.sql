/*List local user on instance level*/
:CONNECT 127.0.0.1,1433 -U sa -P Start123

SELECT @@servername as server_name
    , name as database_name
    , database_id
    , compatibility_level
    , collation_name
    , recovery_model_desc
    , containment_desc
    , physical_database_name
    , snapshot_isolation_state_desc
    , is_trustworthy_on
    , is_db_chaining_on
    , page_verify_option_desc
    , is_mixed_page_allocation_on
FROM sys.databases 
GO

/*List local user on contained availability group*/
:CONNECT 127.0.0.1,1435 -U sa -P Start123

SELECT @@servername as server_name
    , name as database_name
    , database_id
    , compatibility_level
    , collation_name
    , recovery_model_desc
    , containment_desc
    , physical_database_name
    , snapshot_isolation_state_desc
    , is_trustworthy_on
    , is_db_chaining_on
    , page_verify_option_desc
    , is_mixed_page_allocation_on
FROM sys.databases 
GO

