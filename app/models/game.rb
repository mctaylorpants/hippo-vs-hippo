class Game < ApplicationRecord
  include NameGeneration

  before_save :set_name, if: -> { name.blank? }

  validate :host_and_opponent_are_different

  def can_join?(as:)
    host_uuid != as && opponent_uuid.nil?
  end

  def join(as:)
    update(opponent_uuid: as)
  end

  private

  def set_name
    self.name = generate_name
  end

  def host_and_opponent_are_different
    if host_uuid == opponent_uuid
      errors.add(:opponent_uuid, "can't be the same as host")
    end
  end
end
