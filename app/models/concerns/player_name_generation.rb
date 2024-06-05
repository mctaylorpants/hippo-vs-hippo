module PlayerNameGeneration
  ADJECTIVES = %w[
    agile
    boorish
    crude
    hangry
    hungry
    jolly
    lazy
    lucky
    mighty
    submerged
    surly
  ]

  COLOURS = %w[
    amaranth
    amber
    azure
    cerulean
    chartreuse
    citrine
    flint
    hickory
    persimmon
    pewter
    sepia
    thistle
  ]

  HIPPO_NAMES = %w[
    artiodactyl
    hippo
    hippopotamus
    mammal
    riverhorse
  ]

  def generate_player_name
    [
      ADJECTIVES.sample.capitalize,
      COLOURS.sample.capitalize,
      HIPPO_NAMES.sample.capitalize
    ].join(" ")
  end
end
