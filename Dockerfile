FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App

# 全てのファイルをコンテナにコピーする
COPY . ./

# csprojを見て依存関係を解決する
RUN dotnet restore

# ビルドしてpublishする
RUN dotnet publish -c Release -o out


# DockerTestの実行
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "PersuadeMate.Api.dll"]