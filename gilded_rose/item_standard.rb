# frozen_string_literal: true
require_relative 'item_base'

class ItemStandard < ItemBase

  def initialize(item)
    @item = item
  end

  def applies?
    true
  end

  def update
    rest_day
    decrease_quality
  end

  private
  def decrease_quality
    if @item.sell_in < 0
      @item.quality -= 2
    else
      @item.quality -= 1
    end

    ensure_quality_is_not_negative
  end

  def ensure_quality_is_not_negative
    @item.quality = 0 if @item.quality < 0
  end
end