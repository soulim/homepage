online:
	rm -rf public/
	rm -f website.zip
	hugo
	zip --recurse-paths \
			--exclude "*.DS_Store" \
			-9 \
			website.zip public/
	curl https://api.netlify.com/api/v1/sites/${NETLIFY_WEBSITE}/deploys \
			 --header "Content-Type: application/zip" \
		   --header "Authorization: Bearer ${NETLIFY_ACCESS_TOKEN}" \
		   --data-binary "@website.zip" \
			 --progress-bar \
			 --verbose
