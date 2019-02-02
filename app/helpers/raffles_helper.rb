module RafflesHelper
  def human_price(raffle)
    "#{raffle.price} €"
  end

  def common_headers
    ['Nombre', 'Papeletas vendidas', 'Recaudado', 'Vender', 'Ranking', 'Buscar']
  end

  def common_values(raffle)
    [
      raffle.name,
      raffle.tickets.count,
      "#{raffle.amount_gathered.to_i}€",
      link_to('Vender', raffle_sell_path(raffle)),
      link_to('Ranking', raffle_assignments_path(raffle)),
      link_to('Buscar', raffle_search_path(raffle))
    ]
  end

  def extra_headers
    ['Añadir vendedor']
  end

  def extra_values(raffle)
    can_create_assignment?(raffle) ? [link_to('Añadir vendedor', new_raffle_assignment_path(raffle))] : []
  end

  private

  def can_create_assignment?(raffle)
    can?(:create, Assignment.new(raffle_id: raffle.id))
  end
end
