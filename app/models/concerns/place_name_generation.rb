module PlaceNameGeneration
  ADJECTIVES = %w[
    abandoned
    ancient
    bustling
    charming
    desolate
    enchanted
    forgotten
    haunted
    hidden
    mysterious
    peaceful
    secluded
  ]

  PLACES = %w[
    bayou
    bog
    creek
    delta
    estuary
    lagoon
    marsh
    pond
    river
    swamp
    wetland
  ]

  def generate_place_name
    [
      ADJECTIVES.sample,
      PLACES.sample
    ].join("-")
  end
end
