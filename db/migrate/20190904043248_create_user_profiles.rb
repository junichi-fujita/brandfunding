class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.string "family_name"
      t.string "family_name_sub"
      t.string "last_name"
      t.string "last_name_sub"
      t.string "sex"
      t.string "birthday"
      t.integer "add_no"
      t.string "prefectures"
      t.text "address"
      t.integer "phone_no1"
      t.integer "phone_no2"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
