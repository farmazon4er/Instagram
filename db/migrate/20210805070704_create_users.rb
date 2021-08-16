class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :name, presence: true
      t.string :bio

      t.timestamps
    end
  end
end
