require 'json'

module Reserve
  class Store
    attr_accessor :redis
    attr_accessor :default_timeout
    attr_accessor :key_prefix

    # Returns a new instance of Store
    #
    # @example
    #   item = Reserve::Store.new(Redis.new)
    #
    # @param redis [Object] Redis-like instance for storing items.
    # @param [Hash] opts the options to configure a new instance.
    # @option opts [Integer] :default_timeout The default key expiry.
    # @option opts [String] :key_prefix The word to prefix redis keys with.
    def initialize redis, opts={}
      @redis = redis

      @default_timeout = opts[:default_timeout] || 10800
      @key_prefix = opts[:key_prefix] || 'reserve'
    end

    # Cache a block with a given key.
    #
    # @example Simple
    #   item = reserve.store :item do
    #     { value: 'this is item' }
    #   end
    #
    # @param key [String] key to store the block under.
    # @param [Hash] opts the options to cache the block
    # @option opts [String] :timeout value to set the key expiry to be.
    # @option opts [String] :skip_cache skip the cache and execute the block
    #                         regardess of whether or not it's stored.
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

    # Clears all of the stored items.
    def clear
      keys = @redis.keys "#{@key_prefix}*"
      unless keys.empty?
        @redis.del keys
      end
    end
  end
end
