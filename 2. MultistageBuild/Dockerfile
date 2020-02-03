# Build
FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build

WORKDIR /src
COPY "DockerbuildDemo.csproj" .
RUN dotnet restore "DockerbuildDemo.csproj"

COPY . .
RUN dotnet build "DockerbuildDemo.csproj" -c Release -o /app
RUN dotnet publish "DockerbuildDemo.csproj" -c Release -o /app

# Runtime
FROM mcr.microsoft.com/dotnet/core/runtime:2.2-stretch-slim AS runtime
WORKDIR /app
COPY --from=build /app .

ENTRYPOINT ["dotnet", "DockerbuildDemo.dll"]