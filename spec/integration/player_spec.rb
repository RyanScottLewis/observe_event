# frozen_string_literal: true

require 'spec_helper'
require 'support/player'

RSpec.describe Player do
  describe 'When damage is taken' do
    let(:actual) { [] }

    example 'it should notify the `damage_taken` observers in the order subscribed' do
      subject.damage_taken { |amount| actual << amount }
      subject.damage_taken { actual << :hp }

      subject.take_damage

      expect(actual).to eq([5, :hp])
    end
  end

  describe 'When the name is changed' do
    example 'it should notify the `name_changed` observers in the order subscribed' do
      actual = nil

      subject.name_changed { |from, to| actual = [from, to] }

      subject.name = 'Insane Jack'
      expect(actual).to eq([nil, 'Insane Jack'])

      subject.name = 'Sane Jack'
      expect(actual).to eq(['Insane Jack', 'Sane Jack'])
    end
  end

  describe 'When the age is changed' do
    example 'it should notify the `age_changed` observers in the order subscribed' do
      actual = nil

      subject.age_changed { |from, to| actual = [from, to] }

      subject.age = 21
      expect(actual).to eq([20, 21])
    end
  end
end
