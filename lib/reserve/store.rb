require 'json'

module Reserve
  class Store
    attr_accessor :redis
    attr_accessor :default_timeout
    attr_accessor :key_prefix

    def initialize redis, opts={}
      @redis = redis

      @default_timeout = opts[:default_timeout] || 10800
      @key_prefix = opts[:key_prefix] || 'reserve'
    end

    def store key, opts={}, &block
      real_key = "#{@key_prefix}_#{key.to_s}"
      timeout = opts[:timeout] || @default_timeout

      if opts[:skip_cache]
        return block.call
      end

      item = @redis.get real_key
      if item
        item = JSON.parse item, {symbolize_names: true}
      else
        item = block.call

        @redis.pipelined do
          @redis.set real_key, item.to_json
          @redis.expire real_key, timeout
        end
      end

      item
    end
  end
end
