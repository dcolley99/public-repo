USE master
GO
IF NOT EXISTS ( SELECT name FROM sys.server_principals WHERE name = 'DemoUser' ) 
	CREATE LOGIN [DemoUser] WITH PASSWORD = 'LetMeInPlease!'  
GO
IF NOT EXISTS ( SELECT name FROM sys.databases WHERE name = 'CottageIndustries' )	
	CREATE DATABASE CottageIndustries
SET NOCOUNT ON
GO
USE CottageIndustries
GO
IF NOT EXISTS ( SELECT name FROM sys.database_principals WHERE name = 'DemoUser' )
	CREATE USER [DemoUser] FROM LOGIN [DemoUser] 
EXEC sp_addrolemember @rolename = 'db_owner', @membername = 'DemoUser' 
GO
IF EXISTS ( SELECT name FROM sys.foreign_keys WHERE name = 'fk_VisitorID' )
	ALTER TABLE dbo.SaleHeader DROP CONSTRAINT fk_VisitorID 
IF EXISTS ( SELECT name FROM sys.foreign_keys WHERE name = 'fk_SaleID' )
	ALTER TABLE dbo.SaleLineItem DROP CONSTRAINT fk_SaleID 
IF EXISTS ( SELECT name FROM sys.foreign_keys WHERE name = 'fk_ProductID' )
	ALTER TABLE dbo.SaleLineItem DROP CONSTRAINT fk_ProductID 

IF EXISTS ( SELECT name FROM sys.tables WHERE name = 'SaleHeader' ) 
	DROP TABLE dbo.SaleHeader
CREATE TABLE dbo.SaleHeader ( 
	SaleID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
	VisitorID UNIQUEIDENTIFIER, 
	DateTimeOfSale DATETIME ) 
IF EXISTS ( SELECT name FROM sys.tables WHERE name = 'SaleLineItem' ) 
	DROP TABLE dbo.SaleLineItem
CREATE TABLE dbo.SaleLineItem (
	SaleLineItemId INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
	SaleID INT, 
	ProductID INT, 
	Quantity INT, 
	ItemPrice NUMERIC(16,2)) 
IF EXISTS ( SELECT name FROM sys.tables WHERE name = 'Product' ) 
	DROP TABLE dbo.Product 
CREATE TABLE dbo.Product ( 
	ProductID INT NOT NULL, 
	ProductName VARCHAR(100) )
IF EXISTS ( SELECT name FROM sys.tables WHERE name = 'Visitor' ) 
	DROP TABLE dbo.Visitor 
CREATE TABLE dbo.Visitor ( 
	VisitorID UNIQUEIDENTIFIER NOT NULL, 
	DateTimeOfLastVisit DATETIME, 
	ReferrerID UNIQUEIDENTIFIER, 
	IPAddress VARCHAR(15), 
	LocationNearestCity VARCHAR(255), 
	VisitDurationS INT ) 

ALTER TABLE dbo.Product ADD CONSTRAINT pk_ProductID PRIMARY KEY (ProductID) 
ALTER TABLE dbo.Visitor ADD CONSTRAINT pk_VisitorID PRIMARY KEY (VisitorID) 

ALTER TABLE dbo.SaleHeader ADD CONSTRAINT fk_VisitorID FOREIGN KEY (VisitorID) REFERENCES dbo.Visitor (VisitorID)
ALTER TABLE dbo.SaleLineItem ADD CONSTRAINT fk_SaleID FOREIGN KEY (SaleID) REFERENCES dbo.SaleHeader (SaleID) 
ALTER TABLE dbo.SaleLineItem ADD CONSTRAINT fk_ProductID FOREIGN KEY (ProductID) REFERENCES dbo.Product (ProductID)

INSERT INTO dbo.Visitor 
SELECT	TOP 2000
		NEWID() [VisitorID], 
		DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % 2419200, DATEADD(WEEK, -2, GETDATE())) [DateTimeOfLastVisit], 
		NULL [ReferrerID], 
		CAST(ABS(CHECKSUM(NEWID())) % 255 AS VARCHAR(3)) + '.' + 
		CAST(ABS(CHECKSUM(NEWID())) % 255 AS VARCHAR(3)) + '.' + 
		CAST(ABS(CHECKSUM(NEWID())) % 255 AS VARCHAR(3)) + '.' + 
		CAST(ABS(CHECKSUM(NEWID())) % 255 AS VARCHAR(3)) [IPAddress], 
		NULL [LocationNearestCity], 
		ABS(CHECKSUM(NEWID())) % 600 + 5 [VisitDurationS]
FROM	sys.columns c 

DECLARE @referrers TABLE ( rid INT, ReferrerID UNIQUEIDENTIFIER ) 
INSERT INTO @referrers
	SELECT	TOP 10
			ROW_NUMBER() OVER ( ORDER BY ( SELECT NULL ) ) [rid],
			NEWID() [ReferrerID] 
	FROM	sys.objects  
UPDATE	v
SET		v.ReferrerID = r.ReferrerID 
FROM	dbo.Visitor v 
INNER	JOIN @referrers r 
ON		r.rid = CEILING(DATEPART(SECOND, v.DateTimeOfLastVisit) / 6) + 1

