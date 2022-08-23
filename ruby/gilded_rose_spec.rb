require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
#    it "does not change the name" do
#     items = [Item.new("foo", 0, 0)]
#      GildedRose.new(items).update_quality()
#      expect(items[0].name).to eq "foo"
#    end
    it "updates quality of aged brie accordingly after one day" do
      items = [Item.new("Aged Brie", 2, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(3)
    end
    it "updates quality of common items accordingly after one day" do
      items = [Item.new("")]
    end   
  end

end
