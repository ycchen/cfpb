class HomeController < ApplicationController
  def index
  # 	@cp_cnt = ConsumerCompliant.count
  # 	@cp_cnt_with_zipcode = ConsumerCompliant.where('zip_code is not null').count
  # 	@income_cnt = IncomeData.count
  # 	@geography_cnt = GeographyData.count
  # 	@geo_data = GeographyData.order(:ZCTA5)
  # 	@income_data = IncomeData.limit(2000)
  	query = "select cp.zip_code, gdata.SUBMCD, gdata.STUSAB, gdata.SUMLEVEL, gdata.COMPONENT, gdata.LOGRECNO, gdata.NAME, gdata.BTTR, * from consumer_compliants as cp
    inner join geography_data as gdata on cp.zip_code = gdata.SUBMCD
    where cp.zip_code = '22201'
    order by cp.zip_code"
		@consumer_compliant_geodata = ActiveRecord::Base.connection.execute(query)

		@submitted_via_result = ConsumerCompliant.group(:submitted_via).count
		@by_product = ConsumerCompliant.group(:product).count
		@by_state   = ConsumerCompliant.where('state IS NOT NULL').group(:state).count
		@by_sub_product = ConsumerCompliant.where('sub_product IS NOT NULL').group(:sub_product).count

    group_by_year_query = "select strftime('%Y', date_received) yr_mon, count(*) num_dates from consumer_compliants group by yr_mon"
    @complaints_by_year = ActiveRecord::Base.connection.execute(group_by_year_query)

    group_by_year_ca_query = "select strftime('%Y', date_received) yr_mon, count(*) num_code from consumer_compliants where STATE='CA' group by yr_mon"
    @complaints_by_ca = ActiveRecord::Base.connection.execute(group_by_year_ca_query)

    group_by_year_fl_query = "select strftime('%Y', date_received) yr_mon, count(*) num_code from consumer_compliants where STATE='FL' group by yr_mon"
    @complaints_by_fl = ActiveRecord::Base.connection.execute(group_by_year_fl_query)

    group_by_year_tx_query = "select strftime('%Y', date_received) yr_mon, count(*) num_code from consumer_compliants where STATE='TX' group by yr_mon"
    @complaints_by_tx = ActiveRecord::Base.connection.execute(group_by_year_tx_query)

    group_by_year_ny_query = "select strftime('%Y', date_received) yr_mon, count(*) num_code from consumer_compliants where STATE='NY' group by yr_mon"
    @complaints_by_ny = ActiveRecord::Base.connection.execute(group_by_year_ny_query)

    group_by_year_ga_query = "select strftime('%Y', date_received) yr_mon, count(*) num_code from consumer_compliants where STATE='GA' group by yr_mon"
    @complaints_by_ga = ActiveRecord::Base.connection.execute(group_by_year_ga_query)
    
    # group_by_logrecno_query = "select LOGRECNO, count(*) as cnt from consumer_compliants_with_geo_data group by LOGRECNO"
    # @complaints_by_logrecno = ActiveRecord::Base.connection.execute(group_by_logrecno_query)


    # ca_income_query = "select * from income_data_with_geo_data a inner join consumer_compliants b on a.submcd = b.zip_code where b.state = 'CA'"
    # @ca_income = ActiveRecord::Base.connection.execute(ca_income_query)
  end

  def income
  	@income_data = IncomeData.limit(2000)
  	query = 'select * from income_data as income inner join geography_data as gdata on income.LOGRECNO = gdata.LOGRECNO'
  	@income_with_geodata = ActiveRecord::Base.connection.execute(query)
  end
end
