module Admin::AdminHelper
  def render_errors(obj)
    if obj.errors.any?
      content_tag :div, class: 'alert alert-error' do
        html = ''
        html << "<h2>#{pluralize(obj.errors.count, 'error')} prohibited this "\
                "#{obj.class.name.underscore.humanize.downcase} from being saved:</h2>"
        html << '<ul>'
        obj.errors.full_messages.each do |msg|
          html << "<li>#{msg}</li>"
        end 
        html << '</ul>'

        html.html_safe
      end.html_safe
    end 
  end 
end
