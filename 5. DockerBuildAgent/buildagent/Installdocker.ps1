Invoke-WebRequest "https://master.dockerproject.org/windows/x86_64/docker.zip" -OutFile "$env:TEMP\docker.zip" -UseBasicParsing
 
Expand-Archive -Path "$env:TEMP\docker.zip" -DestinationPath $env:ProgramFiles
 
# Add path to this PowerShell session immediately
$env:path += ";$env:ProgramFiles\Docker"
 
# For persistent use after a reboot
$Path = [Environment]::GetEnvironmentVariable("Path",[System.EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("Path", $Path + ";$env:ProgramFiles\Docker", [EnvironmentVariableTarget]::Machine)