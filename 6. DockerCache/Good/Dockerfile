FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2019

WORKDIR c:\\temp

RUN wget https://nodejs.org/dist/v8.11.3/node-v8.11.3-x64.msi -outfile C:\TEMP\node.msi ; \
    start-process msiexec.exe -Wait -ArgumentList '/i C:\TEMP\node.msi /qn ADDLOCAL=ALL' ; \
    remove-item C:\TEMP\node.msi

