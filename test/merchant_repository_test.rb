require 'minitest/autorun'
require 'minitest/pride'

require 'pry'

require './lib/merchant_repository'
require './lib/merchant'
require './lib/finder'

class MerchantRepositoryTest < Minitest::Test

  def setup
    # these tests might break with specharness / require relative
    @path = './data/merchants.csv'
    @repo = MerchantRepository.new(@path)

    # -- from CSV --
    # 12334105,Shopin1901,2010-12-10,2011-12-04
    # 12334112,Candisart,2009-05-30,2010-08-29
    @merch1_data = {:name => "Shopin1901", :created_at => "2010-12-10", :updated_at => "2011-12-04"}
    @merch2_data = {:name => "Candisart", :created_at => "2009-05-30", :updated_at => "2010-08-29"}

    @merch1 = {:"12334105" => @merch1_data }
    @merch2 = {:"12334112" => @merch2_data}

    @merchant1 = Merchant.new( {id: 12334105, name: "Shopin1901"} )
    @merchant2 = Merchant.new( {id: 12334112, name: "Candisart"} )

   
  end

    def test_it_exists
      assert_instance_of MerchantRepository, @repo
    end

    def test_it_can_make_all_merchants
      merch = @repo.merchants.first(100)
      assert_equal 100, merch.count
      assert_equal 100, merch.uniq.count
      assert_equal 12334105, merch[0].id
      assert_equal "Shopin1901", merch[0].name
    end

    def test_it_can_use_Finder_module
      expected = [{:name=>"Shopin1901", :created_at=>"2010-12-10", :updated_at=>"2011-12-04"}]
      actual = @repo.find_entry_by_name('merchant', 'Shopin1901')
      assert_equal expected, actual

      # binding.pry
      expected = [{:name=>"jejum", :created_at=>"2007-06-25", :updated_at=>"2015-09-09"}]
      actual = @repo.find_entry_by_name('merchant', 'jejum')
      assert_equal expected, actual
    end

end
