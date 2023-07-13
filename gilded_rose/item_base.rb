# frozen_string_literal: true

class ItemBase

  NAME = nil

  def name
    self.class::NAME
  end

  def initialize(item)
    @item = item
  end

  def applies?
    @item.name == name
  end

  def update
    raise NotImplementedError
  end

  protected

  def rest_day
    @item.sell_in -= 1
  end
end
