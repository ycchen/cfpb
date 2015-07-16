class CreateConsumerCompliants < ActiveRecord::Migration
  def change
    create_table :consumer_compliants do |t|
    	t.datetime :date_received
    	t.string :product
    	t.string :sub_product
    	t.string :issue
    	t.string :sub_issue
    	t.string :consumer_compliant_narrative
    	t.string :company_public_response
    	t.string :company
    	t.string :state
    	t.string :zip_code
    	t.string :submitted_via
    	t.datetime :date_sent_to_company
    	t.string :company_to_consumer
    	t.boolean :timely_response
			t.string :consumer_disputed
    	t.integer :complaint_id
      t.timestamps
    end
  end
end