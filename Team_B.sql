select ProductVariant.Id AS ProductVariantId,
	   Case when ProductVariant.ShelfType in (5,9) OR ProductVariant.[Name] like '%Bengal Meat%' OR ProductVariant.[Name] like '%Bengal Fish%' OR ProductVariant.Id IN (15302,15303,15304,21333,26241)
			then 'Team B' else 'Others' 
	   end AS TeamName


From
	ProductVariant

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

	Where
	ProductVariant.Deleted = 0
	AND ProductVariant.Name Not like '%Gift From Chaldal%'