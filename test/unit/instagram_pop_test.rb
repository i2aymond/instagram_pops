require 'test_helper'

class InstagramPopTest < ActiveSupport::TestCase
  setup do
    class << InstagramPop
      # Need a way to stub find overwritten in instagram_pop.rb
      def fetch_instagram(index)
        result = {
          'comments' => {
            'count' => 386
          },
          'likes' => {
            'count' => 16461
          },
          'images' => {
            'low_resolution' => {
              'url' => "http://distilleryimage4.s3.amazonaws.com/3744fe92433011e283e822000a1f8e5b_6.jpg"
            },
            'standard_resolution' => {
              'url' => "http://distilleryimage4.s3.amazonaws.com/3744fe92433011e283e822000a1f8e5b_7.jpg"
            }
          },
          'caption' => {
            'text' => "I'm pround to introduce to the world mine & @steelobrim's daughter"
          },
          'user' => {
            'username' => "chanelwestcoast"
          },
          'link' => "http://instagr.am/p/TE9MpbNIE0/#{index}"
        }
      end
    end

    @instagram_pop = instagram_pops(:one)
  end

  test "multiple finds will generate multiple instances" do
    assert_difference('InstagramPop.count', 2) do
      InstagramPop.find(Time.now.to_i)
      InstagramPop.find(Time.now.to_i + 1)
    end
  end

  test "no infinite loops if link is always dup" do
    class << InstagramPop
      # stub again but this time link will be duplicated
      def fetch_instagram(index)
        result = {
          'comments' => {
            'count' => 386
          },
          'likes' => {
            'count' => 16461
          },
          'images' => {
            'low_resolution' => {
              'url' => "http://distilleryimage4.s3.amazonaws.com/3744fe92433011e283e822000a1f8e5b_6.jpg"
            },
            'standard_resolution' => {
              'url' => "http://distilleryimage4.s3.amazonaws.com/3744fe92433011e283e822000a1f8e5b_7.jpg"
            }
          },
          'caption' => {
            'text' => "I'm pround to introduce to the world mine & @steelobrim's daughter"
          },
          'user' => {
            'username' => "chanelwestcoast"
          },
          'link' => "http://instagr.am/p/TE9MpbNIE0"
        }
      end
    end
    assert_difference('InstagramPop.count', 2) do
      InstagramPop.find(Time.now.to_i)
      InstagramPop.find(Time.now.to_i + 1)
    end
  end

  test "the usual values" do
    assert_equal("chanelwestcoast", @instagram_pop.username)
    assert_equal(386, @instagram_pop.comments_count)
    assert_equal(16461, @instagram_pop.likes_count)
    assert_equal("I'm pround to introduce to the world mine & @steelobrim's daughter", @instagram_pop.caption)
    assert_equal("http://distilleryimage4.s3.amazonaws.com/3744fe92433011e283e822000a1f8e5b_6.jpg", @instagram_pop.low_resolution_url)
    assert_equal("http://distilleryimage4.s3.amazonaws.com/3744fe92433011e283e822000a1f8e5b_7.jpg", @instagram_pop.standard_resolution_url)
  end

  test "when Instagram returns blank" do
    class << InstagramPop
      # Need a way to stub find overwritten in instagram_pop.rb
      def fetch_instagram(index)
        raise
      end
    end

    assert_raise(RuntimeError) do
      InstagramPop.find(Time.now.to_i)
    end
  end
end
