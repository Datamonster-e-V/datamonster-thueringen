	
#Get Script Path
$CurrentPath = ($MyInvocation.MyCommand.Path | Split-Path -Parent)
CD $CurrentPath 

#Create Endpoint on sql1
Invoke-Sqlcmd -ServerInstance "127.0.0.1,10433" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\02-Create_Endpoint.sql

#Create Endpoint on sql2
Invoke-Sqlcmd -ServerInstance "127.0.0.1,10443" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\02-Create_Endpoint.sql

#Create Availability Group on sql1
Invoke-Sqlcmd -ServerInstance "127.0.0.1,10433" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\03-Create_AG.sql

#Join sql2 to availability group
Invoke-Sqlcmd -ServerInstance "127.0.0.1,10443" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\04-Add_Replica.sql

#Create Availability Group on sql1
Invoke-Sqlcmd -ServerInstance "127.0.0.1,10433" -Username sa -Password Start123 -TrustServerCertificate -InputFile .\05-Add_Listener.sql
