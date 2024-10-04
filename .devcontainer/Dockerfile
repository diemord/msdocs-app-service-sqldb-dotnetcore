# Use the .NET 8 Dev Container as base
FROM mcr.microsoft.com/devcontainers/dotnet:1-8.0-bookworm

# Copy the SQL tools installation script
COPY mssql/installSQLtools.sh installSQLtools.sh

# Install SQL tools: sqlcmd, sqlpackage, mysql-client, openssl
RUN bash ./installSQLtools.sh \
     && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

# Set environment variables for connection strings (optional, depending on your needs)
ENV ASPNETCORE_ENVIRONMENT=Production
ENV ConnectionStrings__MyDbConnection="Server=<your-server-name>.mysql.database.azure.com;Port=3306;Database=ApplicationDB;Uid=<username>;Pwd=<password>;SslMode=Preferred;AllowPublicKeyRetrieval=True;"
