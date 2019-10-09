FROM microsoft/dotnet:2.2-runtime AS base
WORKDIR /app

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src

#Restore
COPY ["App/App.csproj", "App/"]
RUN dotnet restore "App/App.csproj"
COPY ["UnitTests/UnitTests.csproj", "UnitTests/"]
RUN dotnet restore "UnitTests/UnitTests.csproj"

#Build
COPY . .
RUN dotnet build "App/App.csproj" -c Release -o /app
RUN dotnet build "UnitTests/UnitTests.csproj"

#Test
LABEL test=true

# run the test and collect code coverage
ARG cachebust=1
RUN dotnet test --results-directory /testresults --logger "trx;LogFileName=test_results.xml" /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura /p:CoverletOutput=/testresults/coverage/  UnitTests/UnitTests.csproj; exit 0

# generate html reports using report generator tool
RUN dotnet tool install dotnet-reportgenerator-globaltool --version 4.0.6 --tool-path /tools
RUN /tools/reportgenerator "-reports:/testresults/coverage/coverage.cobertura.xml" "-targetdir:/testresults/coverage/reports" "-reporttypes:HTMLInline;HTMLChart"
RUN ls -la /testresults/coverage/reports

#Publish
RUN dotnet publish "App/App.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "App.dll"]