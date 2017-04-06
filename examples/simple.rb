# frozen_string_literal: true

require 'observe_event'

# A simple "timer" class
class Timer
  extend ObserveEvent

  event :tick             # Define publisher/observable `tick`
  event_accessor :running # Define publisher/observable `running_changed`, which notifies it's subscribers/observers

  def state
    @running ? :running : :stopped
  end
end

timer = Timer.new

# Define subscriber to `running_changed` on the Timer instance
timer.running_changed do |from, to|
  puts "Timer#running changed from `#{from.inspect}` to `#{to.inspect}`"
  puts "Timer #{timer.state}"
end

# Define subscribers to `tick` on the Timer instance
timer.tick do
  puts 'Tick' if timer.running
end

timer.tick do
  puts 'Tock' if timer.running
end

timer.tick
timer.tick
timer.running = true
timer.tick
timer.tick
timer.running = false
timer.tick
timer.tick

# => Timer#running changed from `nil` to `true`
# => Timer running
# => Tick
# => Tock
# => Tick
# => Tock
# => Timer#running changed from `true` to `false`
# => Timer stopped
