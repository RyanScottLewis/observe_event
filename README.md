# ObserveEvent

Enables an object to define an event method which to becomes a publisher/observable.
Subscribers/observers can to be defined dynamically via a block given to the event.

## Install

### Bundler: `gem "observe_event"`

### RubyGems: `gem install observe_event`

## Usage

```rb
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
```

See the `examples/` directory for more examples.

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RyanScottLewis/observe_eventt.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
