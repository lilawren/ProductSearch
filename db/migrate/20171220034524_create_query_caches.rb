class CreateQueryCaches < ActiveRecord::Migration[5.1]
  def change
    create_table :query_caches do |t|
      t.string :query
      t.text :results

      t.timestamps
    end
  end
end
