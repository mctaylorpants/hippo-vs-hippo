class Game < ApplicationRecord
  include PlaceNameGeneration

  # Submerge beats Charge
  # Chomp beats Submerge
  # Charge beats Chomp
  VALID_CHOICES = %w[charge submerge chomp]

  before_save :set_place_name, if: -> { name.blank? }

  validate :host_and_opponent_are_different
  validates :host_choice, inclusion: { in: VALID_CHOICES }, allow_nil: true
  validates :opponent_choice, inclusion: { in: VALID_CHOICES }, allow_nil: true

  def role_of(player)
    player == host ? :host : :opponent
  end

  def host?(player)
    player == host
  end

  def opponent?(player)
    player == opponent
  end

  def can_join?(as:)
    host != as && opponent.nil?
  end

  def join(as:)
    update(opponent: as)
  end

  def move(as:, choice:)
    case as
    when host
      update(host_choice: choice)
    when opponent
      update(opponent_choice: choice)
    else
      raise "Invalid player: #{as}"
    end
  end

  def current_state
    if host.present? && opponent.blank?
      :awaiting_opponent
    elsif host_choice.blank? || opponent_choice.blank?
      :awaiting_choices
    elsif host_choice.present? && opponent_choice.present?
      :game_over
    end
  end

  def winner
    return unless host_choice.present? && opponent_choice.present?

    case [host_choice, opponent_choice]
    when %w[charge chomp], %w[submerge charge], %w[chomp submerge]
      host
    when %w[charge submerge], %w[submerge chomp], %w[chomp charge]
      opponent
    else
      :draw
    end
  end

  def reset!
    update!(opponent: nil, host_choice: nil, opponent_choice: nil)
  end

  private

  def set_place_name
    self.name = generate_place_name
  end

  def host_and_opponent_are_different
    if host == opponent
      errors.add(:opponent, "can't be the same as host")
    end
  end
end
