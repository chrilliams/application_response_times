module ApplicationHelper
  def active_item?( item )
    'class="active"'.html_safe if controller_name.to_sym == item
  end

  def sortable( column, title = nil )
    title ||= column.titleize
    #direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    #css_class = column == sort_column ? 'current #{sort_direction}' : nil
    css_class = 
      if column == sort_column && sort_direction =='asc'
	'<span class="glyphicon glyphicon-chevron-up">&nbsp;</span>'
      elsif column == sort_column && sort_direction =='desc'
	'<span class="glyphicon glyphicon-chevron-down">&nbsp;</span>'
      else
	#'<span class="glyphicon glyphicon-minus">&nbsp;</span>'
''
      end
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to css_class.html_safe + title, {sort: column, direction: direction, filter: params[:filter] }, {class: ''}
  end

end
