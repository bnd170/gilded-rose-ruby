# frozen_string_literal: true
require_relative 'item_base'

class ItemAgedBrie < ItemBase

  NAME = "Aged Brie"
  MAX_QUALITY = 50

  def update
    rest_day
    increase_quality
  end

  private
  def increase_quality
    if @item.sell_in < 0
      @item.quality += 2
    else
      @item.quality += 1
    end

    set_max_quality
  end

  def set_max_quality
    if @item.quality > MAX_QUALITY
      @item.quality = MAX_QUALITY
    end
  end
end