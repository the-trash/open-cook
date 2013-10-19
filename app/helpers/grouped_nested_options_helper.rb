# Custom view module for TheSortableTree gem
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

        if @options[:children].blank?
          option(node, options)
        else
          grouped_options(node, options)
        end
      end

      def option node, options
        this_node = options[:selected] == node
        selected  = this_node ? " selected='selected'" : nil
        "<option value='#{node[:id]}' #{selected} class='l_#{options[:level]}'>#{ node.send(options[:title]) }</option>"
      end

      def grouped_options node, options
        unless node.optgroup?
          option(node, options) + options[:children]
        else
          "<optgroup label='#{node.send options[:title]}'>#{ options[:children] }</optgroup>"
        end
      end

    end
  end
end