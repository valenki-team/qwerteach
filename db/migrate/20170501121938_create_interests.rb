class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.belongs_to :topic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
