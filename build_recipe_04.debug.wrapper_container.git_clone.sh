#  docker build -f ./Dockerfile.04-call-python-main-src-git-clone -t testimage:v04 --build-arg VERSION=0.0.4 .

BASEIMAGE_TO_DEBUG=testimage:v04
WRAPPER_IMAGE=testimage:v05

# Build parent image that needs to be debugged, without modifying it 
docker build -f ./Dockerfile.04-call-python-main-src-git-clone -t ${BASEIMAGE_TO_DEBUG} --build-arg VERSION=0.0.4 .

# Inject the parent docker image to debug into the derived debugging image
docker build -t ${WRAPPER_IMAGE} --build-arg BASEIMAGE=${BASEIMAGE_TO_DEBUG} -f Dockerfile.05-debug-image-as-base-image .

# Prepare out-of-container debug code
rm -rf debug
git clone https://github.com/alicata/build-debug.git debug

# Start debug server with main.app
# Debug server waits for debug client (VSCode GUI) to startgit 
# User selects Start-Debug with Remote-Attach config
echo start debugging image that launches the debug server and waits for vscode debug client

echo ${WRAPPER_IMAGE}: debug server starting ...
echo ${WRAPPER_IMAGE}: debug server waiting for VSCode client ...
echo ${WRAPPER_IMAGE}: please start Debug in VSCode ...

# Mount externally cloned repo to mirror internal one in base container
docker run -it --rm -p 5678:5678 -v debug:/workspace/picospace/debug  ${WRAPPER_IMAGE}

echo ${WRAPPER_IMAGE}: done.
