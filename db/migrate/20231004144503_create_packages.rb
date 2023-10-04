class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.text :desc, null: false
      t.date :expected, null: false
      t.boolean :delivered, default: false
      t.text :notes
      t.belongs_to :owner, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
