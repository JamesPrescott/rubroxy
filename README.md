# Rubroxy

A simple ruby proxy - built as a lightweight solution that can be integrated easily into ruby scripts etc

## Installation

`gem install rubroxy`

## Usage

```
require 'rubroxy'

proxy = Proxy.new('localhost', 8080, 0)
proxy.start_server
```

To filter responses and edit if needed, do the following:

```
proxy = Proxy.new('localhost', 8080, 0)

# Creates a proc object with the logic provided in the code block
handler = proc do |req, res|
  res.body = 'This has been proxied!' if res['content-type'] = 'text/html'
end

proxy.add_rules(handler)
proxy.start_server
```

## Development

### Contribution

If you think you can contribute to the project, whether it's through development or testing or when there's a bug to be fixed - feel free to clone the repo and create an issue so that I'm aware. Once it's complete and tested, create a Pull Request so that it can be merged in.

### Tests

We're using Rspec to build the tests for Rubroxy. If you want to run the current test suite just type `rspec` when in the rubroxy repo directory after cloning. All new features must come with relevant tests.

### Todos

Currently, this does what I need it to do - but it would be great to expand it and generally make it better :)

- An easier way to build rulesets for the proxy before initialisation.
- Further logging, including potential reports or other ways to analyse proxy sessions