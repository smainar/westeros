class SearchController < ApplicationController
  def index
    render locals: {
      facade: HouseMembersSearchFacade.new(params[:house])
    }
  end
end
