# build image
FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src

# nuget restore
# Install Credential Provider and set env variables to enable Nuget restore with auth
# ARG PAT
# RUN wget -qO- https://raw.githubusercontent.com/Microsoft/artifacts-credprovider/master/helpers/installcredprovider.sh | bash
# ENV NUGET_CREDENTIALPROVIDER_SESSIONTOKENCACHE_ENABLED true
# ENV VSS_NUGET_EXTERNAL_FEED_ENDPOINTS "{\"endpointCredentials\": [{\"endpoint\":\"https://pkgs.dev.azure.com/jakob/_packaging/IgniteTour/nuget/v3/index.json\", \"password\":\"${PAT}\"}]}"


COPY ["WebApplication1/WebApplication1.csproj", "WebApplication1/"]
RUN dotnet restore -s "https://pkgs.dev.azure.com/jakob/_packaging/IgniteTour/nuget/v3/index.json" -s "https://api.nuget.org/v3/index.json" "WebApplication1/WebApplication1.csproj"

# dotnet build and publish
COPY . .
WORKDIR /src/WebApplication1
RUN dotnet build "WebApplication1.csproj" -c Release -o /app
RUN dotnet publish "WebApplication1.csproj" -c Release -o /app

# runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]