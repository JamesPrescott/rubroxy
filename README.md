# Rubroxy

A simple ruby proxy wrapped around WEBrick that can be integrated into any ruby script or test. The goal was to make something that solved some of my problems at work without needing too much configuration or use of many files.

This can also be used as part of tests without any external scripts or dependencies beyond ruby.

## Installation

`gem install rubroxy`

## Usage

```
require 'rubroxy'

proxy = Proxy.new('localhost', 8080, 0)
proxy.start_server
```

To filter responses and edit if needed, do something like the following:

```
proxy = Proxy.new('localhost', 8080, 0)

# Creates a proc object with the logic provided in the code block
handler = proc do |req, res|
  res.body = 'This has been proxied!' if res['content-type'] = 'text/html'
end

proxy.add_rules(handler)
proxy.start_server
```

You can also filter by `host`, so if you want to alter a response from a test environment as an example:

```
handler = proc do |req, res|
  res.body = 'This has been altered' if req.host == 'something.itv.com'
end
```

Combining this with data can give you a pretty powerful proxy ruleset! We can also alter other aspects of the request, including headers:

```
handler = proc do |req, res|
  req['auth'] = 'auth_token' if req.host = 'www.google.com'
end
```

The above will add the designated header to any request going to that URL.

## Development

### Contribution

If you think you can contribute to the project, whether it's through development or testing or when there's a bug to be fixed - feel free to clone the repo and create an issue so that I'm aware. Once it's complete and tested, create a Pull Request so that it can be merged in.

### Tests

We're using Rspec to build the tests for Rubroxy. If you want to run the current test suite just type `rspec` when in the rubroxy repo directory after cloning. All new features must come with relevant tests.

### Todos

Currently, this does what I need it to do - but it would be great to expand it and generally make it better :)

- An easier way to build rulesets for the proxy before initialisation. Currently you'd have to parse JSON etc yourself but I'm looking at integrating it as part of the gem.
- Further logging, including potential reports or other ways to analyse proxy sessions
- The ability to query the proxy for URLS that have been hit through the connection.
- Ability to set new rules during runtime. Ideally done without the need for a restart of the server but I realise this might be impossible.
