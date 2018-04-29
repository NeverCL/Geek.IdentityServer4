FROM microsoft/aspnetcore
WORKDIR /app
ENV ASPNETCORE_URLS http://*:50000
ENV TZ 'Asia/Shanghai'
EXPOSE 50000
COPY ./publish /app
CMD ["dotnet", "Geek.IdentityServer4.Host.dll"]