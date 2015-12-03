class CreateTables < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :full_name
			t.string :email
			t.string :username
			t.string :password
			t.string :bio
			t.timestamps null:false
		end
		create_table :questions do |t|
			t.string :text
			t.integer :user_id
			t.timestamps null:false
		end
		create_table :answers do |t|
			t.string :content
			t.integer :user_id
			t.integer :question_id
			t.timestamps null:false
		end
	end
end
