class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :nome
      t.string :senha
      t.integer :tipo, default: 0

      t.timestamps
    end
  end
end
