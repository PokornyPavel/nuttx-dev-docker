@echo off

set DOCKER_IMAGE=nuttx-buildt
set DOCKER_USER=roman

if [%1]==[run] goto :run
if [%1]==[build] goto :build
if [%1]==[] goto :usage

:run
echo "Running container..."
docker run -ti --rm -v .:/home/%DOCKER_USER%/src %DOCKER_IMAGE% bash
EXIT /B 0

:build
echo "Building container..."
docker build -t %DOCKER_IMAGE% -f "Dockerfile" --build-arg UNAME=%DOCKER_USER% .
EXIT /B 0

:usage
echo "To build a container run: docker-setup.bat build. To run: docker-setup.bat run"
EXIT /B 0
