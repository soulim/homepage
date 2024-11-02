.DEFAULT_GOAL := all

# PUB_DIR = ./public
SRC_DIR = $(PWD)
TMP_DIR = $(SRC_DIR)/tmp

OS = $(shell uname -s)

NETLIFY_WEBSITE =
NETLIFY_ACCESS_TOKEN =

# $(PUB_DIR):
# 	mkdir -p $@

$(TMP_DIR):
	mkdir -p $@

# .PHONY: all
# all: | $(PUB_DIR) $(TMP_DIR)
# 	hugo --minify

# .PHONY: deploy
# deploy: all
# 	zip --test \
#         --recurse-paths \
#         --exclude "*.DS_Store" \
#         -9 \
#         $(TMP_DIR)/website.zip \
#         $(PUB_DIR) \
#     && wget --quiet \
#             --no-verbose \
#             --tries=3 \
#             --output-document=/dev/null \
#             --server-response \
#             --post-file=$(TMP_DIR)/website.zip \
#             --header "Content-Type: application/zip" \
#             --header "Authorization: Bearer $(NETLIFY_ACCESS_TOKEN)" \
#             "https://api.netlify.com/api/v1/sites/$(NETLIFY_WEBSITE).netlify.app/deploys"

.PHONY: deploy
deploy: | $(TMP_DIR)
	cd $$(mktemp -p $(TMP_DIR) -d dst.XXXXXXXXXX) \
	&& hugo build --source $(SRC_DIR) \
	              --destination $$PWD \
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
	       $$PWD/website.zip \
	       $$PWD \
	&& wget --quiet \
	        --no-verbose \
	        --tries=3 \
	        --output-document=/dev/null \
	        --server-response \
	        --post-file=$$PWD/website.zip \
	        --header "Content-Type: application/zip" \
	        --header "Authorization: Bearer $(NETLIFY_ACCESS_TOKEN)" \
	        "https://api.netlify.com/api/v1/sites/$(NETLIFY_WEBSITE).netlify.app/deploys"
.PHONY: clean
clean:
	rm -rf $(TMP_DIR)
