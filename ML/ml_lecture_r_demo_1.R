# Pre-requisite: Install the following packages using the Packages menu in R.

# ODBC (provides database connectivity)
# nnet (neural network functions)
# arules (associative rule functions)
# e1071 (mixed ML functions)
# plotly (graphing)

library(odbc)
library(plotly)

# Set up the connection to the CottageIndustries database
connString = 	"Driver={Sql Server Native Client 11.0};
			Server=localhost;
			Initial Catalog=CottageIndustries;
			UID=DemoUser;
			PWD=LetMeInPlease!"

conn <- odbcDriverConnect(connString)

# Let's create a query to fetch the data we're interested in.
# We will fetch, for each sale, the duration of the associated website visit.
# Is there a correlation between the duration and the probability of a sale?

query = "SELECT v.IPAddress, v.LocationNearestCity, v.ReferrerID, v.VisitDurationS, 
		ISNULL(p.ProductName, 'No sale') [Product], ISNULL(i.Quantity, 0) [QuantityBought]
FROM dbo.Visitor v 
LEFT JOIN dbo.SaleHeader h ON v.VisitorID = h.VisitorID 
LEFT JOIN dbo.SaleLineItem i ON h.SaleID = i.SaleID
LEFT JOIN dbo.Product p ON i.ProductID = p.ProductID"

importedData <- sqlQuery(conn, query)

# see a summary of the data
summary(importedData)

# list the data itself
importedData

# now we try to answer the question, given visit duration, how likely is it that
# a sale will result?

# we need two items here - the duration, and the fact (or otherwise) of a sale.

# we need to reduce our dataset, and also codify one of the columns.
# this is because (generally) ML is designed for ordinal data, not nominal data.

# first, slice the two interesting columns out of our data
dataSlice <- importedData[c("VisitDurationS","Product")]
dataSlice

# next, we need to create a code that means 'sale or no sale'
# at this point we are not interested in WHAT was bought, just the fact of it.
# so let's replace every value in col 2 (Product) with 0 if 'no sale', 1 otherwise.
# so 1 indicates an item was sold and 0 indicates there was no sale.
# this is called codification.

dataSlice$Product <- as.character(dataSlice$Product)
dataSlice$Product[dataSlice$Product != "No sale"] <- "1" 
dataSlice$Product[dataSlice$Product != "1"] <- "0"
dataSlice$Product <- as.numeric(dataSlice$Product)
dataSlice

# now, this dataset includes one row for every sale item (not sale)
# this is a problem since a sale with > 1 item will be counted more than once
# and this could skew the result.
# we can safely group the data by VisitDurationS since there (should) be no 
# case where someone bought a sale item and 'No sale' in the same visit.

aggregate(Product ~ VisitDurationS, dataSlice, max)

# let's first take a quick look at the data and see if we can spot any trends
plot <- ggplot(data=dataSlice, aes(x=Product)) + geom_bar()

# OK, we can see there are about 800 sales vs. 480 no-sales, 
# or about 62.5% conversion.

noSales <- subset(dataSlice, Product == 0)
sales <- subset(dataSlice, Product == 1)
summary(noSales)
summary(sales)

# mean visit duration for visitors who bought something = 362 seconds
# mean visit duration for visitors who did not buy anything = 264 seconds
# this indicates there could be a significant difference 
# and a phenomena worth investigating.

# We can check the correlation using the function 'cor'.
cor(dataSlice$VisitDurationS, dataSlice$Product)

# This results in a low value - but not too low.  Typically, correlation below
# 0.2 (on a scale of 0-1) indicates no relationship, but there is a weak 
# indicator of a relationship here.

# now let's try and build a linear regression model.

model <- lm(Product ~ VisitDurationS, dataSlice)
model

# this provides two co-efficients which plug into the formula:
# Product = 0.3694143 + (0.0007716 * VisitDurationS)

# don't forget Product is really the fact or not of a sale, so let's 
# re-label it as 'FactOfSale'

# Let's take a look at the statistics.
summary(model)

# The p-values determine how statistically significant the model is, and 
# particularly how significant the input variables (VisitDuration, in this case) are.
# We have minute p-values so we can be confident that statistical significance exists.

# Let's graph it out using plot_ly, an alternative to ggplot.

# we create an object to hold our linear regression function
lrf = function(VisitDurationS){(0.3694143 + (0.0007716 * VisitDurationS)}

# and we can use this to populate a data frame showing likelihood of sales vs. duration

final <- data.frame(VisitDurationS = integer(0), LikelihoodOfSale = numeric(0))
for (d in 1:800) {
	p = lrf(d)
	if (p < 0) { p = 0 }
	if (p > 1) { p = 1 }
	result <- data.frame(VisitDurationS = d, LikelihoodOfSale = p)
	final <- rbind(final, result)
}
final

# and finally, plot it out.
plot <- plot_ly(final, x=~VisitDurationS, y=~LikelihoodOfSale, type="scatter", mode="lines")





