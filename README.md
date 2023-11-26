# build-debug
Recipes for debugging code used by containers with VSCode debug server. 

## Recipe 04 - Debug base container with repo code cloned internally
[build_recipe_04.debug.wrapper_container.git_clone.sh]( https://github.com/alicata/build-debug/blob/main/build_recipe_04.debug.wrapper_container.git_clone.sh)

### Contraints
* base docker container runs git clone internally to generate a temporary repository
* repository code is visible only internally to base container, VSCode debugger has no access
* mount, bind don't work

### Elements involved
* base docker image
* helper wrapper docker image
* Docker image file for wrapper
