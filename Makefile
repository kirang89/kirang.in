.PHONY: build clean publish

help:
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

clean:  ## Remove build artifacts
	rm -rf public

build:  ## Builds the content
	hugo

serve: ## Starts a server in development mode
	hugo server -D

update-theme:  ## Updates the theme by updating submodule from remote
	git submodule update --recursive --remote

publish: build ## Builds content and pushes it to gh-pages
	cd public; \
  git add .; \
	git commit -m "Publish"; \
  git push origin gh-pages
