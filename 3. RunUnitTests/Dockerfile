FROM mcr.microsoft.com/dotnet/core/runtime:2.2-stretch-slim AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
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
RUN /tools/reportgenerator "-reports:coverage.cobertura.xml" "-targetdir:/testresults/coverage/reports" "-reporttypes:HTMLInline;HTMLChart" ; exit 0

#Publish
RUN dotnet publish "App/App.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "App.dll"]