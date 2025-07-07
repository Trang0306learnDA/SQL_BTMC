--Task 1
SELECT 
    Id,
    ItemCode,
    ItemName,
    ItemGroupId,
    CASE 
        WHEN ItemGroupId = 20 THEN 'GoldExchange'
       ELSE 'GoldJewelry'
    END AS Goldtype
FROM 
    OITM;

--Task 2
SELECT a.Id, b.InvoiceCode,c.DocCode, b.CardId, b.CardName, b.DocDate, b.ObjType,
CASE 
        WHEN b.ObjType = 13 THEN 'Ban hang'
        WHEN b.ObjType = 19 THEN 'Doi tra hang'
        ELSE 'Dat hang'
    END AS ObjTypeName,
b.BranchId, b.Creator, c.CounterId, a.ItemId, c.PaymentType, c.PaymentAmount,
c.PaymentAmount*a.Quantity AS Linetotal,
a.Quantity,
a.WeightGold,
CASE 
        WHEN a.WeightGold <>0 THEN a.Quantity*a.WeightGold
        ELSE a.Quantity
    END AS TotalWeight
FROM DOC1 AS a
JOIN ODOC AS b ON a.FatherId=b.Id
JOIN Payment AS c ON b.ID=c.DocId
WHERE b.ObjType IN (13, 19, 26);

--Task 3
WITH updated_price AS(
SELECT b.Date, b.Time, a.goldCodeName, a.sellPrice, a.BuyPrice,
RANK() OVER(PARTITION BY a.goldCodeName, b.Date ORDER BY b.Time DESC) AS rank
FROM GoldPriceListLine AS a
JOIN GoldPriceList AS b ON a.FatherId=b.Id)

SELECT * FROM updated_price
WHERE rank=1;

