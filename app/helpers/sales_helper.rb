module SalesHelper

  def active_sale? 
    Sale.active.any?
  end

  def sale_name
    if Sale.active.any?
    Sale.active.first.name
  end
  end

  def sale_percent
    if Sale.active.any?
      Sale.active.first.percent_off / 100.to_f
    end
  end
end
