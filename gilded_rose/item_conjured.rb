# frozen_string_literal: true
require_relative 'item_base'

class ItemConjured < ItemBase

  NAME = "Conjured Mana Cake"

  def initialize(item)
    @item = item
  end

  def update
    rest_day
    decrease_quality
  end

  private
  def decrease_quality
    if @item.sell_in < 0
      @item.quality -= 4
    else
      @item.quality -= 2
    end

    ensure_quality_is_not_negative
  end

  def ensure_quality_is_not_negative
    @item.quality = 0 if @item.quality < 0
  end

end