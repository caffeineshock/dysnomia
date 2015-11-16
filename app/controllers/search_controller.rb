class SearchController < ApplicationController
  def index
    @results = ResultDecorator.decorate_collection(search params[:q])
  end

  private

  def search query
  	PgSearch.multisearch(query).to_a.delete_if { |r| r.searchable.nil? }
  end
end
