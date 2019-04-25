param(
    [Parameter(Mandatory=$true)]
    [string]$tfsPoolName,
    [Parameter(Mandatory=$true)]
    [string]$tfsAgentName
)

docker run -d -m 4GB --name $tfsAgentName --mount type=bind,source=c:\myagent\,target=c:\setup\_work --storage-opt "size=50GB" -e TFS_URL=https://dev.azure.com/jakob -e TFS_PAT=eedpnydhyg4tilz7pxyp44fgst3wnxflde2ftlyist75i27zhsga -e TFS_POOL_NAME=$tfsPoolName -e TFS_AGENT_NAME=$tfsAgentName -e SA_PASSWORD=1qaz2WSX -v \\.\pipe\docker_engine:\\.\pipe\docker_engine -it buildagent