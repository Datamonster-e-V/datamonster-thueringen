/*List local user on instance level*/
:CONNECT 127.0.0.1,1433 -U sa -P Start123

SELECT NAME
    , sid
    , type_desc
    , default_database_name
    , default_language_name
FROM sys.server_principals
WHERE type='S';
GO

/*List local user on contained availability group*/
:CONNECT 127.0.0.1,1435 -U sa -P Start123

SELECT NAME
    , sid
    , type_desc
    , default_database_name
    , default_language_name
FROM sys.server_principals
WHERE type='S';
GO