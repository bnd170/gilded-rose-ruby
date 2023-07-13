# frozen_string_literal: true

class ItemStandard

  def initialize(item)
    @item = item
  end

  def applies_to?(item)
    true
  end

  def update

  end

  private
  def decrease_quality
    @item.quality -= 1
  end

  def rest_day
    @item.sell_in -= 1
  end
end