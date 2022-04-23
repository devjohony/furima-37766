class CreateDerivelyFees < ActiveRecord::Migration[6.0]
  def change
    create_table :derively_fees do |t|

      t.timestamps
    end
  end
end
