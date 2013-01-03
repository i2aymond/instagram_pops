class InstagramPop < ActiveRecord::Base
  attr_accessible :caption, :comments_count, :id, :likes_count, :link, :low_resolution_url, :standard_resolution_url, :username
  require 'open-uri'

  def self.find(*args)
    result = fetch_instagram(args[0])
    i = 0
    while i <= 50 && result["link"] && find_by_link(result["link"])
      # if we find a dup, fetch again, but if it is more than 50 times, forget about it
      result = fetch_instagram(args[0])
      i += 1
    end

    picture = find_or_create_by_id(args[0])
    picture.id = args[0]
    picture.username = result["user"]["username"]
    picture.caption = result["caption"] ? result["caption"]["text"] : ""
    picture.comments_count = result["comments"] ? result["comments"]["count"] : 0
    picture.likes_count = result["likes"] ? result["likes"]["count"] : 0
    picture.link = result["link"]
    picture.low_resolution_url = result["images"]["low_resolution"]["url"]
    picture.standard_resolution_url = result["images"]["standard_resolution"]["url"]
    picture.save
    picture
  end

  def self.access_token
    "86484.1fb234f.878b66812b8448948c78604ba9bc67cd"
  end

  def self.fetch_instagram(index)
    result = JSON.parse(open("https://api.instagram.com/v1/media/popular?access_token=#{access_token}").read)

    result = result["data"]
    if index < 0
      index = 0
    elsif index >= result.size
      index = result.size - 1
    end
    return result[index]
  end
end
