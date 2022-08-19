class GildedRose
  def initialize(items)
    @items = items
  end

  # - Once the sell by date has passed, Quality degrades twice as fast
	# - The Quality of an item is never negative
	# - The Quality of an item is never more than 50
	# - "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
	# Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
	# Quality drops to 0 after the concert


  # - "Aged Brie" actually increases in Quality the older it gets
	# - "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
  def method_test1(item)
    if item.quality > 0
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.quality = item.quality - 1
      end
    end
  end

  def method_test2(item)
    item.quality = item.quality + 1
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in < 11
          item.quality = item.quality + 1 if quality_under_50?(item)
        end
        if item.sell_in < 6
          item.quality = item.quality + 1 if quality_under_50?(item)
        end
      end
  end

  def quality_under_50?(item)
    item.quality < 50
  end


  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        method_test1(item)
      else
        method_test2(item) if quality_under_50?(item)
      end

      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end

      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          item.quality = item.quality + 1 if quality_under_50?(item)
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
