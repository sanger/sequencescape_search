module SequencescapeSearch
  # The search has been configured with an invalid name
  SearchNotFound = Class.new(StandardError)
  # Sequencescape returned an unexpected response, such as a 500
  SequencescapeError = Class.new(StandardError)
  # Sequencesape returned a 503
  SequencescapeBusy = Class.new(SequencescapeError)
end
