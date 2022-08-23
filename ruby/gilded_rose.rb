# frozen_string_literal: true

# Main logic class
class GildedRose
  # ----- Rules -----
  #
  #   - All items have a SellIn value which denotes the number of days we have to sell the item
  #   - all items have a quality value which denotes how valuable the item is
  #   - At the end of each day our system lowers both values for every item
  #
  #   Pretty simple, right? Well this is where it gets interesting:
  #
  #   - Once the sell by date has passed, Quality degrades twice as fast
  #   - The Quality of an item is never negative
  #   - "Aged Brie" actually increases in Quality the older it gets
  #   - The Quality of an item is never more than 50
  #   - "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
  #   - "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
  #   Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
  #   Quality drops to 0 after the concert
  #
  # We have recently signed a supplier of conjured items. This requires an update to our system:
  #
  #   - "Conjured" items degrade in Quality twice as fast as normal items

  def initialize(items)
    @items = items
  end

  # ----- Objects types -----

  def aged_brie?(item)
    item.name == 'Aged Brie'
  end

  def backstage?(item)
    item.name == 'Backstage passes to a TAFKAL80ETC concert'
  end

  def sulfuras?(item)
    item.name == 'Sulfuras, Hand of Ragnaros'
  end

  def normal_item?(item)
    !aged_brie?(item) && !backstage?(item) && !sulfuras?(item) && !conjured_item?(item)
  end

  def conjured_item?(item)
    item.name.include?('Conjured')
  end

  # ----- quality above 0 and quality below-equal 50 -----

  def quality_above_0?(item)
    item.quality.positive? # item > 0
  end

  def quality_under_equal50?(item)
    item.quality <= 50
  end

  # ----- Manage objects quality -----

  def normal_item_manage_quality(item)
    return if item.quality.zero?
    return item.quality -= 2 if item.sell_in <= 0

    item.quality -= 1
  end

  def backstage_manage_quality(item)
    return item.quality = 0 if item.sell_in <= 0
    return if item.quality == 50
    return item.quality += 3 if item.sell_in <= 5 && item.quality != 49
    return item.quality += 2 if item.sell_in <= 10 && item.quality != 49

    item.quality += 1
  end

  def aged_brie_manage_quality(item)
    return item.quality += 2 if item.sell_in <= 0

    item.quality += 1
  end

  def conjured_manage_quality(item)
    return item.quality = 0 if item.sell_in <= 0

    item.quality -= 2
  end

  # ----- "Main methods" -----

  def update_quality_per_objects(item)
    normal_item_manage_quality(item) if quality_above_0?(item) && normal_item?(item) # ✅
    backstage_manage_quality(item) if quality_under_equal50?(item) && backstage?(item) # ✅
    aged_brie_manage_quality(item) if quality_under_equal50?(item) && aged_brie?(item) # ✅
    conjured_manage_quality(item) if conjured_item?(item) # ✅
  end

  def update_quality
    @items.each do |item|
      update_quality_per_objects(item)
      item.sell_in -= 1 unless sulfuras?(item)
    end
  end
end

# Class Item to create items
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
