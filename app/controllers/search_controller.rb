class SearchController < ApplicationController
  def index
    render locals: {
      facade: HouseMembersSearchFacade.new(params[:house])
    }
  end

  def member_count
    members.count
  end

  def members
    conn = Faraday.new(url: "http://westerosapi.herokuapp.com/api/v1/house/#{@house}?#{ENV['WESTOROS-API-KEY']}") do |f|
      f.params["api_key"] = ENV['WESTOROS-API-KEY']
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/api/v1/house/#{@house}?api_key=egg")

    house_member_search_info = JSON.parse(response.body, symbolize_names: true)["data"][0]["attributes"]["members"]

    house_member_search_info.map do |search_info|
      Member.new(search_info)
    end
  end

  private
  attr_reader :house
end
