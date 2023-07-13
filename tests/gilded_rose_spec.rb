require File.join(File.dirname(__FILE__), '../gilded_rose')
require_relative '../gilded_rose/item_aged_brie'
require_relative '../gilded_rose/item_backstage'
require_relative '../gilded_rose/item_sulfuras'
require_relative '../gilded_rose/item_conjured'

FOO = "Foo"
AGED_BRIE = ItemAgedBrie::NAME
SULFURAS = ItemSulfuras::NAME
BACKSTAGE = ItemBackstage::NAME
CONJURED = ItemConjured::NAME

def update_quality(items)
  GildedRose.new(items).update_quality
end

describe GildedRose do

  describe "#update_quality" do
    it "doesn't change the name" do
      items = [Item.new(FOO, 0, 0)]
      update_quality(items)
      expect(items[0].name).to eq FOO
    end

    it "should decrease quality single" do
      items = [Item.new(FOO, 3, 10)]
      update_quality(items)
      assert_item(items[0], 2, 9)
    end

    it "should decrease quality double" do
      items = [Item.new(FOO, 0, 10)]
      update_quality(items)
      assert_item(items[0], -1, 8)
    end

    it "doesn't have a negative quality" do
      items = [Item.new(FOO, 0, 0)]
      update_quality(items)
      assert_item(items[0], -1, 0)
    end

    it "Aged brie should increase quality single" do
      items = [Item.new(AGED_BRIE, 2, 5)]
      update_quality(items)
      assert_item(items[0], 1, 6)
    end

    it "Aged brie should increase quality double" do
      items = [Item.new(AGED_BRIE, 0, 5)]
      update_quality(items)
      assert_item(items[0], -1, 7)
    end

    it "Quality is never bigger that 50" do
      items = [Item.new(AGED_BRIE, 0, 50)]
      update_quality(items)
      assert_item(items[0], -1, 50)
    end

    it "Sulfuras quality can be 80 as maximum" do
      items = [Item.new(SULFURAS, 0, 80)]
      update_quality(items)
      assert_item(items[0], 0, 80)
    end

    it "Backstage ticket quality increase double if sell_in is between 10 and 6" do
      items = Array.new(5) { |i| Item.new(BACKSTAGE, i + 6, 20) }
      update_quality(items)
      (6..10).each { |i| assert_item(items[i - 6], i - 1, 22) }
    end

    it "Backstage ticket quality increase triple if sell_in is between 5 and 1" do
      items = Array.new(5) { |i| Item.new(BACKSTAGE, i + 1, 20) }
      update_quality(items)
      (1..5).each { |i| assert_item(items[i - 1], i - 1, 23) }
    end

    it "Backstage ticket sell_in arrives to zero, quality must be zero also" do
      items = [Item.new(BACKSTAGE, 0, 50)]
      update_quality(items)
      assert_item(items[0], -1, 0)
    end

    it "Conjured item decrease quality double" do
      items = [
        Item.new(CONJURED, 10, 50),
        Item.new(CONJURED, 0, 50),
      ]
      update_quality(items)
      assert_item(items[0], 9, 48)
      assert_item(items[1], -1, 46)
    end
  end

end

def assert_item(item, sell_in, quality)
  expect(item.sell_in).to eq sell_in
  expect(item.quality).to eq quality
end