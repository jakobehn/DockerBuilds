param(
    [Parameter(Mandatory=$true)]
    [string]$tfsPoolName,
    [Parameter(Mandatory=$true)]
    [string]$tfsAgentName
)

docker run -d -m 4GB --name $tfsAgentName --storage-opt "size=50GB" -e TFS_URL=https://dev.azure.com/jakob -e TFS_PAT=7numixrk2yead7m5wmervcqd4wmlhrj5q3pod43p5ljsi5gurikq -e TFS_POOL_NAME=$tfsPoolName -e TFS_AGENT_NAME=$tfsAgentName -e SA_PASSWORD=1qaz2WSX -it buildagent