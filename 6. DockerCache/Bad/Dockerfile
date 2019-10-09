FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2019

WORKDIR c:\\temp
RUN wget https://nodejs.org/dist/v8.11.3/node-v8.11.3-x64.msi -outfile node.msi
RUN start-process msiexec.exe -Wait -ArgumentList '/i node.msi /qn ADDLOCAL=ALL'
RUN remove-item node.msi
