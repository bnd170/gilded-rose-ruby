# frozen_string_literal: true
require_relative 'item_base'

class ItemBackstage < ItemBase

  NAME = "Backstage passes to a TAFKAL80ETC concert"
  MAX_QUALITY = 50

  def update
    rest_day
    increase_quality
  end

  private
  def increase_quality
    if sell_in_passed?
      @item.quality = 0
    elsif sell_in_is_five_or_less?
      @item.quality += 3
    elsif sell_in_is_ten_or_less?
      @item.quality += 2
    else
      @item.quality += 1
    end

    set_max_quality
  end

  def sell_in_passed?
    @item.sell_in < 0
  end

  def sell_in_is_five_or_less?
    @item.sell_in < 5
  end

  def sell_in_is_ten_or_less?
    @item.sell_in < 10
  end

  def set_max_quality
    if @item.quality > MAX_QUALITY
      @item.quality = MAX_QUALITY
    end
  end
end