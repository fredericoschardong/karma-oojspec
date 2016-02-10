# karma-oojspec
A tentative to integrate karma with [oojspec](https://github.com/rosenfeld/oojspec/)

Oojspec originally run test files in different iframes. In order to match that behavior this project uses a modified [karma](https://github.com/fredericoschardong/karma) which run test files in different iframes.

## Install the dependencies

    npm install

## Running

    karma start

# TODO

* ~~Make oojspec results be displayed in Karma's console~~
* Turn this into a plugin (we have to wait until oojspec becomes a npm package itself)
