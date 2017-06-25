module TicketsHelper

  def tickets_table(first, last, occupied)
    bootstrap_table class: 'tickets' do |table|
      (first..last).to_a.in_groups_of(10) do |row|
        table.rows << row.map do |e|
          html_class = occupied.include?(e) ? 'red' : 'green'
            content_tag :span, e, class: "ticket #{html_class}"
        end
      end
    end
  end

  PAGINATOR_WINDOW_SIZE = 3

  def tickets_paginator(first_item, raffle)
    first_page = 1
    last_page = raffle.max_number_of_tickets / 100

    current_page = first_item / 100 + 1

    puts "current_page: #{current_page}"

    valid_pages = (first_page..last_page).to_a

    elements_in_paginator = ((current_page - PAGINATOR_WINDOW_SIZE)..(current_page + PAGINATOR_WINDOW_SIZE)).to_a & valid_pages

    content_tag :div, class: 'paginator' do
      elements_in_paginator.map do |page|
        button_type = current_page == page ? 'default' : 'primary'
        link_to (page - 1), raffle_tickets_path(raffle, page: page), class: "btn btn-#{button_type}"
      end.inject(:+)
    end
  end
end
