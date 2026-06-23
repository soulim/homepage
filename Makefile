.DEFAULT_GOAL := all

SRC_DIR = ${PWD}
TMP_DIR = ${PWD}/tmp
BIN_DIR = ${PWD}/bin

HUGO = ${BIN_DIR}/hugo
HUGO_VERSION = 0.163.3
HUGO_ARCH = 64bit

SRC_FILES = $(shell find ${SRC_DIR} -type "f")

NETLIFY_WEBSITE =
NETLIFY_ACCESS_TOKEN =

$(TMP_DIR):
	mkdir -p $@

$(BIN_DIR):
	mkdir -p $@

${HUGO}: | ${BIN_DIR} ${TMP_DIR}
	hugo_dst="$$(mktemp -p ${TMP_DIR} -d hugo-${HUGO_VERSION}.XXXXXXXXXX)/hugo_${HUGO_VERSION}_Linux-${HUGO_ARCH}.tar.gz" \
	&& curl "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/$$(basename $$hugo_dst)" \
	        --fail \
	        --show-error \
	        --location \
	        --compressed \
	        --output "$${hugo_dst}" \
	&& tar --extract --gzip --file $${hugo_dst} --directory $$(dirname $${hugo_dst}) \
	&& install $$(dirname $${hugo_dst})/hugo ${HUGO} \
	&& rm -rf $$(dirname $${hugo_dst})

.PHONY: all
all: build.zip

build.zip: ${SRC_FILES} | ${TMP_DIR}
	dst_dir=$$(mktemp -p ${TMP_DIR} -d dst.XXXXXXXXXX) \
	&& ${HUGO} build --source ${SRC_DIR} \
	                 --destination $${dst_dir} \
	                 --environment production \
	                 --gc \
	                 --minify \
	                 --printMemoryUsage \
	                 --printPathWarnings \
	                 --printUnusedTemplates \
	&& zip --test \
	       --move \
	       --recurse-paths \
	       --exclude "*.DS_Store" \
	       -9 \
	       $@ \
	       $${dst_dir} \
	&& rm -rf "$${dst_dir}"

.PHONY: deploy
deploy: build.zip
	curl "https://api.netlify.com/api/v1/sites/${NETLIFY_WEBSITE}.netlify.app/deploys" \
	     --upload-file "$<" \
	     --request "POST" \
	     --header "Content-Type: application/zip" \
	     --header "Authorization: Bearer ${NETLIFY_ACCESS_TOKEN}" \
	     --output /dev/null \
	     --fail \
	     --show-error

.PHONY: clean
clean:
	rm -rf $(BIN_DIR)
	rm -rf $(TMP_DIR)
	rm -f build.zip
