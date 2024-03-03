

# Use https://hub.docker.com/r/jvconseil/jekyll-docker
# to serve the site locally.
docker run --rm -p 4000:4000 \
    --volume="$PWD:/srv/jekyll:Z" \
    -w /srv/jekyll \
    -it ruby:latest bash
