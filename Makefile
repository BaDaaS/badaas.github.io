.PHONY: help install prettify fix-trailing-whitespaces check-trailing-whitespaces format format-check clean

# Default target
help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	@if [ ! -f package.json ]; then \
		npm init -y; \
	fi
	@npm install --save-dev prettier

prettify: ## Format all files with prettier (alias for format)
	@npx prettier --write "**/*.{html,css,js,json,md}"

fix-trailing-whitespaces: ## Remove trailing whitespaces from all files
	@echo "Fixing trailing whitespaces in files..."
	@find . -type f \( -name "*.html" -o -name "*.css" -o -name "*.js" \
		-o -name "*.json" -o -name "*.md" \) -not -path "./node_modules/*" \
		-print -exec sed -i 's/[[:space:]]*$$//' {} \;
	@echo "Trailing whitespaces fixed."

check-trailing-whitespaces: ## Check for trailing whitespaces in files
	@echo "Checking for trailing whitespace..."
	@if find . -type f \( -name "*.html" -o -name "*.css" -o -name "*.js" \
		-o -name "*.json" -o -name "*.md" \) \
		-not -path "./node_modules/*" \
		-exec grep -l '[[:space:]]$$' {} + 2>/dev/null; then \
		echo "Files with trailing whitespace found (listed above)"; \
		exit 1; \
	else \
		echo "No trailing whitespace found"; \
	fi

format: ## Format all files with prettier
	@npx prettier --write "**/*.{html,css,js,json,md}"

format-check: ## Check if files are formatted correctly
	@npx prettier --check "**/*.{html,css,js,json,md}"

clean: ## Clean node_modules and package-lock.json
	@rm -rf node_modules package-lock.json