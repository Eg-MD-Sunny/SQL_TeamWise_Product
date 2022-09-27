select ProductVariant.Id AS ProductVariantId,
	   Case when ProductVariant.ShelfType in (5,9) OR ProductVariant.[Name] like '%Bengal Meat%' OR ProductVariant.[Name] like '%Bengal Fish%' OR ProductVariant.Id IN (15302,15303,15304,21333,26241)
			then 'Team C' else 'Others' 
	   end AS TeamName


From
	ProductVariant

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