class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :cliente
      t.string :descripcion
      t.decimal :precio
      t.integer :piezas
      t.string :direccion
      t.string :vendedor

      t.timestamps
    end
  end
end
