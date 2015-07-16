class CreateGeographyData < ActiveRecord::Migration
  def change
    create_table :geography_data do |t|
    	# (0..53).each do |col|
    	# 	t.string "col_#{col}"
    	# end
    	# cols = ["FILEID","STUSAB","SUMLEVEL","COMPONENT","LOGRECNO","US","REGION","DIVISION","STATECE","STATE","COUNTY","COUSUB","PLACE","TRACT","BLKGRP","CONCIT","AIANHH","AIANHHFP","AIHHTLI","AITSCE","AITS","ANRC","CBSA","CSA","METDIV","MACC","MEMI","NECTA","NECTADIV","UA","BLANK1","CDCURR","SLDU","SLDL","BLANK2","BLANK3","ZCTA5","SUBMCD","SDELM","SDSEC","SDUNI","UR","PCI","BLANK4","BLANK5","PUMA5","BLANK6","GEOID","NAME","BTTR","BTBG","BLANK7"]
    	# cols.each do |col|

    	# end
    	t.string :FILEID
			t.string :STUSAB
			t.string :SUMLEVEL
			t.string :COMPONENT
			t.string :LOGRECNO
			t.string :US
			t.string :REGION
			t.string :DIVISION
			t.string :STATECE
			t.string :STATE
			t.string :COUNTY
			t.string :COUSUB
			t.string :PLACE
			t.string :TRACT
			t.string :BLKGRP
			t.string :CONCIT
			t.string :AIANHH
			t.string :AIANHHFP
			t.string :AIHHTLI
			t.string :AITSCE
			t.string :AITS
			t.string :ANRC
			t.string :CBSA
			t.string :CSA
			t.string :METDIV
			t.string :MACC
			t.string :MEMI
			t.string :NECTA
			t.string :NECTADIV
			t.string :UA
			t.string :BLANK1
			t.string :CDCURR
			t.string :SLDU
			t.string :SLDL
			t.string :BLANK2
			t.string :BLANK3
			t.string :ZCTA5
			t.string :SUBMCD
			t.string :SDELM
			t.string :SDSEC
			t.string :SDUNI
			t.string :UR
			t.string :PCI
			t.string :BLANK4
			t.string :BLANK5
			t.string :PUMA5
			t.string :BLANK6
			t.string :GEOID
			t.string :NAME
			t.string :BTTR
			t.string :BTBG
			t.string :BLANK7
      t.timestamps
    end
  end
end