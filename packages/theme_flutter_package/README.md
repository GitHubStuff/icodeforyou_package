# theme_flutter_package

To create/use an example application -

```zsh
# .gitmodules has a link to an example app on the repo
# this terminal command will pull and initialize that app
# adding the /example folder (see .gitmodules)
git submodule update --init
```

After the /example folder is created:

-- edit ```.gitmodules``` an remove the entry for submodle example

```zsh
# the entry looks like:
[submodule "example"]
    path = example
    url = https://github.com/GitHubStuff/template_flutter_app
```

This will make the /example folder part of the package's code

<- END OF INSTRUCTIONS ->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
