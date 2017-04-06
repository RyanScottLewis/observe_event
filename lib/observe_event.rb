# frozen_string_literal: true

require 'version'

# Small and effective implementation of the observer pattern to define event methods on objects
module ObserveEvent
  is_versioned

  def event(name)
    define_method(name) do |*arguments, &block| # TODO: Allow below, they get tacked onto the block arguments
      raise ArgumentError, 'Arguments cannot be passed with a block' if !block.nil? && !arguments.empty?

      events = instance_variable_get("@#{name}")

      return if block.nil? && events.nil?
      return events.each { |event| event.call(*arguments) } if block.nil?
      return instance_variable_set("@#{name}", [block]) if events.nil?

      events << block
    end
  end

  def event_writer(name)
    event("#{name}_changed")

    define_method("#{name}=") do |current_value|
      previous_value = instance_variable_get("@#{name}")

      instance_variable_set("@#{name}", current_value)
      send("#{name}_changed", previous_value, current_value)

      current_value
    end
  end

  def event_accessor(name)
    attr_reader(name)
    event_writer(name)
  end
end
