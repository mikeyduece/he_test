class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.jsonb :query, null: false, default: '{}'

      t.timestamps
    end
    
    add_index :searches, :query, using: :gin
  end
end
