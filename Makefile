.DEFAULT_GOAL := all

SRC_DIR = ${PWD}/src
TMP_DIR = ${PWD}/tmp

SRC_FILES = $(shell find ${SRC_DIR} -type "f")

NETLIFY_WEBSITE =
NETLIFY_ACCESS_TOKEN =

$(TMP_DIR):
	mkdir -p $@

.PHONY: all
all: build.zip

build.zip: ${SRC_FILES} | ${TMP_DIR}
	dst_dir=$$(mktemp -p ${TMP_DIR} -d dst.XXXXXXXXXX) \
	&& hugo build --source ${SRC_DIR} \
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
	wget --quiet \
	     --no-verbose \
	     --tries=3 \
	     --output-document=/dev/null \
	     --server-response \
	     --post-file=$< \
	     --header "Content-Type: application/zip" \
	     --header "Authorization: Bearer ${NETLIFY_ACCESS_TOKEN}" \
	     "https://api.netlify.com/api/v1/sites/${NETLIFY_WEBSITE}.netlify.app/deploys"

.PHONY: clean
clean:
	rm -rf $(TMP_DIR)
	rm -f build.zip
