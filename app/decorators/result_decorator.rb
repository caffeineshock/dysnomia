class ResultDecorator < ApplicationDecorator
  delegate_all

  def title
    object.searchable.is_a?(Upload) ? object.searchable.file_file_name : object.searchable.title
  end
end
