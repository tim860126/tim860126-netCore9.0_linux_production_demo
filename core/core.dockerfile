FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
COPY Demo/. /source/Demo/
WORKDIR /source/Demo
RUN apt-get install -y curl
RUN curl https://api.nuget.org/v3/index.json
RUN dotnet restore
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app ./
EXPOSE 8080
ENTRYPOINT ["dotnet", "Demo.dll"]
