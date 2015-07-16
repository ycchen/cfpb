namespace :import_data do
	require 'csv'

	desc 'import consumer compliant csv data'
	# rake import_data:load_compliant_data
	task :load_compliant_data => :environment do
	row_cnt = 0
		CSV.foreach('lib/tasks/Consumer_Complaints.csv',:headers => true) do |row|
			row_cnt +=1
				# puts "#{row}"
				date_received = row[0]
		    product = row[1]
		    sub_product = row[2]
		    issue = row[3]
		    sub_issue = row[4]
		    consumer_compliant_narrative = row[5]
		    company_public_response = row[6]
		    company = row[7]
		    state = row[8]
		    zip_code = row[9]
		    submitted_via = row[10]
		    date_sent_to_company = row[11]
		    company_to_consumer = row[12]
		    timely_response = row[13]
				consumer_disputed = !row[14].blank? ? row[14] : nil
		    complaint_id = row[15].to_i
		    # puts "06/30/2015| Credit reporting| | Incorrect information on credit report| Account status| | Company chooses not to provide a public response| Experian| TX| 75251| Web| 06/30/2015| Closed with non-monetary relief| Yes| | 1444169"
		    puts "#{row[0]}| #{row[1]}| #{row[2]}| #{row[3]}| #{row[4]}| #{row[5]}| #{row[6]}| #{row[7]}| #{row[8]}| #{row[9]}| #{row[10]}| #{row[11]}| #{row[12]}| #{row[13]}| #{row[14]}| #{row[15]}\n"
		    complaint = ConsumerCompliant.create!(
		    	:date_received => Date.strptime(date_received,'%m/%d/%Y'),
			    :product => product,
			    :sub_product => sub_product,
			    :issue => issue,
			    :sub_issue => sub_issue,
			    :consumer_compliant_narrative => consumer_compliant_narrative,
			    :company_public_response => company_public_response,
			    :company => company,
			    :state => state,
			    :zip_code => zip_code,
			    :submitted_via => submitted_via,
			    :date_sent_to_company => Date.strptime(date_sent_to_company,'%m/%d/%Y'),
			    :company_to_consumer => company_to_consumer,
			    :timely_response => timely_response,
					:consumer_disputed => consumer_disputed,
			    :complaint_id => complaint_id)

		end

	end


	desc 'import geography information for the 5-year ACS survery data'
	# rake import_data:load_geography_data
	task :load_geography_data => :environment do
		row_cnt = 0
		CSV.foreach('lib/tasks/g20135us.csv',:headers => true) do |row|
			row_cnt +=1
			if row_cnt != 1
				puts "#{row.size}"
				puts "#{row}"
				g_data = GeographyData.new
				g_data.FILEID = row["FILEID"]
				g_data.STUSAB = row["STUSAB"]
				g_data.SUMLEVEL = row["SUMLEVEL"]
				g_data.COMPONENT = row["COMPONENT"]
				g_data.LOGRECNO = row["LOGRECNO"]
				g_data.US = row["US"]
				g_data.REGION = row["REGION"]
				g_data.DIVISION = row["DIVISION"]
				g_data.STATECE = row["STATECE"]
				g_data.STATE = row["STATE"]
				g_data.COUNTY = row["COUNTY"]
				g_data.COUSUB = row["COUSUB"]
				g_data.PLACE = row["PLACE"]
				g_data.TRACT = row["TRACT"]
				g_data.BLKGRP = row["BLKGRP"]
				g_data.CONCIT = row["CONCIT"]
				g_data.AIANHH = row["AIANHH"]
				g_data.AIANHHFP = row["AIANHHFP"]
				g_data.AIHHTLI = row["AIHHTLI"]
				g_data.AITSCE = row["AITSCE"]
				g_data.AITS = row["AITS"]
				g_data.ANRC = row["ANRC"]
				g_data.CBSA = row["CBSA"]
				g_data.CSA = row["CSA"]
				g_data.METDIV = row["METDIV"]
				g_data.MACC = row["MACC"]
				g_data.MEMI = row["MEMI"]
				g_data.NECTA = row["NECTA"]
				g_data.NECTADIV = row["NECTADIV"]
				g_data.UA = row["UA"]
				g_data.BLANK1 = row["BLANK1"]
				g_data.CDCURR = row["CDCURR"]
				g_data.SLDU = row["SLDU"]
				g_data.SLDL = row["SLDL"]
				g_data.BLANK2 = row["BLANK2"]
				g_data.BLANK3 = row["BLANK3"]
				g_data.ZCTA5 = row["ZCTA5"]
				g_data.SUBMCD = row["SUBMCD"]
				g_data.SDELM = row["SDELM"]
				g_data.SDSEC = row["SDSEC"]
				g_data.SDUNI = row["SDUNI"]
				g_data.UR = row["UR"]
				g_data.PCI = row["PCI"]
				g_data.BLANK4 = row["BLANK4"]
				g_data.BLANK5 = row["BLANK5"]
				g_data.PUMA5 = row["PUMA5"]
				g_data.BLANK6 = row["BLANK6"]
				g_data.GEOID = row["GEOID"]
				g_data.NAME = row["NAME"]
				g_data.BTTR = row["BTTR"]
				g_data.BTBG = row["BTBG"]
				g_data.BLANK7 = row["BLANK7"]
				g_data.save!
			end
		end

	end


	desc 'import income data from the 5-year ACS survey file'
	# rake import_data:load_income_data
	task :load_income_data => :environment do
		row_total_cnt = 0
		['e20135us0015000.txt','m20135us0015000.txt'].each do |file|
			row_cnt = 0
			cols = %w(FILEID FILETYPE STUSAB CHARITER SEQUENCE LOGRECNO B06010_001 B06010_002 B06010_003 B06010_004 B06010_005 B06010_006 B06010_007 B06010_008 B06010_009 B06010_010 B06010_011 B06010_012 B06010_013 B06010_014 B06010_015 B06010_016 B06010_017 B06010_018 B06010_019 B06010_020 B06010_021 B06010_022 B06010_023 B06010_024 B06010_025 B06010_026 B06010_027 B06010_028 B06010_029 B06010_030 B06010_031 B06010_032 B06010_033 B06010_034 B06010_035 B06010_036 B06010_037 B06010_038 B06010_039 B06010_040 B06010_041 B06010_042 B06010_043 B06010_044 B06010_045 B06010_046 B06010_047 B06010_048 B06010_049 B06010_050 B06010_051 B06010_052 B06010_053 B06010_054 B06010_055 B06010PR_001 B06010PR_002 B06010PR_003 B06010PR_004 B06010PR_005 B06010PR_006 B06010PR_007 B06010PR_008 B06010PR_009 B06010PR_010 B06010PR_011 B06010PR_012 B06010PR_013 B06010PR_014 B06010PR_015 B06010PR_016 B06010PR_017 B06010PR_018 B06010PR_019 B06010PR_020 B06010PR_021 B06010PR_022 B06010PR_023 B06010PR_024 B06010PR_025 B06010PR_026 B06010PR_027 B06010PR_028 B06010PR_029 B06010PR_030 B06010PR_031 B06010PR_032 B06010PR_033 B06010PR_034 B06010PR_035 B06010PR_036 B06010PR_037 B06010PR_038 B06010PR_039 B06010PR_040 B06010PR_041 B06010PR_042 B06010PR_043 B06010PR_044 B06010PR_045 B06010PR_046 B06010PR_047 B06010PR_048 B06010PR_049 B06010PR_050 B06010PR_051 B06010PR_052 B06010PR_053 B06010PR_054 B06010PR_055 B06011_001 B06011_002 B06011_003 B06011_004 B06011_005 B06011PR_001 B06011PR_002 B06011PR_003 B06011PR_004 B06011PR_005 B06012_001 B06012_002 B06012_003 B06012_004 B06012_005 B06012_006 B06012_007 B06012_008 B06012_009 B06012_010 B06012_011 B06012_012 B06012_013 B06012_014 B06012_015 B06012_016 B06012_017 B06012_018 B06012_019 B06012_020 B06012PR_001 B06012PR_002 B06012PR_003 B06012PR_004 B06012PR_005 B06012PR_006 B06012PR_007 B06012PR_008 B06012PR_009 B06012PR_010 B06012PR_011 B06012PR_012 B06012PR_013 B06012PR_014 B06012PR_015 B06012PR_016 B06012PR_017 B06012PR_018 B06012PR_019 B06012PR_020)
			CSV.foreach("lib/tasks/#{file}",:headers => true) do |row|
				row_cnt +=1
				row_total_cnt +=1
				# if row_cnt ==1
					puts "#{row}"
					income_data = IncomeData.new
					income_data.FILEID = row["FILEID"]
					income_data.FILETYPE = row["FILETYPE"]
					income_data.STUSAB = row["STUSAB"]
					income_data.CHARITER = row["CHARITER"]
					income_data.SEQUENCE = row["SEQUENCE"]
					income_data.LOGRECNO = row["LOGRECNO"]
					income_data.B06010_001 = row["B06010_001"].to_i
					income_data.B06010_002 = row["B06010_002"].to_i
					income_data.B06010_003 = row["B06010_003"].to_i
					income_data.B06010_004 = row["B06010_004"].to_i
					income_data.B06010_005 = row["B06010_005"].to_i
					income_data.B06010_006 = row["B06010_006"].to_i
					income_data.B06010_007 = row["B06010_007"].to_i
					income_data.B06010_008 = row["B06010_008"].to_i
					income_data.B06010_009 = row["B06010_009"].to_i
					income_data.B06010_010 = row["B06010_010"].to_i
					income_data.B06010_011 = row["B06010_011"].to_i
					income_data.B06010_012 = row["B06010_012"].to_i
					income_data.B06010_013 = row["B06010_013"].to_i
					income_data.B06010_014 = row["B06010_014"].to_i
					income_data.B06010_015 = row["B06010_015"].to_i
					income_data.B06010_016 = row["B06010_016"].to_i
					income_data.B06010_017 = row["B06010_017"].to_i
					income_data.B06010_018 = row["B06010_018"].to_i
					income_data.B06010_019 = row["B06010_019"].to_i
					income_data.B06010_020 = row["B06010_020"].to_i
					income_data.B06010_021 = row["B06010_021"].to_i
					income_data.B06010_022 = row["B06010_022"].to_i
					income_data.B06010_023 = row["B06010_023"].to_i
					income_data.B06010_024 = row["B06010_024"].to_i
					income_data.B06010_025 = row["B06010_025"].to_i
					income_data.B06010_026 = row["B06010_026"].to_i
					income_data.B06010_027 = row["B06010_027"].to_i
					income_data.B06010_028 = row["B06010_028"].to_i
					income_data.B06010_029 = row["B06010_029"].to_i
					income_data.B06010_030 = row["B06010_030"].to_i
					income_data.B06010_031 = row["B06010_031"].to_i
					income_data.B06010_032 = row["B06010_032"].to_i
					income_data.B06010_033 = row["B06010_033"].to_i
					income_data.B06010_034 = row["B06010_034"].to_i
					income_data.B06010_035 = row["B06010_035"].to_i
					income_data.B06010_036 = row["B06010_036"].to_i
					income_data.B06010_037 = row["B06010_037"].to_i
					income_data.B06010_038 = row["B06010_038"].to_i
					income_data.B06010_039 = row["B06010_039"].to_i
					income_data.B06010_040 = row["B06010_040"].to_i
					income_data.B06010_041 = row["B06010_041"].to_i
					income_data.B06010_042 = row["B06010_042"].to_i
					income_data.B06010_043 = row["B06010_043"].to_i
					income_data.B06010_044 = row["B06010_044"].to_i
					income_data.B06010_045 = row["B06010_045"].to_i
					income_data.B06010_046 = row["B06010_046"].to_i
					income_data.B06010_047 = row["B06010_047"].to_i
					income_data.B06010_048 = row["B06010_048"].to_i
					income_data.B06010_049 = row["B06010_049"].to_i
					income_data.B06010_050 = row["B06010_050"].to_i
					income_data.B06010_051 = row["B06010_051"].to_i
					income_data.B06010_052 = row["B06010_052"].to_i
					income_data.B06010_053 = row["B06010_053"].to_i
					income_data.B06010_054 = row["B06010_054"].to_i
					income_data.B06010_055 = row["B06010_055"].to_i
					income_data.B06010PR_001 = row["B06010PR_001"].to_i
					income_data.B06010PR_002 = row["B06010PR_002"].to_i
					income_data.B06010PR_003 = row["B06010PR_003"].to_i
					income_data.B06010PR_004 = row["B06010PR_004"].to_i
					income_data.B06010PR_005 = row["B06010PR_005"].to_i
					income_data.B06010PR_006 = row["B06010PR_006"].to_i
					income_data.B06010PR_007 = row["B06010PR_007"].to_i
					income_data.B06010PR_008 = row["B06010PR_008"].to_i
					income_data.B06010PR_009 = row["B06010PR_009"].to_i
					income_data.B06010PR_010 = row["B06010PR_010"].to_i
					income_data.B06010PR_011 = row["B06010PR_011"].to_i
					income_data.B06010PR_012 = row["B06010PR_012"].to_i
					income_data.B06010PR_013 = row["B06010PR_013"].to_i
					income_data.B06010PR_014 = row["B06010PR_014"].to_i
					income_data.B06010PR_015 = row["B06010PR_015"].to_i
					income_data.B06010PR_016 = row["B06010PR_016"].to_i
					income_data.B06010PR_017 = row["B06010PR_017"].to_i
					income_data.B06010PR_018 = row["B06010PR_018"].to_i
					income_data.B06010PR_019 = row["B06010PR_019"].to_i
					income_data.B06010PR_020 = row["B06010PR_020"].to_i
					income_data.B06010PR_021 = row["B06010PR_021"].to_i
					income_data.B06010PR_022 = row["B06010PR_022"].to_i
					income_data.B06010PR_023 = row["B06010PR_023"].to_i
					income_data.B06010PR_024 = row["B06010PR_024"].to_i
					income_data.B06010PR_025 = row["B06010PR_025"].to_i
					income_data.B06010PR_026 = row["B06010PR_026"].to_i
					income_data.B06010PR_027 = row["B06010PR_027"].to_i
					income_data.B06010PR_028 = row["B06010PR_028"].to_i
					income_data.B06010PR_029 = row["B06010PR_029"].to_i
					income_data.B06010PR_030 = row["B06010PR_030"].to_i
					income_data.B06010PR_031 = row["B06010PR_031"].to_i
					income_data.B06010PR_032 = row["B06010PR_032"].to_i
					income_data.B06010PR_033 = row["B06010PR_033"].to_i
					income_data.B06010PR_034 = row["B06010PR_034"].to_i
					income_data.B06010PR_035 = row["B06010PR_035"].to_i
					income_data.B06010PR_036 = row["B06010PR_036"].to_i
					income_data.B06010PR_037 = row["B06010PR_037"].to_i
					income_data.B06010PR_038 = row["B06010PR_038"].to_i
					income_data.B06010PR_039 = row["B06010PR_039"].to_i
					income_data.B06010PR_040 = row["B06010PR_040"].to_i
					income_data.B06010PR_041 = row["B06010PR_041"].to_i
					income_data.B06010PR_042 = row["B06010PR_042"].to_i
					income_data.B06010PR_043 = row["B06010PR_043"].to_i
					income_data.B06010PR_044 = row["B06010PR_044"].to_i
					income_data.B06010PR_045 = row["B06010PR_045"].to_i
					income_data.B06010PR_046 = row["B06010PR_046"].to_i
					income_data.B06010PR_047 = row["B06010PR_047"].to_i
					income_data.B06010PR_048 = row["B06010PR_048"].to_i
					income_data.B06010PR_049 = row["B06010PR_049"].to_i
					income_data.B06010PR_050 = row["B06010PR_050"].to_i
					income_data.B06010PR_051 = row["B06010PR_051"].to_i
					income_data.B06010PR_052 = row["B06010PR_052"].to_i
					income_data.B06010PR_053 = row["B06010PR_053"].to_i
					income_data.B06010PR_054 = row["B06010PR_054"].to_i
					income_data.B06010PR_055 = row["B06010PR_055"].to_i
					income_data.B06011_001 = row["B06011_001"].to_i
					income_data.B06011_002 = row["B06011_002"].to_i
					income_data.B06011_003 = row["B06011_003"].to_i
					income_data.B06011_004 = row["B06011_004"].to_i
					income_data.B06011_005 = row["B06011_005"].to_i
					income_data.B06011PR_001 = row["B06011PR_001"].to_i
					income_data.B06011PR_002 = row["B06011PR_002"].to_i
					income_data.B06011PR_003 = row["B06011PR_003"].to_i
					income_data.B06011PR_004 = row["B06011PR_004"].to_i
					income_data.B06011PR_005 = row["B06011PR_005"].to_i
					income_data.B06012_001 = row["B06012_001"].to_i
					income_data.B06012_002 = row["B06012_002"].to_i
					income_data.B06012_003 = row["B06012_003"].to_i
					income_data.B06012_004 = row["B06012_004"].to_i
					income_data.B06012_005 = row["B06012_005"].to_i
					income_data.B06012_006 = row["B06012_006"].to_i
					income_data.B06012_007 = row["B06012_007"].to_i
					income_data.B06012_008 = row["B06012_008"].to_i
					income_data.B06012_009 = row["B06012_009"].to_i
					income_data.B06012_010 = row["B06012_010"].to_i
					income_data.B06012_011 = row["B06012_011"].to_i
					income_data.B06012_012 = row["B06012_012"].to_i
					income_data.B06012_013 = row["B06012_013"].to_i
					income_data.B06012_014 = row["B06012_014"].to_i
					income_data.B06012_015 = row["B06012_015"].to_i
					income_data.B06012_016 = row["B06012_016"].to_i
					income_data.B06012_017 = row["B06012_017"].to_i
					income_data.B06012_018 = row["B06012_018"].to_i
					income_data.B06012_019 = row["B06012_019"].to_i
					income_data.B06012_020 = row["B06012_020"].to_i
					income_data.B06012PR_001 = row["B06012PR_001"].to_i
					income_data.B06012PR_002 = row["B06012PR_002"].to_i
					income_data.B06012PR_003 = row["B06012PR_003"].to_i
					income_data.B06012PR_004 = row["B06012PR_004"].to_i
					income_data.B06012PR_005 = row["B06012PR_005"].to_i
					income_data.B06012PR_006 = row["B06012PR_006"].to_i
					income_data.B06012PR_007 = row["B06012PR_007"].to_i
					income_data.B06012PR_008 = row["B06012PR_008"].to_i
					income_data.B06012PR_009 = row["B06012PR_009"].to_i
					income_data.B06012PR_010 = row["B06012PR_010"].to_i
					income_data.B06012PR_011 = row["B06012PR_011"].to_i
					income_data.B06012PR_012 = row["B06012PR_012"].to_i
					income_data.B06012PR_013 = row["B06012PR_013"].to_i
					income_data.B06012PR_014 = row["B06012PR_014"].to_i
					income_data.B06012PR_015 = row["B06012PR_015"].to_i
					income_data.B06012PR_016 = row["B06012PR_016"].to_i
					income_data.B06012PR_017 = row["B06012PR_017"].to_i
					income_data.B06012PR_018 = row["B06012PR_018"].to_i
					income_data.B06012PR_019 = row["B06012PR_019"].to_i
					income_data.B06012PR_020 = row["B06012PR_020"].to_i
					income_data.save!
				# end
				
			end
		end
	end


	desc '(RUN THIS TASK AS THE LAST TASK)create an additional tables and indexes'
	# rake import_data:create_additional_tables_and_indexes
	task :create_additional_tables_and_indexes => :environment do
		    ActiveRecord::Base.connection.execute("CREATE table consumer_compliants_with_geo_data AS
						select 
						cp.id as cp_id,
						cp.date_received, cp.product, cp.sub_product, cp.issue, cp.sub_issue, cp.consumer_compliant_narrative,
						cp.company_public_response, cp.company, cp.state, cp.zip_code, cp.submitted_via, cp.date_sent_to_company,
						cp.company_to_consumer, cp.timely_response, cp.consumer_disputed, cp.complaint_id,
						gdata.id as gdata_id,
						gdata.FILEID,gdata.STUSAB,gdata.SUMLEVEL,gdata.COMPONENT,gdata.LOGRECNO,gdata.US,gdata.REGION,gdata.DIVISION,gdata.STATECE,gdata.STATE,gdata.COUNTY,gdata.COUSUB,gdata.PLACE,gdata.TRACT,gdata.BLKGRP,gdata.CONCIT,gdata.AIANHH,gdata.AIANHHFP,gdata.AIHHTLI,gdata.AITSCE,gdata.AITS,gdata.ANRC,gdata.CBSA,gdata.CSA,gdata.METDIV,gdata.MACC,gdata.MEMI,gdata.NECTA,gdata.NECTADIV,gdata.UA,gdata.BLANK1,gdata.CDCURR,gdata.SLDU,gdata.SLDL,gdata.BLANK2,gdata.BLANK3,gdata.ZCTA5,gdata.SUBMCD,gdata.SDELM,gdata.SDSEC,gdata.SDUNI,gdata.UR,gdata.PCI,gdata.BLANK4,gdata.BLANK5,gdata.PUMA5,gdata.BLANK6,gdata.GEOID,gdata.NAME,gdata.BTTR,gdata.BTBG,gdata.BLANK7 from consumer_compliants as cp
						inner join geography_data as gdata on cp.zip_code = gdata.SUBMCD")

				ActiveRecord::Base.connection.execute("CREATE table income_data_with_geo_data AS
						select * from income_data as income
						inner join geography_data as gdata on income.LOGRECNO = gdata.LOGRECNO
		 				where gdata.SUBMCD is not null")

				ActiveRecord::Base.connection.execute("CREATE INDEX index_zip_code ON consumer_compliants (zip_code)")
				ActiveRecord::Base.connection.execute("CREATE INDEX index_submitted_via ON consumer_compliants (submitted_via)")
				ActiveRecord::Base.connection.execute("CREATE INDEX index_product ON consumer_compliants (product)")
				ActiveRecord::Base.connection.execute("CREATE INDEX index_date_received ON consumer_compliants (date_received)")
				ActiveRecord::Base.connection.execute("CREATE INDEX index_state ON consumer_compliants (state)")
				ActiveRecord::Base.connection.execute("CREATE INDEX index_submcd ON geography_data (SUBMCD)")
				ActiveRecord::Base.connection.execute("CREATE INDEX index_income_geo_submcd ON income_data_with_geo_data (SUBMCD)")
				ActiveRecord::Base.connection.execute("CREATE INDEX index_consumer_geo_zip_code ON consumer_compliants_with_geo_data (zip_code)")
	end
end