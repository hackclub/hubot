# Hubot [![Circle CI](https://circleci.com/gh/hackclub/hubot.svg?style=svg)](https://circleci.com/gh/hackclub/hubot)

Hubot is a chat bot built on the [Hubot](https://hubot.github.com/) framework.

### Running Hubot Locally

You can test your hubot by running the following, however some plugins will not
behave as expected unless the [environment variables](#configuration) they rely
upon have been set.

You can start Hubot locally by running:

    % bin/hubot

You'll see some start up output and a prompt:

    [Sat Feb 28 2015 12:38:27 GMT+0000 (GMT)] INFO Using default redis on localhost:6379
    Hubot>

Then you can interact with Hubot by typing `Hubot help`.

    Hubot> Hubot help
    Hubot animate me <query> - The same thing as `image me`, except adds [snip]
    Hubot help - Displays all of the help commands that Hubot knows about.
    ...

### Configuration

A few scripts (including some installed by default) require environment
variables to be set as a simple form of configuration.

Each script should have a commented header which contains a "Configuration"
section that explains which values it requires to be placed in which variable.
When you have lots of scripts installed this process can be quite labour
intensive. The following shell command can be used as a stop gap until an
easier way to do this has been implemented.

    grep -o 'hubot-[a-z0-9_-]\+' external-scripts.json | \
      xargs -n1 -I {} sh -c 'sed -n "/^# Configuration/,/^#$/ s/^/{} /p" \
          $(find node_modules/{}/ -name "*.coffee")' | \
        awk -F '#' '{ printf "%-25s %s\n", $1, $2 }'

How to set environment variables will be specific to your operating system.
Rather than recreate the various methods and best practices in achieving this,
it's suggested that you search for a dedicated guide focused on your OS.

### Scripting

An example script is included at `scripts/example.coffee`, so check it out to
get started.

For many common tasks, there's a good chance someone has already one to do just
the thing.

### external-scripts

There will inevitably be functionality that everyone will want. Instead of
writing it yourself, you can use existing plugins.

Hubot is able to load plugins from third-party `npm` packages. This is the
recommended way to add functionality to your hubot. You can get a list of
available hubot plugins on https://www.npmjs.com or by using `npm search`:

    % npm search hubot-scripts panda
    NAME             DESCRIPTION                        AUTHOR DATE       VERSION KEYWORDS
    hubot-pandapanda a hubot script for panda responses =missu 2014-11-30 0.9.2   hubot hubot-scripts panda
    ...


To use a package, check the package's documentation, but in general it is:

1. Use `npm install --save` to add the package to `package.json` and install it
2. Add the package name to `external-scripts.json` as a double quoted string

You can review `external-scripts.json` to see what is included by default.

##### Advanced Usage

It is also possible to define `external-scripts.json` as an object to
explicitly specify which scripts from a package should be included. The example
below, for example, will only activate two of the six available scripts inside
the `hubot-fun` plugin, but all four of those in `hubot-auto-deploy`.

```json
{
  "hubot-fun": [
    "crazy",
    "thanks"
  ],
  "hubot-auto-deploy": "*"
}
```

**Be aware that not all plugins support this usage and will typically fallback
to including all scripts.**

### hubot-scripts

Before hubot plugin packages were adopted, most plugins were held in the
[hubot-scripts](https://github.com/github/hubot-scripts) package. Some of these
plugins have yet to be migrated to their own packages. They can still be used
but the setup is a bit different.

To enable scripts from the hubot-scripts package, add the script name with
extension as a double quoted string to the `hubot-scripts.json` file in this
repo.

## Deployment

Hubot is set up to automatically deploy whenever new code is merged into
`master`.
