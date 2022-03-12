class CreateServicedLsoas < ActiveRecord::Migration[7.0]
  def change
    create_table :serviced_lsoas do |t|
      t.string :lsoa_prefix

      t.timestamps
    end
  end
end
