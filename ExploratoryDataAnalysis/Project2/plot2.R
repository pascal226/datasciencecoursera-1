# Must be run from directory containing data files
# specified below

# Read the data
nei.file <- "summarySCC_PM25.rds"
if (!file.exists(nei.file)) stop("Can't find NEI file")
NEI <- readRDS(nei.file)

# Subset to baltimore
NEI <- subset(NEI, fips=="24510")

# Find the totals per year
library(plyr, quiet=TRUE)
year.totals = ddply(NEI, ~year, summarize, total=sum(Emissions))

# Plot the emissions vs year as a barplot
png(filename="plot2.png")
barplot(year.totals$total, names=year.totals$year,
        main=expression(paste("Total ",PM[2.5]," emission in Baltimore")),
        sub="all sources",
        ylab="Emission [tons]", xlab="Year")
dev.off()

