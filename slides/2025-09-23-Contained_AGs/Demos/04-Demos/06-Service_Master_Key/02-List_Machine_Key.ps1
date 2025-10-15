	
#Get Script Path
$CurrentPath = ($MyInvocation.MyCommand.Path | Split-Path -Parent)
Set-Location $CurrentPath 

#Get mashine key of sql1
Write-Host "Machine Key sql1:"
docker exec -it sql1 base64 /var/opt/mssql/secrets/machine-key 

#Get mashine key of sql1
Write-Host "Machine Key sql2:"
docker exec -it sql2 base64 /var/opt/mssql/secrets/machine-key 


