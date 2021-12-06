# frozen_string_literal: true

class LanternFish
  def initialize(ttl = 8)
    @ttl = ttl
  end

  def age
    @ttl
  end

  def tick
    if @ttl.zero?
      @ttl = 6
      LanternFish.new
    else
      @ttl -= 1
      nil
    end
  end
end
