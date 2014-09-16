class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
	  t.integer :user_id
      t.string :name
	  t.string :blood_type
	  t.string :location
	  t.string :contact_info
	  t.string :occupation
	  t.date :last_donated
      t.text :notes

      t.timestamps
    end
  end
end
