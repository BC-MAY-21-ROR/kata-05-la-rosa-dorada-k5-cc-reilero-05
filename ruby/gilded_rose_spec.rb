require File.join(File.dirname(__FILE__), 'gilded_rose')

def item_checker_quality(name, sellin, quality, exp)
  items = [Item.new(name, sellin, quality)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(exp)
end

def item_checker_sellin(name, sellin, quality, exp)
  items = [Item.new(name, sellin, quality)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(exp)
end

describe GildedRose do

  describe "#update_quality" do
#    it "does not change the name" do
#     items = [Item.new("foo", 0, 0)]
#      GildedRose.new(items).update_quality()
#      expect(items[0].name).to eq; "foo"
#    end
    describe 'updates quality per object' do
      it "updates quality of aged brie accordingly after one day" do
        item_checker_quality("Aged Brie", 2, 25, 26)
      end

      it "updates quality of common items accordingly after one day" do
        item_checker_quality("+5 Dexterity Vest", 10, 20, 19)
      end

      it "update normal items quality when sell in minus equal a zero degrades twice" do
        item_checker_quality("+5 Dexterity Vest", 0, 20, 18)
      end

      it "the quality of an item is never more than 50" do
        item_checker_quality("Backstage passes to a TAFKAL80ETC concert", 5, 50, 50)
      end

      it "the quality of an item is never negative" do
        item_checker_quality("+5 Dexterity Vest", 10, 0, 0)
      end

      it "aged brie increases in 1 when quality is near of sell in" do
        item_checker_quality("Aged Brie", 10, 8, 9)
      end

      it "aged brie item quality increase twice when sell_in day passes" do
        item_checker_quality("Aged Brie", 0, 8, 10)
      end

      it "conjured items quality degrades twice as fast" do
        item_checker_quality("Conjured Mana Cake", 2, 4, 2)
      end
    end
    
    describe "Updates sell in" do
      it "update sell in items accordingly after one day" do
        item_checker_sellin("+5 Dexterity Vest", 10, 20, 9)
      end

      it "not update sell in item on sulfuras accordingly after one day" do
        item_checker_sellin("Sulfuras, Hand of Ragnaros", 10, 20, 10)
      end
    end
  end
end