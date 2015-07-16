class ConsumerCompliantWithGeoData < ActiveRecord::Base
	self.table_name = 'consumer_compliants_with_geo_data'
	self.primary_key = 'cp_id'
end
