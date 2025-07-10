--Task 1
SELECT 
    Id,
    ItemCode,
    ItemName,
    ItemGroupId,
    CASE 
        WHEN ItemGroupId = 20 THEN 'Vang Trao doi'
       ELSE 'Vang Trang suc'
    END AS Goldtype
FROM 
    OITM;

--Task 2
SELECT a.Id, b.InvoiceCode,c.DocCode, b.CardId, b.CardName, b.DocDate, 
        CONVERT(DATE, b.DocDate) AS Date,
        b.ObjType,
CASE 
        WHEN b.ObjType = 13 THEN 'Ban hang'
        WHEN b.ObjType = 19 THEN 'Doi tra hang'
        ELSE 'Dat hang'
    END AS ObjTypeName,
b.BranchId, b.Creator, c.CounterId, a.ItemId, c.PaymentType, c.PaymentAmount,
a.LineTotal,
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
SELECT 
    DATEADD(HOUR, 7, sub.Date) AS updated_Date,
    DATEADD(HOUR, 7, sub.Time) AS updated_Time,
    sub.goldCodeName, 
    sub.sellPrice, 
    sub.BuyPrice 
FROM (
    SELECT 
        b.Date, 
        b.Time, 
        a.goldCodeName, 
        a.sellPrice, 
        a.BuyPrice,
        ROW_NUMBER() OVER (
            PARTITION BY a.goldCodeName, YEAR(b.Time), MONTH(b.Time), DAY(b.Time)
            ORDER BY b.Time DESC
        ) AS rank
    FROM GoldPriceListLine AS a
    JOIN GoldPriceList AS b ON a.FatherId = b.Id
) AS sub
WHERE sub.rank = 1;

