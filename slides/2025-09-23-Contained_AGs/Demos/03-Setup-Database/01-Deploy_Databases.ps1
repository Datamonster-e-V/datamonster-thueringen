	
#Get Script Path
$CurrentPath = ($MyInvocation.MyCommand.Path | Split-Path -Parent)
CD $CurrentPath 

#Prepare contained databases
Invoke-Sqlcmd -ServerInstance "127.0.0.1,1433" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\02-Allow_Contained_database.sql
Invoke-Sqlcmd -ServerInstance "127.0.0.1,1443" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\02-Allow_Contained_database.sql

#Create contained database 1 on availability group
Invoke-Sqlcmd -ServerInstance "127.0.0.1,1433" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\03-Contained_Database1.sql

#Create contained database 2 on availability group
Invoke-Sqlcmd -ServerInstance "127.0.0.1,1433" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\04-Contained_Database2.sql

#Create demo_db as not contained database in availability_group
Invoke-Sqlcmd -ServerInstance "127.0.0.1,1433" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\05-demo_db.sql

#Create local_db on instance level
Invoke-Sqlcmd -ServerInstance "127.0.0.1,1433" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\06-local_db.sql
