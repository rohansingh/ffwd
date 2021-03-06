def riemann
  require 'riemann/client'

  # Create a client. Host, port and timeout are optional.
  c = Riemann::Client.new :timeout => 5

  # Or a more complex one
  c.tcp << {
    :host => 'web3',
    :service => 'riemann/test',
    :state => 'ok',
    :metric => 63.5,
    :description => "63.5 milliseconds per request",
    :tags => ['ok', 'here'],
    :ok => "here",
  }
end

def statsd
  require 'statsd-ruby'

  s = Statsd.new

  s.timing 'statsd/timing', 1000 * rand
  s.increment 'statsd/count'
end

riemann
statsd
