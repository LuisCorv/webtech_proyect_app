class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.text :incident_description, null: false
      t.datetime :creation_date,null: false, default: Time.now
      t.datetime :resolution_date,null: false, default: Time.now
      t.datetime :response_to_user_date,null: false, default: Time.now
      t.integer :priority,null: false, default: 0
      t.integer :state, null: false, default: 0
      t.integer :resolution_key,null: false, default: 0
      t.integer :response_key,null: false, default: 0
      t.text :response_to_user,null: false, default: ""
      t.integer :accept_or_reject_solution,null: false, default: 0
      t.integer :star_number,null: false, default: 6
      t.datetime :limit_time_response, null: false, default: Time.now
      t.datetime :limit_time_resolution, null: false, default: Time.now

      t.timestamps
    end
  end
end
