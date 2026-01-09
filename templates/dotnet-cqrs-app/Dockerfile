# Generic .NET Multi-stage Dockerfile
# Works with any .NET project - pass PROJECT_NAME and DLL_NAME as build args

ARG DOTNET_VERSION=8.0

FROM mcr.microsoft.com/dotnet/aspnet:${DOTNET_VERSION} AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:${DOTNET_VERSION} AS build
ARG PROJECT_NAME
ARG PROJECT_PATH=.
WORKDIR /src

# Copy project file and restore
COPY ["${PROJECT_PATH}/${PROJECT_NAME}.csproj", "${PROJECT_NAME}/"]
RUN dotnet restore "${PROJECT_NAME}/${PROJECT_NAME}.csproj"

# Copy remaining source and build
COPY ${PROJECT_PATH} ${PROJECT_NAME}/
WORKDIR "/src/${PROJECT_NAME}"
RUN dotnet build "${PROJECT_NAME}.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "${PROJECT_NAME}.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
ARG DLL_NAME
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT dotnet "${DLL_NAME}.dll"
