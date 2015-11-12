# elm-talk
Slide and examples from my Full Stack San Diego talk on 11/12/15

## Running The Examples
Once you have Elm installed, open either example directory and run `elm package install` to install `elm-core` and any dependencies.

For example `1` run `elm make Main.elm` to generate `elm.js`, then open `index.html` in your browser. Alternatively, you can
run `elm reactor` and navigate to `http://localhost:8000`, but the page won't be styled because `Elm Reactor` isn't loading
`index.html` it just generates raw HTML from the `.elm` file.

For example `2`, there is no index.html. Just run `elm reactor` and navigate to `http://localhost:8000`.
