.DEFAULT_GOAL := all

SRC_DIR = ${PWD}
TMP_DIR = ${PWD}/tmp

SRC_FILES = $(shell find ${SRC_DIR} -type "f")

$(TMP_DIR):
	mkdir -p $@

.PHONY: all
all: release

.PHONY: release
release: | ${TMP_DIR}
	dst_dir=$$(mktemp -p ${TMP_DIR} -d dst.XXXXXXXXXX) \
	&& hugo build --source ${SRC_DIR} \
	              --destination $${dst_dir} \
	              --environment production \
	              --gc \
	              --minify \
	              --printMemoryUsage \
	              --printPathWarnings \
	              --printUnusedTemplates \
	&& rsync --delete --recursive --verbose $${dst_dir} pgs.sh:/homepage

.PHONY: clean
clean:
	rm -rf $(TMP_DIR)
