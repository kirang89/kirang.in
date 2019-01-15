# kirang.in

This repo will eventually be the source of my blog  http://kirang.in

## Running

To run the server in development mode, do:

``` shell
hugo server -D
```

## Building

Simply run `hugo` to build the website

## Deploying

After building the website, do the following:

``` shell
cd public
git add --all
git commit -m "Publish"
cd ..
git push origin gh-pages
```
