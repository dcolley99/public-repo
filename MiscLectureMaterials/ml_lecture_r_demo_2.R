# install.packages('neuralnet')

library(odbc)
library(rodbc)
library(plotly)
library(neuralnet)

connString = 	"Driver={Sql Server Native Client 11.0};
			Server=localhost;
			Initial Catalog=CottageIndustries;
			UID=DemoUser;
			PWD=LetMeInPlease!"

conn <- odbcDriverConnect(connString)

query = "
SELECT CASE v.LocationNearestCity WHEN 'Belfast' THEN 1 ELSE 0 END [IsBelfast], 
	 CASE v.LocationNearestCity WHEN 'Edinburgh' THEN 1 ELSE 0 END [IsEdinburgh], 
	 CASE v.LocationNearestCity WHEN 'London' THEN 1 ELSE 0 END [IsLondon], 
	 CASE v.LocationNearestCity WHEN 'Stoke-on-Trent' THEN 1 ELSE 0 END [IsStokeOnTrent], 
	 CASE v.LocationNearestCity WHEN 'Manchester' THEN 1 ELSE 0 END [IsManchester], 
	 CASE v.LocationNearestCity WHEN 'Bristol' THEN 1 ELSE 0 END [IsBristol],
	 v.VisitDurationS,
	 ISNULL(i.ItemPrice * i.Quantity, 0) [TotalSaleValue]
FROM CottageIndustries.dbo.Visitor v 
LEFT JOIN CottageIndustries.dbo.SaleHeader h ON v.VisitorID = h.VisitorID 
LEFT JOIN CottageIndustries.dbo.SaleLineItem i ON h.SaleID = i.SaleID"

importedData <- sqlQuery(conn, query)
head(importedData)
dataSlice <- importedData

cor(dataSlice$VisitDurationS, dataSlice$TotalSaleValue)
cor(dataSlice$IsBelfast, dataSlice$TotalSaleValue)
cor(dataSlice$IsEdinburgh, dataSlice$TotalSaleValue)
cor(dataSlice$IsLondon, dataSlice$TotalSaleValue)
cor(dataSlice$IsStokeOnTrent, dataSlice$TotalSaleValue)
cor(dataSlice$IsManchester, dataSlice$TotalSaleValue)
cor(dataSlice$IsBristol, dataSlice$TotalSaleValue)

# Compare against using uncorrelated variables e.g. Belfast, Edinburgh
nn <- neuralnet(dataSlice$TotalSaleValue ~ dataSlice$IsBelfast + 
dataSlice$IsEdinburgh, data=dataSlice, hidden=4, 
err.fct="sse", linear.output=TRUE, rep=1)
plot(nn)

indVars <- subset(dataSlice, select = c("IsBelfast", "IsEdinburgh"))
head(indVars)
nn.results <- compute(nn, indVars)
results <- data.frame(actual=dataSlice$TotalSaleValue, prediction=nn.results$net.result)
results

plot <- plot_ly(results, x=c(1:1105)) %>% 
add_trace(y=~actual, mode='lines') %>%
add_trace(y=~prediction, mode='lines') 
plot

# Now against London and Stoke, correlated variables
nn <- neuralnet(dataSlice$TotalSaleValue ~ dataSlice$IsLondon + 
dataSlice$IsStokeOnTrent, data=dataSlice, hidden=3, 
err.fct="sse", linear.output=TRUE, rep=1)
plot(nn)

indVars <- subset(dataSlice, select = c("IsLondon", "IsStokeOnTrent"))
head(indVars)
nn.results <- compute(nn, indVars)
results <- data.frame(actual=dataSlice$TotalSaleValue, prediction=nn.results$net.result)
results

plot <- plot_ly(results, x=c(1:1105)) %>% 
add_trace(y=~actual, mode='lines') %>%
add_trace(y=~prediction, mode='lines') 
plot






