NAME = fabriziopandini/debug
BASE = alpine ubuntu

all: package

package: 
	@$(foreach base,${BASE},cd ${base}/;docker build --rm -t ${NAME}:${base} .;cd ..;) 

rmi: 
	@$(foreach base,${BASE},docker rmi ${NAME}:${base};) 