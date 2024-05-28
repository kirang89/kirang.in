# kirang.in
[![Build](https://github.com/kirang89/kirang.in/actions/workflows/hugo-publish.yml/badge.svg)](https://github.com/kirang89/kirang.in/actions/workflows/hugo-publish.yml)

The source of my blog at https://kirang.in

## Running

To run the server in development mode, do:

```shell
hugo server -D
```

## Building

Simply run `hugo` to build the website

## Deploying

After building the website, do the following:

```shell
cd public
git add --all
git commit -m "Publish"
git push origin gh-pages
```
