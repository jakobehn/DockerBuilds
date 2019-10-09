FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch

# Nuget restore
WORKDIR /src
COPY "DockerbuildDemo.csproj" .
RUN dotnet restore "DockerbuildDemo.csproj"

# Compile
COPY . .
RUN dotnet build "DockerbuildDemo.csproj" -c Release -o /app

# Publish
RUN dotnet publish "DockerbuildDemo.csproj" -c Release -o /app
WORKDIR /app
ENTRYPOINT ["dotnet", "DockerbuildDemo.dll"]