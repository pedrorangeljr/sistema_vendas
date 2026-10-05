class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :cpf, null: false
      t.string :email
      t.string :phone

      t.string :zip_code
      t.string :street
      t.string :number
      t.string :complement
      t.string :city
      t.string :state, limit: 2

      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :customers, :cpf, unique: true
    add_index :customers, :email, unique: true
  end
end
