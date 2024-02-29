
require "test_helper"

class ArtistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @category = Category.new(name: "Sports")


  end
  test "Category should be valid" do
    # @category = Category.new(name: "Sports")
    assert @category.valid?

  end

  test "name should be present" do
    @category = Category.new(name: " ")
    assert_not @category.valid?
  end

  test "name should be unique" do
    # @category = Category.new(name: "Sports")
    @category.save
    @category1 = Category.new(name: "Sports")
    assert_not @category1.valid?
  end
  test "name should not be too long" do
    @category.name = 'a'*26
    assert_not @category.valid?

  end
  test "name should not be too short" do
    @category.name = 'a'
    assert_not @category.valid?

  end

end

