require 'singleton'
require 'task_list/filter'
require 'html/pipeline/wiki_link'

class PostprocessorService
  include Singleton

  def toHTML(text)
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      TaskList::Filter,
      HTML::Pipeline::WikiLinkFilter,
      HTML::Pipeline::MentionFilter,
      HTML::Pipeline::EmojiFilter
    ], {
      asset_root:        "/images",
      base_url:          "/users/",
      wiki_base_url:     "/pages/",
      username_pattern:  /[A-Za-z0-9][a-z0-9-]*/
    }

    pipeline.call(text)[:output].to_s
  end
end
