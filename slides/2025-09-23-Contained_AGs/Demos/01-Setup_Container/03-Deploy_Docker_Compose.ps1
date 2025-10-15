#Get Script Path
$CurrentPath = ($MyInvocation.MyCommand.Path | Split-Path -Parent)
CD $CurrentPath 

docker-compose -f docker-compose.yaml up -d
