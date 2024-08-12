class CreateQualityProjects < ActiveRecord::Migration[7.0]
  def change
    create_enum :approval_options, ["ready", "sent", "approved", "rejected"]
    create_enum :customers, ["sparky", "mctractor"]

    create_table :quality_projects do |t|
      t.references :part, null: false, foreign_key: true
      t.string :customer_request
      t.string :purchase_order
      t.boolean :report_approval, default: nil
      t.boolean :record_approval, default: nil


      t.timestamps
    end


    add_column :quality_projects, :customer_approval, :approval_options
    add_column :quality_projects, :customer, :customers, null: false
  end
end
