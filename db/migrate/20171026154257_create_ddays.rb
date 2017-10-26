class CreateDdays < ActiveRecord::Migration[5.1]
    def change
        create_table :ddays do |t|
            t.references :project, foreign_key: true
            t.datetime :day
            t.boolean :success

            t.timestamps
        end
    end
end
