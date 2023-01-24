FROM mcr.microsoft.com/dotnet/core/runtime:3.1 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["SWPS_GIT_Flow.csproj", "./"]
RUN dotnet restore "SWPS_GIT_Flow.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "SWPS_GIT_Flow.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SWPS_GIT_Flow.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SWPS_GIT_Flow.dll"]
