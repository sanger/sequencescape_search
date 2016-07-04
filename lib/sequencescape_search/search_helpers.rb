module SequencescapeSearch
  # Returns a ready configured SearchEndpoint for the user swipecard search
  def self.swipecard_search
    SequencescapeSearch::SearchEndpoint.new('Find user by swipecard code','swipecard_code',{:uuid=>['user','uuid'],:login=>['user','login']})
  end

  # Returns a ready configured SearchEndpoint for the plate barcode search
  def self.plate_barcode_search
    SequencescapeSearch::SearchEndpoint.new('Find assets by barcode','barcode',{:uuid=>['plate','uuid'],:name=>['plate','name'],:external_type=>["plate","plate_purpose","name"]})
  end
end
