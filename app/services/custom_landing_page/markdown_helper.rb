module CustomLandingPage

  # Limited HTML Markdown Renderer extend the default
  # Redcarpet HTML rendered, but it ignores certain Markdown block.
  #
  # See the list of IGNORED_BLOCKS to see which blocks are ignored.
  # The commented blocks in the list are available.
  #
  class LimitedHTMLMarkdownRenderer < Redcarpet::Render::HTML

    IGNORED_BLOCKS = [
      'block_code',
      'block_quote',
      'block_html',
      'footnotes',
      'footnote_def',
      'header',
      'hrule',
      'list',
      'list_item',
      # 'paragraph',
      'table',
      'table_row',
      'table_cell',
      'autolink',
      'codespan',
      # 'double_emphasis',
      # 'emphasis',
      'image',
      # 'linebreak',
      # 'link',
      'raw_html',
      # 'triple_emphasis',
      # 'strikethrough',
      'superscript',
      # 'underline',
      'highlight',
      'quote',
      'footnote_ref',
    ].each do |ignored_block|
      define_method ignored_block do |*|
        nil
      end
    end
  end

  module MarkdownHelper

    # Main method to render Markdown
    def render_markdown(str)
      markdown.render(str).html_safe
    end

    # Memoize the Markdown instance, as instructed in
    # the Redcarpet documentation.
    #
    # Read more: https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use
    #
    def markdown
      @markdown ||= Redcarpet::Markdown.new(LimitedHTMLMarkdownRenderer, autolink: true, tables: true)
    end

    # Deprecated
    #
    # Use Markdown string instead of array
    #
    # This method was added to maintain backwards compatibility. We
    # allowed the contents to be passed as an Array in order to render
    # multi paragraph content.
    #
    def render_markdown_array(arr)
      if arr.is_a?(Array)
        arr.map { |str| render_markdown(str) }.join().html_safe
      else
        render_markdown(arr)
      end
    end
  end
end
