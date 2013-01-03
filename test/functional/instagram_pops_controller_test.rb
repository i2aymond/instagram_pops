require 'test_helper'

class InstagramPopsControllerTest < ActionController::TestCase
  setup do
    class << InstagramPop
      # Need a way to stub find overwritten in instagram_pop.rb
      def find(id)
        picture = new
        picture.id = id
        picture.username = "chanelwestcoast"
        picture.caption = "Wassup I am rich"
        picture.comments_count = 386
        picture.likes_count = 16461
        picture.link = "http://instagr.am/p/TE9MpbNIE0/"
        picture.low_resolution_url = "http://distilleryimage4.s3.amazonaws.com/3744fe92433011e283e822000a1f8e5b_6.jpg"
        picture.standard_resolution_url = "http://distilleryimage4.s3.amazonaws.com/3744fe92433011e283e822000a1f8e5b_7.jpg"
        picture
      end
    end
    @instagram_pop = instagram_pops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instagram_pops)
  end

  test "should show instagram_pop" do
    get :show, id: @instagram_pop
    assert_response :success
    assert_not_nil assigns(:instagram_pop)
  end

  test "should have the path 'showcase'" do
    get :showcase
    assert_response :success
  end

  test "should return 404 when Instagram doesn't return anything" do
    class << InstagramPop
      # Need a way to fail fetching from Instagram
      def find(id)
        raise
      end
    end

    get :show, id: @instagram_pop
    assert_response :missing
  end
end
