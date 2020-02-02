# escape=`
FROM buildagentbase:sqlexpress-windowsservercore-ltsc2019

###################################################################
#
# 1.  Visual Studio 2017 Build Tools
# 2.  Azure DevOps agent 2.141.1
# 3.  Node 8.11
# 5.  Chocolatey 2.8.5.130
# 6.  WebDeploy 3.6
# 7.  NuGet CLI 4.9.2
# 8.  Microsoft.Data.Tools.MSBuild targets 10.0.61804.210
# 9. .NET Core SDK 2.2.100
# 10. Docker CLI
#
###################################################################

# Install Visual Studio 2017 Build Tools
COPY Install.cmd C:\TEMP\
ADD https://aka.ms/vscollect.exe C:\TEMP\collect.exe

ARG CHANNEL_URL=https://aka.ms/vs/15/release/channel
ADD ${CHANNEL_URL} C:\TEMP\VisualStudio.chman

ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe
RUN C:\TEMP\Install.cmd C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --channelUri C:\TEMP\VisualStudio.chman `
    --installChannelUri C:\TEMP\VisualStudio.chman `
    --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools `
    --add Microsoft.Net.Component.3.5.DeveloperTools `
    --add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools `
    --add Microsoft.Net.ComponentGroup.TargetingPacks.Common `
    --add Microsoft.VisualStudio.Component.TestTools.BuildTools `
    --add Microsoft.VisualStudio.Workload.NodeBuildTools `
    --add Microsoft.VisualStudio.Component.TypeScript.2.8 `
    --add Microsoft.VisualStudio.Workload.NetCoreBuildTools `    
    --add Microsoft.VisualStudio.Workload.WebBuildTools `
    --add Microsoft.VisualStudio.Workload.MSBuildTools `
    --add Microsoft.VisualStudio.Workload.DataBuildTools


# Install AzureDevOps Agent 2.141.1
WORKDIR c:/sql
COPY start.ps1 .

WORKDIR c:/setup
ADD https://vstsagentpackage.azureedge.net/agent/2.141.1/vsts-agent-win-x64-2.141.1.zip .
COPY InstallAgent.ps1 .
COPY ConfigureAgent.ps1 .
SHELL ["cmd", "/S", "/C"]
RUN powershell -noexit "& "".\InstallAgent.ps1"""

# Install Node.js
ADD https://nodejs.org/dist/v8.11.3/node-v8.11.3-x64.msi C:\TEMP\node-install.msi
RUN start /wait msiexec.exe /i C:\TEMP\node-install.msi /l*vx "%TEMP%\MSI-node-install.log" /qn ADDLOCAL=ALL

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install Chocolatey, WebDeploy, NuGet, MSBuild Data Tools
RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force; `
    Install-Package nuget.commandline -RequiredVersion 4.9.2 -Force; `
    & C:\Chocolatey\bin\nuget install Microsoft.Data.Tools.Msbuild -Version 10.0.61804.210

# Install .NET Core SDK 2.2.100
ENV DOTNET_SDK_VERSION 2.2.100

RUN Invoke-WebRequest -OutFile dotnet.zip https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$Env:DOTNET_SDK_VERSION/dotnet-sdk-$Env:DOTNET_SDK_VERSION-win-x64.zip; `
    $dotnet_sha512 = '87776c7124cd25b487b14b3d42c784ee31a424c7c8191ed55810294423f3e59ebf799660864862fc1dbd6e6c8d68bd529399426811846e408d8b2fee4ab04fe5'; `
    if ((Get-FileHash dotnet.zip -Algorithm sha512).Hash -ne $dotnet_sha512) { `
        Write-Host 'CHECKSUM VERIFICATION FAILED!'; `
        exit 1; `
    }; `
    `
    Expand-Archive dotnet.zip -force -DestinationPath $Env:ProgramFiles\dotnet; `
    Remove-Item -Force dotnet.zip

 RUN setx /M PATH $($Env:PATH + ';' + $Env:ProgramFiles + '\dotnet')

#Install Docker CLI
COPY InstallDocker.ps1 .
SHELL ["cmd", "/S", "/C"]
RUN powershell -noexit "& "".\InstallDocker.ps1"""

# Configure and start Azure DevOps agent
CMD powershell -noexit .\ConfigureAgent.ps1
