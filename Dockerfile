ARG  DOTNET_IMAGE=mcr.microsoft.com/dotnet/sdk:7.0

FROM ${DOTNET_IMAGE} as build-env
WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM ${DOTNET_IMAGE} as final-env
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "app.dll"]
