#!/bin/bash

pushd func-HelloWorld
dotnet publish
pushd bin/Debug/netcoreapp2.1/publish
zip -r -X ../../../../functionapp.zip *
popd
popd