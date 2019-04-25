# Build
FROM microsoft/dotnet:2.2-sdk AS build

WORKDIR /src
COPY "DockerbuildDemo.csproj" .
RUN dotnet restore "DockerbuildDemo.csproj"

COPY . .
RUN dotnet build "DockerbuildDemo.csproj" -c Release -o /app

RUN dotnet publish "DockerbuildDemo.csproj" -c Release -o /app

# Runtime
FROM microsoft/dotnet:2.2-runtime AS runtime
WORKDIR /app
COPY --from=build /app .

ENTRYPOINT ["dotnet", "DockerbuildDemo.dll"]