;WITH Cities AS ( 
	SELECT	1 [rid], 'London' [City] UNION ALL 
	SELECT  2, 'Stoke-on-Trent' UNION ALL 
	SELECT	3, 'Manchester' UNION ALL 
	SELECT  4, 'Edinburgh' UNION ALL 
	SELECT  5, 'Bristol' UNION ALL 
	SELECT  6, 'Belfast' ) 
UPDATE	v
SET		v.LocationNearestCity = c.City
FROM	dbo.Visitor v 
INNER	JOIN Cities c 
ON		c.rid = CEILING(DATEPART(SECOND, v.DateTimeOfLastVisit) / 10) + 1

DECLARE cur_Sales CURSOR LOCAL FAST_FORWARD FOR 
	SELECT	VisitorID FROM dbo.Visitor
DECLARE @thisV UNIQUEIDENTIFIER 
DECLARE @r INT, @c INT 
OPEN cur_Sales 
FETCH NEXT FROM cur_Sales INTO @thisV 
WHILE @@FETCH_STATUS = 0 
BEGIN
	SET @r = ABS(CHECKSUM(NEWID())) % 10 + 1
	IF @r <= 2
	INSERT INTO dbo.SaleHeader ( VisitorID, DateTimeOfSale )
		SELECT	@thisV, DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % 900 + 1, v.DateTimeOfLastVisit) 
		FROM	dbo.Visitor v
		WHERE	v.VisitorID = @thisV
	SET @r = ABS(CHECKSUM(NEWID())) % 10 + 1
	IF @r <= 6
	BEGIN 
	INSERT INTO dbo.SaleHeader ( VisitorID, DateTimeOfSale )
		SELECT	@thisV, DATEADD(SECOND, (ABS(CHECKSUM(NEWID())) % 12000 + 1) * -1, v.DateTimeOfLastVisit) 
		FROM	dbo.Visitor v
		WHERE	v.VisitorID = @thisV
	END
	IF @r <= 2
	BEGIN 
	INSERT INTO dbo.SaleHeader ( VisitorID, DateTimeOfSale )
		SELECT	@thisV, DATEADD(SECOND, (ABS(CHECKSUM(NEWID())) % 12000 + 1) * -1, v.DateTimeOfLastVisit) 
		FROM	dbo.Visitor v
		WHERE	v.VisitorID = @thisV
	END
	FETCH NEXT FROM cur_Sales INTO @thisV 
END
CLOSE cur_Sales 
DEALLOCATE cur_Sales 

INSERT INTO dbo.Product ( ProductID, ProductName ) 
	SELECT 1, 'Widget' UNION ALL 
	SELECT 2, 'Gizmo' 

DECLARE cur_ForEachSale CURSOR LOCAL FAST_FORWARD FOR 
	SELECT	s.SaleID, s.VisitorID
	FROM	dbo.SaleHeader s 
DECLARE @thisSaleID INT, @thisVID UNIQUEIDENTIFIER 
OPEN cur_ForEachSale 
FETCH NEXT FROM cur_ForEachSale INTO @thisSaleID, @thisV
WHILE @@FETCH_STATUS = 0 
BEGIN
	INSERT INTO dbo.SaleLineItem (SaleID, ProductID, Quantity, ItemPrice)
		SELECT	@thisSaleID,
				ABS(CHECKSUM(NEWID())) % 2 + 1 [ProductID], 
				ABS(CHECKSUM(NEWID())) % 4 + 1 [Quantity], 
				NULL [ItemPrice] 
	IF ( SELECT ABS(CHECKSUM(NEWID())) % 2 ) = 1 
		INSERT INTO dbo.SaleLineItem (SaleID, ProductID, Quantity, ItemPrice)
			SELECT	@thisSaleID,
					ABS(CHECKSUM(NEWID())) % 2 + 1 [ProductID], 
					ABS(CHECKSUM(NEWID())) % 4 + 1 [Quantity], 
					NULL [ItemPrice] 
	FETCH NEXT FROM cur_ForEachSale INTO @thisSaleID, @thisV
END
CLOSE	cur_ForEachSale
DEALLOCATE	cur_ForEachSale

UPDATE	i
SET		i.ItemPrice = ( CASE WHEN i.ProductID = 1 THEN 10.00 ELSE 100.00 END )
FROM	dbo.SaleLineItem i 

-- add bias
DELETE	i
FROM	dbo.SaleLineItem i 
INNER	JOIN (
	SELECT	h.SaleID
	FROM	dbo.SaleHeader h 
	INNER	JOIN dbo.Visitor v ON h.VisitorID = v.VisitorID 
	INNER	JOIN dbo.SaleLineItem i ON h.SaleID = i.SaleID
	WHERE	ReferrerID IN ( SELECT TOP 3 ReferrerID FROM dbo.Visitor ORDER BY NEWID() ) ) x 
ON	i.SaleID = x.SaleID
WHERE	i.ProductID = 2

