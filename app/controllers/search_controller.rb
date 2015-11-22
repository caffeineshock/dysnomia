class SearchController < ApplicationController
  def index
    @results = ResultDecorator.decorate_collection(search params[:q])
  end

  private

  def search query
  	PgSearch.multisearch(query).order(:updated_at).to_a.delete_if do |r|
  	  r.searchable.nil? or (r.searchable.is_a? Channel and r.searchable.visible_for? current_user)
  	end
  end
end
