class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :wins
      t.integer :mm_points
      t.string :password_digest

      t.timestamps
    end
  end
end
