class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.string :ip, null: false
      t.string :ip_type
      t.string :continent_code
      t.string :continent_name
      t.string :country_code
      t.string :country_name
      t.string :region_code
      t.string :region_name
      t.string :city
      t.string :zip
      t.string :latitude
      t.string :longitude
      t.string :msa
      t.string :dma
      t.string :radius

      t.timestamps
    end

    add_index :geolocations, :ip
  end
end
