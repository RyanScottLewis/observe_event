# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ObserveEvent do
  subject do
    Class.new { extend ObserveEvent }
  end

  describe 'VERSION' do
    let(:expectation) { read('VERSION') }

    it 'should have the correct version number' do
      expect(ObserveEvent::VERSION).to eq(expectation)
    end
  end

  describe '.event' do
    before { subject.event(:triggered) }

    it 'should define the notifier/subscribe method' do
      defined = subject.instance_methods.include?(:triggered)
      expect(defined).to eq(true)

      method = subject.instance_method(:triggered)
      expect(method.arity).to eq(-1)
    end

    describe 'the notifier/subscribe method' do
      let(:actual) { [] }
      let(:instance) { subject.new }

      before do
        instance.triggered { actual << 0 }
        instance.triggered { actual << 1 }
      end

      it 'should notify the observers in the order subscribed' do
        instance.triggered

        expect(actual).to eq([0, 1])
      end
    end
  end

  describe '.event_writer' do
    before { subject.event_writer(:name) }

    it 'should define the notifier method' do
      defined = subject.instance_methods.include?(:name=)
      expect(defined).to eq(true)

      method = subject.instance_method(:name=)
      expect(method.arity).to eq(1)
    end

    describe 'the notifier method' do
      let(:instance) { subject.new }

      it 'should notify the observers in the order subscribed' do
        actual = nil

        instance.name_changed { |from, to| actual = [from, to] }
        instance.name = 'Desmos'

        expect(actual).to eq([nil, 'Desmos'])
      end
    end
  end

  describe '.event_accessor' do
    before { subject.event_accessor(:name) }

    it 'should define the notifier method' do
      defined = subject.instance_methods.include?(:name=)
      expect(defined).to eq(true)

      method = subject.instance_method(:name=)
      expect(method.arity).to eq(1)
    end

    it 'should define the getter method' do
      defined = subject.instance_methods.include?(:name)
      expect(defined).to eq(true)

      method = subject.instance_method(:name)
      expect(method.arity).to eq(0)
    end

    describe 'the notifier method' do
      let(:instance) { subject.new }

      it 'should notify the observers in the order subscribed' do
        actual = nil

        instance.name_changed { |from, to| actual = [from, to] }
        instance.name = 'Desmos'

        expect(actual).to eq([nil, 'Desmos'])
      end
    end
  end
end
