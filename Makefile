BIN_DIR = ./bin
TMP_DIR = ./tmp
PUB_DIR = ./public

OS = $(shell uname -s)

HUGO_VERSION = 0.88.1

NETLIFY_WEBSITE =
NETLIFY_ACCESS_TOKEN =

# Hugo releases use "macOS" instead of "Darwin" as an OS name.
ifeq ($(OS),Darwin)
	OS = macOS
endif

$(BIN_DIR):
	mkdir -p $@

$(TMP_DIR):
	mkdir -p $@

$(PUB_DIR):
	mkdir -p $@

HUGO = $(BIN_DIR)/hugo
$(HUGO): | $(BIN_DIR) $(TMP_DIR)
	wget --quiet \
         --no-verbose \
         --tries=3 \
         --directory-prefix=$(TMP_DIR) \
         "https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_$(OS)-64bit.tar.gz" \
    && tar --gzip \
           --extract \
           --directory=$(BIN_DIR) \
           --file=$(TMP_DIR)/hugo_$(HUGO_VERSION)_$(OS)-64bit.tar.gz hugo \
    && $(HUGO) version

.PHONY: all
all: | $(PUB_DIR) $(HUGO)
	$(HUGO) --minify

.PHONY: deploy
deploy: all
	zip --test \
        --recurse-paths \
        --exclude "*.DS_Store" \
        -9 \
        $(TMP_DIR)/website.zip \
        $(PUB_DIR) \
    && wget --quiet \
            --no-verbose \
            --tries=3 \
            --output-document=/dev/null \
            --server-response \
            --post-file=$(TMP_DIR)/website.zip \
            --header "Content-Type: application/zip" \
            --header "Authorization: Bearer $(NETLIFY_ACCESS_TOKEN)" \
            "https://api.netlify.com/api/v1/sites/$(NETLIFY_WEBSITE).netlify.app/deploys"

.PHONY: clean
clean:
	rm -rf $(BIN_DIR)
	rm -rf $(TMP_DIR)
	rm -rf $(PUB_DIR)

.DEFAULT_GOAL := all
