## Rubroxy

A simple ruby proxy - built as a lightweight solution that can be integrated easily into ruby scripts etc

## Installation

`gem install rubroxy`

## Usage

```
require 'rubroxy'

proxy = Proxy.new(8080)
proxy.start_server
```

To filter responses and edit if needed, do the following:

```
proxy = Proxy.new(8080)

# Creates a proc object with the logic provided in the code block
handler = proc do |req, res|
  res.body = "This has been proxied!" if res['content-type'] = 'text/html'
end

proxy.add_rules(handler)
proxy.start_server
```