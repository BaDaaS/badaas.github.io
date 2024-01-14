.PHONY: help install build dev preview clean format format-check \
	fix-trailing-whitespaces check-trailing-whitespaces

# Detect OS for sed compatibility
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	SED_INPLACE := sed -i ''
else
	SED_INPLACE := sed -i
endif

# Default target
help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	@npm install

build: ## Build the site for production
	@npx astro build

dev: ## Start development server
	@npx astro dev

preview: ## Preview production build locally
	@npx astro preview

format: ## Format all files with prettier
	@npx prettier --write "**/*.{astro,html,scss,js,ts,json,md,mdx,yml,yaml}"

format-check: ## Check if files are formatted correctly
	@npx prettier --check "**/*.{astro,html,scss,js,ts,json,md,mdx,yml,yaml}"

fix-trailing-whitespaces: ## Remove trailing whitespaces from all files
	@echo "Fixing trailing whitespaces in files..."
	@find . -type f \( -name "*.astro" -o -name "*.html" -o -name "*.css" \
		-o -name "*.scss" -o -name "*.js" -o -name "*.ts" \
		-o -name "*.json" -o -name "*.md" -o -name "*.mdx" \
		-o -name "*.yml" -o -name "*.yaml" \) \
		-not -path "./node_modules/*" -not -path "./dist/*" \
		-not -path "./.astro/*" \
		-print -exec $(SED_INPLACE) 's/[[:space:]]*$$//' {} \;
	@echo "Trailing whitespaces fixed."

check-trailing-whitespaces: ## Check for trailing whitespaces in files
	@echo "Checking for trailing whitespace..."
	@if find . -type f \( -name "*.astro" -o -name "*.html" -o -name "*.css" \
		-o -name "*.scss" -o -name "*.js" -o -name "*.ts" \
		-o -name "*.json" -o -name "*.md" -o -name "*.mdx" \
		-o -name "*.yml" -o -name "*.yaml" \) \
		-not -path "./node_modules/*" -not -path "./dist/*" \
		-not -path "./.astro/*" \
		-exec grep -l '[[:space:]]$$' {} + 2>/dev/null; then \
		echo "Files with trailing whitespace found (listed above)"; \
		exit 1; \
	else \
		echo "No trailing whitespace found"; \
	fi

clean: ## Clean build artifacts and dependencies
	@rm -rf node_modules dist .astro
