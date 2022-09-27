select ProductVariant.Id AS ProductVariantId,
	   Case when ProductVariant.ShelfType in (5,9) OR ProductVariant.[Name] like '%Bengal Meat%' OR ProductVariant.[Name] like '%Bengal Fish%' OR ProductVariant.Id IN (15302,15303,15304,21333,26241)
			then 'Team A' else 'Others' 
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

Where
	ProductVariant.Deleted = 0
	AND ProductVariant.Name Not like '%Gift From Chaldal%'