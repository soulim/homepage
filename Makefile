.DEFAULT_GOAL := all

SRC_DIR = ${PWD}
TMP_DIR = ${PWD}/tmp

SRC_FILES = $(shell find ${SRC_DIR} -type "f")

$(TMP_DIR):
	mkdir -p $@

.PHONY: all
all: release

.PHONY: release
release: ${SRC_FILES} | ${TMP_DIR}
	dst_dir=$$(mktemp -p ${TMP_DIR} -d dst.XXXXXXXXXX) \
	&& ${HUGO} build --source ${SRC_DIR} \
	                 --destination $${dst_dir} \
	                 --environment production \
	                 --gc \
	                 --minify \
	                 --printMemoryUsage \
	                 --printPathWarnings \
	                 --printUnusedTemplates

.PHONY: clean
clean:
	rm -rf $(TMP_DIR)
