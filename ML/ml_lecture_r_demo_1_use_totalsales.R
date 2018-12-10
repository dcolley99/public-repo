library(odbc)
library(plotly)

connString = 	"Driver={Sql Server Native Client 11.0};
			Server=localhost;
			Initial Catalog=CottageIndustries;
			UID=DemoUser;
			PWD=LetMeInPlease!"

conn <- odbcDriverConnect(connString)

query = "SELECT v.IPAddress, v.LocationNearestCity, v.ReferrerID, v.VisitDurationS, 
	CASE WHEN p.ProductName = 'Widget' THEN 10 WHEN p.ProductName = 'Gizmo' THEN 100 ELSE 0 END * 
	ISNULL(i.Quantity,0) [AmountSpent]
FROM dbo.Visitor v 
LEFT JOIN dbo.SaleHeader h ON v.VisitorID = h.VisitorID 
LEFT JOIN dbo.SaleLineItem i ON h.SaleID = i.SaleID
LEFT JOIN dbo.Product p ON i.ProductID = p.ProductID"

importedData <- sqlQuery(conn, query)
summary(importedData)
importedData

dataSlice <- importedData[c("VisitDurationS","AmountSpent")]
dataSlice

dataSlice$AmountSpent <- as.numeric(dataSlice$AmountSpent)
dataSlice

aggregate(AmountSpent ~ VisitDurationS, dataSlice, sum)

noSales <- subset(dataSlice, Product == 0)
sales <- subset(dataSlice, Product > 0)
summary(noSales)
summary(sales)

cor(dataSlice$VisitDurationS, dataSlice$AmountSpent)

plot <- plot_ly(dataSlice, x=~VisitDurationS, y=~AmountSpent, type="scatter", mode="markers")
plot <- plot %>% add_lines(y = ~fitted(loess(AmountSpent ~ VisitDurationS)),
            line = list(color = '#07A4B5')

model <- lm(AmountSpent ~ VisitDurationS, dataSlice)
model

summary(model)

plot(dataSlice$VisitDurationS, dataSlice$AmountSpent)
abline(-6.4091, 0.1484)



