docker run --rm -it -v .:/app -w /app -p 4000:4000 -p 35729:35729 jekyll/minimal npx -y watchy -w _config.yml -- jekyll serve --livereload
