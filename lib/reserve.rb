require "reserve/version"
require "reserve/store"

module Reserve
  # Create a new Reserve instance.
  def self.new redis, opts={}
    Reserve::Store.new redis, opts
  end
end
