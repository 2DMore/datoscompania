class Item < ApplicationRecord

  def subtotal
    precio * piezas
  end
end
