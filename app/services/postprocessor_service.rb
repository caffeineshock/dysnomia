require  'singleton'

class PostprocessorService
  include Singleton
  
  def toHTML(text)
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::MentionFilter,
      HTML::Pipeline::EmojiFilter
    ], {
      :asset_root => "/images",
      :base_url   => "/users/"
    }

    pipeline.call(text)[:output].to_s
  end
end