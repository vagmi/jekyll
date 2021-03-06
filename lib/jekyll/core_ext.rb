class Hash
  # Merges self with another hash, recursively.
  #
  # This code was lovingly stolen from some random gem:
  # http://gemjack.com/gems/tartan-0.1.1/classes/Hash.html
  #
  # Thanks to whoever made it.
  def deep_merge(hash)
    target = dup

    hash.keys.each do |key|
      if hash[key].is_a? Hash and self[key].is_a? Hash
        target[key] = target[key].deep_merge(hash[key])
        next
      end

      target[key] = hash[key]
    end

    target
  end
end

require 'ostruct'

class OpenStruct
  def merge!(params)
    params.keys.each do |k|
      self.send("#{k}=",params[k])
    end
  end
  def get_binding
    binding
  end
end

class ClosedStruct < OpenStruct
  def method_missing(symbol, *args)
    raise(NoMethodError, "undefined method `#{symbol}' for #{self}")
  end
end
