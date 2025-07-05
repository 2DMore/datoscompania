require 'csv'

class ItemsController < ApplicationController
  def index
    @items =Item.all
    @total_general= @items.sum(&:subtotal)
  end

  def import
    file=params[:file]

    if file.nil?
      redirect_to items_path, alert: "Por favor, selecciona un documento valido."
      return
    end

    CSV.foreach(file.path, headers: true, col_sep: "\t") do |row|
      Item.create(
        cliente: row["Cliente"],
        descripcion: row["Descripción del Producto"],
        precio: row["Precio por pieza"],
        piezas: row["Numero de piezas"],
        direccion: row["Diección del vendedor"], #Asi esta escrito en el documento de ejemplo
        vendedor: row["Nombre del Vendedor"]
      )
    end

    redirect_to items_path, notice: "Items agregados correctamente"
  end

  def destroy_all
    Item.delete_all
    redirect_to items_path, notice: "Todos los items se han eliminado"
  end
end
