class CreateLocales < ActiveRecord::Migration[6.0]
  def change
    create_table :locales do |t|
      t.string :city
      t.string :state
      t.string :weather_words
      t.string :weather_icon
      t.float :temperature
      t.string :user_ip

      t.timestamps
    end
  end
end
