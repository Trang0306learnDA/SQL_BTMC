--TASK 1
SELECT 
    Id,
    ItemCode,
    ItemName,
    ItemGroupId,
    CASE 
        WHEN ItemGroupId = 20 THEN 'Vang Trao Đoi'
       ELSE 'Vang Trang Suc'
    END AS PhanLoai
FROM 
    OITM;

--TASK 2
SELECT a.Id, b.InvoiceCode,c.DocCode, b.CardId, b.CardName, b.DocDate, b.ObjType,
CASE 
        WHEN b.ObjType = 13 THEN 'Ban hang'
        WHEN b.ObjType = 19 THEN 'Doi tra hàng'
        ELSE 'Dat hang'
    END AS ObjTypeName,
b.BranchId, b.Creator, c.CounterId, a.ItemId, c.PaymentType, c.PaymentAmount, a.Quantity, a.WeightGold
FROM DOC1 AS a
JOIN ODOC AS b ON a.FatherId=b.Id
JOIN Payment AS c ON b.ID=c.DocId;
