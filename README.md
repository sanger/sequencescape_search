# SequencescapeSearch

A simple alternative to the sequencescape-client-api gem, when only a few endpoints are required

## Installation

Add this line to your application's Gemfile:

    gem 'sequencescape_search'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequencescape_search

## Usage

- Create a SequencescapeSearch::Search per endpoint
```ruby
proxy = ENV.fetch('FARADAY_PROXY','')
sequencescape_uri = ENV.fetch('SEQUENCESCAPE_URI','http://localhost:3000/api/1')
sequencescape_headers = { 'ACCEPT'=>'application/json', 'x-sequencescape-client-id'=>'development', 'Content-Type'=>' application/json'}
api_root = Faraday.new(sequencescape_uri, proxy: proxy, headers: sequencescape_headers )
search = SequencescapeSearch.new(api_root,SequencescapeSearch.plate_barcode_search)
```
- Call #query on the created search to retrieve the results as a hash
```ruby
search.find('122345')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
