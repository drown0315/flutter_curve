# Makefile for deploying the Flutter web projects to GitHub

BASE_HREF = /$(OUTPUT)/
# Replace this with your GitHub username
GITHUB_USER = drown0315
GITHUB_REPO = https://x-access-token:$(TOKEN)@github.com/$(GITHUB_USER)/$(OUTPUT)
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

# Deploy the Flutter web project to GitHub
deploy:
ifndef OUTPUT
  $(error OUTPUT is not set. Usage: make deploy OUTPUT=<output_repo_name>)
endif
ifndef TOKEN
  $(error TOKEN is not set.)
endif

	@echo "Clean existing repository"
	flutter clean

	@echo "Getting packages..."
	flutter pub get

	@echo "Generating the web folder..."
	flutter create . --platform web

	@echo "Building for web..."
	flutter build web --base-href $(BASE_HREF) --release

	@echo "Deploying to git repository"
	cd build/web && \
	git config --global user.email "drown0315@gmail.com" && \
	git config --global user.name "drown0315" && \
	git init && \
	git checkout -b web_page && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M web_page && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin web_page

	@echo "✅ Finished deploy: $(GITHUB_REPO)"
	@echo "🚀 Flutter web URL: https://$(GITHUB_USER).github.io/$(OUTPUT)/"

.PHONY: deploy