# frozen_string_literal: true

# A player class
class Player
  extend ObserveEvent

  def initialize
    @hp  = 100
    @age = 20
  end

  event :damage_taken

  def take_damage
    amount = 5

    @hp -= amount
    @hp = 0 if @hp.negative?

    damage_taken(amount)
  end

  def name
    @name ||= 'Unknown'
  end

  event_writer :name

  event_accessor :age
end
