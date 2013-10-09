module GroupedNestedOptionsHelper
  def grouped_nested_options tree, options = {}
    build_server_tree(tree, { render_module: RenderGroupedNestedOptionsHelper }.merge!(options))
  end
end

module RenderGroupedNestedOptionsHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options
        node = options[:node]
        this_node = options[:selected] == node
        selected  = this_node ? " selected='selected'" : nil

        if @options[:children].blank?
          "<option value='#{node[:id]}' #{selected}>#{ node.send(options[:title]) }</option>"
        else
          grouped_options
        end
      end

      def grouped_options
        node = @options[:node]
        "<optgroup label='#{node.send @options[:title]}'>#{ @options[:children] }</optgroup>"
      end

    end
  end
end