.PHONY: format-docs

# Format every Markdown file in the repository with dprint, one line per paragraph.
format-docs:
	dprint fmt --config dprint.json "**/*.md"
