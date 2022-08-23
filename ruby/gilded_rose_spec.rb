require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
#    it "does not change the name" do
#     items = [Item.new("foo", 0, 0)]
#      GildedRose.new(items).update_quality()
#      expect(items[0].name).to eq "foo"
#    end
    describe 'updates quality' do
      it "updates quality of aged brie accordingly after one day" do
        items = [Item.new("Aged Brie", 2, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(3)
      end

      it "updates quality of common items accordingly after one day" do
        items = [Item.new("+5 Dexterity Vest",10,20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(19)
      end

      it "update quiality normal item when sell in minus equal a zero degrades twice" do
        items = [Item.new("+5 Dexterity Vest",0,20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(18)
      end

      it "the quality of an item is never more than 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert",5,50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(50)
      end

      it "the quality of an item is never negative" do
        items = [Item.new("+5 Dexterity Vest",10,0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(0)
      end

      it "aged brie increases in 1 when quality is near of sell in" do
        items = [Item.new("Aged Brie",10,8)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(9)
      end

      it "aged brie item quality increase twice when sell_in day passes" do
        items = [Item.new("Aged Brie",0,8)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(10)
      end
    end
    
    describe "Updates sell in" do
      it "update sell in items accordingly after one day" do
        items = [Item.new("+5 Dexterity Vest",10,20)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(9)
      end

      it "not update sell in item on sulfuras accordingly after one day" do
        items = [Item.new("Sulfuras, Hand of Ragnaros",10,20)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(10)
      end
    end
  end

end
