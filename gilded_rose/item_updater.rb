# frozen_string_literal: true

require_relative 'item_aged_brie'
require_relative 'item_sulfuras'
require_relative 'item_standard'
require_relative 'item_backstage'
require_relative 'item_conjured'

class ItemUpdater
  class << self
    # create an array to hold all the item types
    ITEM_TYPES = [
      ItemAgedBrie,
      ItemSulfuras,
      ItemBackstage,
      ItemConjured,
      ItemStandard,
    ]
    def update(item)
      ITEM_TYPES.each { |type|
        item_type = type.new(item)
        if item_type.applies?
          item_type.update
          return
        end
      }
    end
  end
end