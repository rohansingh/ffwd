require 'evd/processor'
require 'evd/logging'
require 'evd/event'

module EVD::Processor
  #
  # Implements counting statistics (similar to statsd).
  #
  class CountProcessor
    include EVD::Logging
    include EVD::Processor

    register_type "count"

    def initialize(opts={})
      @cache_limit = opts[:cache_limit] || 10000
      @cache = {}
    end

    def process(core, m)
      key = m[:key]
      value = m[:value]

      if prev = @cache[key]
        value = prev + value
      elsif @cache.size >= @cache_limit
        log.warning "Dropping cache update '#{key}', limit reached"
        return
      end

      @cache[key] = value
      core.emit :key => key, :value => value, :source => key
    end
  end
end