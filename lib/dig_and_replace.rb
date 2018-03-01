require "dig_and_replace/version"

module DigAndReplace
# Your code goes here...
  def dig_and_replace(replacement,*keys)
    dig_and_set(replacement,keys.shift,keys)
  end

  private
  def dig_and_set(replacement,key,nextKeys)
    value = (self[key] rescue nil)
    if nextKeys.empty?
      nextKeys.inject(self, :fetch)[key] = replacement
    elsif value.respond_to?(:dig_and_replace,true)
      value.dig_and_replace(replacement,*nextKeys)
    end
  end
end

Hash.send(:include, DigAndReplace)
Array.send(:include, DigAndReplace)
