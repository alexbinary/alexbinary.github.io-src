# Redaction

## Pages

Pages must have a title to appear in the menu.


## Posts

By default, posts have a url of the form /{category}/{year}/{month}/{day}/{title},
and partial URLs like for example /{category}/{year} yield a directory listing. 

I do not want that. I use permalink for all posts.
Permalinks conflicts trigger a warning at build time.


# Commands

docker run --rm -it -v .:/app -w /app -p 4000:4000 -p 35729:35729 jekyll/minimal npx -y watchy -w _config.yml -- jekyll serve --livereload
