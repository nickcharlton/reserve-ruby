require 'json'

module Reserve
  class Store
    def initialize(redis)
      @redis = redis
    end

    def keep(key, expiry, &block)
      item = @redis.get key.to_s
      if item
        item = JSON.parse item, {symbolize_names: true}
      else
        item = block.call

        @redis.pipelined do
          @redis.set key.to_s, item.to_json
          @redis.expire key.to_s, expiry
        end
      end

      item
    end
  end
end
