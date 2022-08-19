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

  #method_test1 se asegura de bajar la calidad de los items que no sean el item sulfuras
  def method_test1(item)
    if item.quality > 0
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.quality = item.quality - 1
      end
    end
  end

  # method_test2 se asegura de subir la calidad de los pases a backstage acorde a las condiciones
  def method_test2(item)
    item.quality = item.quality + 1
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        # verifica que el sell_in sea menor a 11 y 6 para luego verificar la calidad del item
        sell_in_under_to?(item, 11) ? (item.quality = item.quality + 1 if quality_under_50?(item) ) : nil
        sell_in_under_to?(item, 6) ? (item.quality = item.quality + 1 if quality_under_50?(item) ) : nil
      end
  end

  # quality_under_50? verifica que la calidad sea menor a 50
  # CHANGE PENDING
  def quality_under_50?(item)
    item.quality < 50
  end

  # sell_in_under_to? verifica que sell_in sea menor a sell_in de condición
  def sell_in_under_to?(item, sell_in)
    item.sell_in < sell_in
  end

  # update_quality2 
  def update_quality2(item)
    if item.name != "Aged Brie"
      update_quality2_condition1(item)
    else
      item.quality = item.quality + 1 if quality_under_50?(item)
    end
  end

  def update_quality2_condition1(item)
    if item.name != "Backstage passes to a TAFKAL80ETC concert"
      quality_above_zero?(item) ? update_quality2_condition1_quality_above_zero(item) : nil
    else
      item.quality = item.quality - item.quality
    end
  end

  def update_quality2_condition1_quality_above_zero(item)
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.quality = item.quality - 1
    end
  end

  # CHANGE PENDING
  def quality_above_zero?(item)
    item.quality > 0
  end

  # verifica que los items se mantengan debajo de 50 en calidad y encima de 0
  def condition1(item)
    if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
     method_test1(item)
   else
      method_test2(item) if quality_under_50?(item)
   end
  end

  # verifica que los items que no sean "sulfuras" reduzcan su fecha de sell-in en 1
  def condition2(item)
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end
  end

  # verifican que si un item tiene su fecha de sell_in debajo de 0 se actualice su calidad acorde a qué tipo de item es
  def condition3(item)
    sell_in_under_to?(item,0) ?
       update_quality2(item)
      : nil
  end

  #update_quality actualiza la calidad para los items registrados 
  def update_quality()
    @items.each do |item|
      condition1(item)
      condition2(item)
      condition3(item)
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
