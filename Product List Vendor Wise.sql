select
	ProductVariant.Id AS ProductVariantId,
	Case 
		when ProductVariant.ShelfType in (5,9) 
		OR ProductVariant.[Name] like '%Bengal Meat%' 
		OR ProductVariant.[Name] like '%Bengal Fish%'
		OR ProductVariant.Id IN (15302,15303,15304,21333,26241)
			then 'Team D' 

		when TeamC.ProductVariantId is not null
			then 'Team C' 

		when TeamA.ProductVariantId is not null
			then 'Team A' 

		when TeamB.ProductVariantId is not null
			then 'Team B' 
			
		else 'Others' 
	end AS TeamName


From
	ProductVariant

	-- Team A
	LEFT JOIN (
		select
			ProductVariant.Id ProductVariantId
		from ProductVariant
		Where
			 ProductVariant.ShelfType not in (5,9)
			AND (ProductVariant.Id in (select pvvm.ProductVariantId from ProductVariantVendorMapping pvvm where pvvm.VendorId in (4,10,11,23,24,29,31,36,38,39,40,44,48,52,71,72,75,80,92,131,138,155,165,173,180,186,187,198,202,216,217,220,232,235,238,246,253,259,279,285,324,344,355,356,367,392,395,397,406,407,433,446,457,463,470,476,486,493,524,531,534,541,551,558,562,576,577,578,580,584,598,599,600,606,613,615,621,622,636,640,644,645,652,659,663,664,668,692,693,708,717,722,729,732,758,759,765,767,794,797,806,809,811,812,822,824,831,833,847,848,862,868,871,881,893,903,911,916,921,937,944,952,957,964,967,972,973,979,980,981,982,983,989,992,1010,1011,1012,1013,1014,1015,1016,1017,1020,1021,1022,1023,1026,1028,1029,1030,1031,1032,1033,1034,1035,1036,1040,1041,1042,1043,1044,1046,1048,1049,1056,1060,1062,1064,1065,1066,1069,1071,1073,1074,1075,1076,1077,1080,1096,1097,1104,1148,973,1154))
				or
				ProductVariant.Id in (
					Select
						LastPo.ProductVariantId
					From
						PurchaseOrder
						Join (SELECT
									Max(PurchaseOrderProductVariant.PurchaseOrderId) PurchaseOrderId,
									PurchaseOrderProductVariant.ProductVariantId
								FROM
									PurchaseOrderProductVariant
									Join PurchaseOrder on PurchaseOrder.Id = PurchaseOrderProductVariant.PurchaseOrderId
								Where
									PurchaseOrder.CompletedOn is not null
									and PurchaseOrder.VendorId not in (103,468,362)
									and PurchaseOrderProductVariant.ProductVariantId in (select pvvm.ProductVariantId from ProductVariantVendorMapping pvvm where pvvm.VendorId in (362))
								Group by
									PurchaseOrderProductVariant.ProductVariantId
							) LastPo on LastPo.PurchaseOrderId = PurchaseOrder.Id
					Where 
						PurchaseOrder.VendorId in (4,10,11,23,24,29,31,36,38,39,40,44,48,52,71,72,75,80,92,131,138,155,165,173,180,186,187,198,202,216,217,220,232,235,238,246,253,259,279,285,324,344,355,356,367,392,395,397,406,407,433,446,457,463,470,476,486,493,524,531,534,541,551,558,562,576,577,578,580,584,598,599,600,606,613,615,621,622,636,640,644,645,652,659,663,664,668,692,693,708,717,722,729,732,758,759,765,767,794,797,806,809,811,812,822,824,831,833,847,848,862,868,871,881,893,903,911,916,921,937,944,952,957,964,967,972,973,979,980,981,982,983,989,992,1010,1011,1012,1013,1014,1015,1016,1017,1020,1021,1022,1023,1026,1028,1029,1030,1031,1032,1033,1034,1035,1036,1040,1041,1042,1043,1044,1046,1048,1049,1056,1060,1062,1064,1065,1066,1069,1071,1073,1074,1075,1076,1077,1080,1096,1097,1104,1148,973,1154)
					Group by
						LastPo.ProductVariantId
				))
	) TeamA on ProductVariant.Id = TeamA.ProductVariantId


	-- Team B
	LEFT JOIN (
		select
			ProductVariant.Id ProductVariantId
		from ProductVariant
		Where   
			ProductVariant.ShelfType not in (5,9)
			AND (
				ProductVariant.Id in (select pvvm.ProductVariantId from ProductVariantVendorMapping pvvm where pvvm.VendorId in (5,7,8,13,14,18,19,22,28,35,37,54,55,58,60,62,63,67,68,77,83,88,96,105,141,163,178,183,196,205,211,234,249,260,284,287,295,322,340,345,346,370,380,389,393,394,403,409,411,420,422,445,448,481,484,487,489,491,492,522,527,546,550,552,559,564,571,575,579,583,587,589,590,604,608,611,653,654,658,677,678,679,683,687,691,699,718,731,749,761,764,787,788,789,793,805,807,808,823,826,836,838,840,841,857,865,866,870,873,874,875,882,883,888,892,894,899,904,905,906,907,912,913,914,915,917,918,920,922,923,924,942,943,953,954,958,960,961,962,965,968,970,971,975,976,977,978,984,985,986,987,988,991,993,994,1019,1024,1025,1037,1038,1039,1045,1047,1050,1051,1052,1053,1054,1058,1063,1067,1068,1072,1081,1099,1100,1101,1103,1105,1106,1110,1112,1113,1137,1138))
				or
				ProductVariant.Id in (
					Select
						LastPo.ProductVariantId
					From
						PurchaseOrder
						Join (SELECT
									Max(PurchaseOrderProductVariant.PurchaseOrderId) PurchaseOrderId,
									PurchaseOrderProductVariant.ProductVariantId
								FROM
									PurchaseOrderProductVariant
									Join PurchaseOrder on PurchaseOrder.Id = PurchaseOrderProductVariant.PurchaseOrderId
								Where
									PurchaseOrder.CompletedOn is not null
									and PurchaseOrder.VendorId not in (103,468,362)
									and PurchaseOrderProductVariant.ProductVariantId in (select pvvm.ProductVariantId from ProductVariantVendorMapping pvvm where pvvm.VendorId in (362))
								Group by
									PurchaseOrderProductVariant.ProductVariantId
							) LastPo on LastPo.PurchaseOrderId = PurchaseOrder.Id
					Where 
						PurchaseOrder.VendorId in (5,7,8,13,14,18,19,22,28,35,37,54,55,58,60,62,63,67,68,77,83,88,96,105,141,163,178,183,196,205,211,234,249,260,284,287,295,322,340,345,346,370,380,389,393,394,403,409,411,420,422,445,448,481,484,487,489,491,492,522,527,546,550,552,559,564,571,575,579,583,587,589,590,604,608,611,653,654,658,677,678,679,683,687,691,699,718,731,749,761,764,787,788,789,793,805,807,808,823,826,836,838,840,841,857,865,866,870,873,874,875,882,883,888,892,894,899,904,905,906,907,912,913,914,915,917,918,920,922,923,924,942,943,953,954,958,960,961,962,965,968,970,971,975,976,977,978,984,985,986,987,988,991,993,994,1019,1024,1025,1037,1038,1039,1045,1047,1050,1051,1052,1053,1054,1058,1063,1067,1068,1072,1081,1099,1100,1101,1103,1105,1106,1110,1112,1113,1137,1138)
					Group by
						LastPo.ProductVariantId
				))
	) TeamB on ProductVariant.Id = TeamB.ProductVariantId 


	-- Team C
	LEFT JOIN (
		select
			ProductVariant.Id ProductVariantId
		from ProductVariant
		Where  
			ProductVariant.ShelfType not in (5,9)
			AND (
				ProductVariant.Id in (select pvvm.ProductVariantId from ProductVariantVendorMapping pvvm where pvvm.VendorId in (119,182,188,209,221,363,405,437,494,496,537,563,566,586,593,633,660,661,724,795,796,800,820,845,849,908,925,926,931,935,936,938,939,941,946,947,948,966,969,990,1055,1059,1061,1070,1078,1098,1107,1115))
				or
				ProductVariant.Id in (
					Select
						LastPo.ProductVariantId
					From
						PurchaseOrder
						Join (SELECT
									Max(PurchaseOrderProductVariant.PurchaseOrderId) PurchaseOrderId,
									PurchaseOrderProductVariant.ProductVariantId
								FROM
									PurchaseOrderProductVariant
									Join PurchaseOrder on PurchaseOrder.Id = PurchaseOrderProductVariant.PurchaseOrderId
								Where
									PurchaseOrder.CompletedOn is not null
									and PurchaseOrder.VendorId not in (103,468,362)
									and PurchaseOrderProductVariant.ProductVariantId in (select pvvm.ProductVariantId from ProductVariantVendorMapping pvvm where pvvm.VendorId in (362))
								Group by
									PurchaseOrderProductVariant.ProductVariantId
							) LastPo on LastPo.PurchaseOrderId = PurchaseOrder.Id
					Where 
						PurchaseOrder.VendorId in (119,182,188,209,221,363,405,437,494,496,537,563,566,586,593,633,660,661,724,795,796,800,820,845,849,908,925,926,931,935,936,938,939,941,946,947,948,966,969,990,1055,1059,1061,1070,1078,1098,1107,1115)
					Group by
						LastPo.ProductVariantId
				))
	) TeamC on ProductVariant.Id = TeamC.ProductVariantId 

Where
	ProductVariant.Deleted = 0
	AND ProductVariant.Name Not like '%Gift From Chaldal%'