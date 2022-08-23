# frozen_string_literal: true

# Main logic class
class GildedRose
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
