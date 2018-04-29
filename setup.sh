echo 'begin'

# variables
echo ---------------variables...---------------
GITHASH=`git rev-parse --short HEAD`
IMGNAME=identityserver
CONTAINER=my-identityserver

# publish
echo ---------------publish...------------------
rm -rf ./publish
docker run --rm -v $(pwd):/app -w /app microsoft/dotnet:sdk dotnet publish ./Geek.IdentityServer4.Host/Geek.IdentityServer4.Host.csproj -o ../publish -c Release -r linux-x64

# image
echo ---------------image...---------------
docker build -t $IMGNAME:$GITHASH .
docker tag $IMGNAME:$GITHASH $IMGNAME:latest
docker rmi -f $(docker images -q -f dangling=true)

# container
echo ---------------container...---------------
echo "docker stop $CONTAINER || true && docker rm -f $CONTAINER || true"
docker stop $CONTAINER || true && docker rm -f $CONTAINER || true
echo "docker run -d -p 50000:50000 --link my-mariadb:mysql --name $CONTAINER $IMGNAME:"
docker run --rm -d -p 50000:50000 --link my-mariadb:mysql --name=$CONTAINER $IMGNAME

echo 'done!'