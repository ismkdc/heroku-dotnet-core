FROM microsoft/dotnet:2.2-sdk AS build-env
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .

CMD ASPNETCORE_URLS=http://*:$PORT dotnet dotnetcore-demo.dll