UPDATE	i
SET		i.Quantity = CEILING(i.Quantity * 1.7) 
FROM	dbo.SaleLineItem i 
INNER	JOIN dbo.SaleHeader h ON i.SaleID = h.SaleID 
INNER	JOIN dbo.Visitor v ON h.VisitorID = v.VisitorID 
WHERE	v.LocationNearestCity = 'Stoke-on-Trent'

DECLARE cur_ForEachSale CURSOR LOCAL FAST_FORWARD FOR 
	SELECT	i.SaleLineItemId, 
			CASE	WHEN v.VisitDurationS BETWEEN 0 AND 250 THEN 0.1 
					WHEN v.VisitDurationS BETWEEN 251 AND 350 THEN 0.2 
					WHEN v.VisitDurationS BETWEEN 351 AND 550 THEN 0.4 
					WHEN v.VisitDurationS BETWEEN 551 AND 700 THEN 0.8 
					ELSE 0.9 
			END [r]
	FROM	dbo.SaleLineItem i 
	INNER	JOIN dbo.SaleHeader h 
	ON		i.SaleID = h.SaleID
	INNER	JOIN dbo.Visitor v 
	ON		h.VisitorID = v.VisitorID 
DECLARE @thisSLID INT, @thisR FLOAT 
DECLARE @dice FLOAT
OPEN cur_ForEachSale 
FETCH NEXT FROM cur_ForEachSale INTO @thisSLID, @thisR 
WHILE @@FETCH_STATUS = 0 
BEGIN
	SET @dice = (ABS(CHECKSUM(NEWID())) % 10 + 1) / 10.0
	IF @dice > @thisR 
		DELETE	i
		FROM	dbo.SaleLineItem i 
		WHERE	i.SaleLineItemId = @thisSLID
	FETCH NEXT FROM cur_ForEachSale INTO @thisSLID, @thisR
END
CLOSE	cur_ForEachSale
DEALLOCATE	cur_ForEachSale 

DELETE	h 
FROM	dbo.SaleHeader h 
LEFT	JOIN dbo.SaleLineItem i ON h.SaleID = i.SaleID 
WHERE	i.SaleID IS NULL 

USE [master]
GO
ALTER LOGIN [DemoUser] WITH DEFAULT_DATABASE=[CottageIndustries]
GO

-- prep for R analysis
--SELECT	v.IPAddress, v.LocationNearestCity, v.ReferrerID, v.VisitDurationS, 
--		ISNULL(p.ProductName, 'No sale') [Product], ISNULL(i.Quantity, 0) [QuantityBought]
--FROM	dbo.Visitor v 
--LEFT	JOIN dbo.SaleHeader h ON v.VisitorID = h.VisitorID 
--LEFT	JOIN dbo.SaleLineItem i ON h.SaleID = i.SaleID
--LEFT	JOIN dbo.Product p ON i.ProductID = p.ProductID

--SELECT	r.IPAddress, r.LocationNearestCity, r.ReferrerID, r.VisitDurationS, 
--		ISNULL(r.ProductName, 'No sale') [Product], ISNULL(r.Quantity, 0) [QuantityBought]
--FROM	#results r 

--DECLARE @resultsForR TABLE ( 
--	IPAddress VARCHAR(15), LocationNearestCity VARCHAR(255), 
--	ReferrerID UNIQUEIDENTIFIER, VisitDurationS INT, MostPopularProduct VARCHAR(255) ) 
--DECLARE cur_ForEachVisitor CURSOR LOCAL FAST_FORWARD FOR 
--	SELECT	r.IPAddress, r.LocationNearestCity, r.ReferrerID, r.VisitDurationS
--	FROM	#results r 
--DECLARE @thisIP VARCHAR(15), @thisLoc VARCHAR(255), @thisRef UNIQUEIDENTIFIER, @thisVisit INT 
--OPEN	cur_ForEachVisitor 
--FETCH NEXT FROM cur_ForEachVisitor INTO @thisIP, @thisLoc, @thisRef, @thisVisit 
--WHILE @@FETCH_STATUS = 0
--BEGIN
--	INSERT INTO @resultsForR
--	SELECT	@thisIP, @thisLoc, @thisRef, @thisVisit, 
--			(	SELECT TOP 1 Product 
--				FROM	(
--						SELECT	r.IPAddress, r.LocationNearestCity, r.ReferrerID, r.VisitDurationS, 
--						ISNULL(r.ProductName, 'No sale') [Product], ISNULL(r.Quantity, 0) [QuantityBought] 
--						FROM #results r ) r
--				WHERE	r.IPAddress = @thisIP 
--				AND		r.LocationNearestCity = @thisLoc 
--				AND		r.ReferrerID = @thisRef 
--				AND		r.VisitDurationS = @thisVisit
--				ORDER	BY r.QuantityBought DESC ) [MostPopularProduct]
--	FETCH NEXT FROM cur_ForEachVisitor INTO @thisIP, @thisLoc, @thisRef, @thisVisit 
--END
--CLOSE	cur_ForEachVisitor 
--DEALLOCATE	cur_ForEachVisitor

--SELECT	*
--FROM	@resultsForR


