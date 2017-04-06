# frozen_string_literal: true

require 'observe_event'

# A simple "user" class
class User
  extend ObserveEvent

  def initialize(name)
    @elevated = false
    self.name = name
  end

  event :permissions_elevated # Define publisher/observable `permissions_elevated`

  def elevate_permissions
    @elevated = true

    permissions_elevated # Notify `permissions_elevated` subscribers/observers
  end

  event_accessor :name # Define publisher/observable `name_changed`, which notifies it's subscribers/observers
end

user = User.new('Jeff')

user.name_changed do |from, to| # Define subscriber
  puts 'User name changed'
  puts "From: #{from}"
  puts "To: #{to}"
  puts '-' * 80
  p user
  p self
  puts
end

user.permissions_elevated do # Define subscriber
  puts 'User permissions elevated'
  puts '-' * 80
  p user
  p self
  puts
end

user.name = 'Geoff' # Notify observers via `event_accessor :name`

user.elevate_permissions # Notify observers via `event :permissions_elevated`

__END__
Output:
$ be ruby ./examples/simple.rb
User name changed
From: Jeff
To: Geoff
--------------------------------------------------------------------------------
#<User:0x007fb60e19b8f8 @name="Geoff", @name_changed=[#<Proc:0x007fb60e19b6c8@./examples/simple.rb:23>], @permissions_elevated=[#<Proc:0x007fb60e19b5b0@./examples/simple.rb:33>]>
main

User permissions elevated
--------------------------------------------------------------------------------
#<User:0x007fb60e19b8f8 @name="Geoff", @name_changed=[#<Proc:0x007fb60e19b6c8@./examples/simple.rb:23>], @permissions_elevated=[#<Proc:0x007fb60e19b5b0@./examples/simple.rb:33>]>
main
