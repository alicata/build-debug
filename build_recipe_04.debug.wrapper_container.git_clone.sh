BASEIMAGE_TO_DEBUG=testimage:v02
WRAPPER_IMAGE=testimage:v05

# Build parent image that needs to be debugged, without modifying it 
docker build -f ./Dockerfile.02-call-python-main -t ${BASEIMAGE_TO_DEBUG} --build-arg VERSION=0.0.2 .

# Inject the parent docker image to debug into the derived debugging image
docker build -t ${WRAPPER_IMAGE} --build-arg BASEIMAGE=${BASEIMAGE_TO_DEBUG} -f Dockerfile.05-debug-image-as-base-image .

# Start debug server with main.app
# Debug server waits for debug client (VSCode GUI) to start
# User selects Start-Debug with Remote-Attach config
echo start debugging image that launches the debug server and waits for vscode debug client
echo ${WRAPPER_IMAGE}: debug server starting ...
echo ${WRAPPER_IMAGE}: debug server waiting for VSCode client ...
echo ${WRAPPER_IMAGE}: please start Debug in VSCode ...
docker run -it -p 5678:5678  ${WRAPPER_IMAGE}
echo ${WRAPPER_IMAGE}: done.
