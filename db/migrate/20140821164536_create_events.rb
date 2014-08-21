class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.column :description, :string
      t.column :location, :string
      t.column :start, :datetime
      t.column :end, :datetime

      t.timestamps
    end
  end
end
