FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 80
EXPOSE 5000
EXPOSE 5001
ENTRYPOINT ["dotnet", "core-api.dll"]
