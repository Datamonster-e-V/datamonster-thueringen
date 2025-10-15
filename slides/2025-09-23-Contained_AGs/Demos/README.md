# Workshops
Workshops for SQL Server Contained Availability Groups

Requirements:
- Installed Docker (On Windows install WSL before)
- Access to docker hup to download the latest docker image

Setup:
1. go to subfolder 01_Setup_Container and execute Powershell scripts 01-03 to download and build docker containers
2. go to subfolder 02_Setup_CAG and exeute Powershell script 01 to create the CAG
3. go to subfolder 03_Setup_Databases and exeute Powershell script 01 to create multiple Databases on CAG and local
4. Failover between the nodes must be done manually by Script found under 04_Demos\01_Failover

