class ResultDecorator < ApplicationDecorator
  delegate_all

  def title
    object.searchable.is_a?(Upload) ? object.searchable.file_file_name : object.searchable.title
  end

  def icon
  	{
  		upload: :download,
  		event: :calendar,
  		pad: :pencil,
  		channel: :comments,
  		page: :"page-edit",
  		task: :checkbox
  	}.find { |k, v| k.eql? object.searchable.class.name.downcase.to_sym }[1]
  end
end
