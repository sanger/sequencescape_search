module SequencescapeSearch
  # Passed into SequencescapeSearch and describes a particular search
  # name: The name of a search
  # parameter: The search parameter name passed in the post
  # return_map: A hash of keys that will be returned, and their 'address' in the json response
  SearchEndpoint = Struct.new(:name,:parameter,:return_map)
end
