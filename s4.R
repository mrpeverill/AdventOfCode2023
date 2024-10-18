# Setup/Import
library('tidyverse')
data<-read.table("input.s4.txt",header=FALSE,sep="")
winners = pmap(unname(data[,3:12]),c)
search = pmap(unname(data[,14:38]),c) 

# Part 1
intersections = mapply(intersect,winners,search)
lengths = sapply(intersections,length)
doublepoints<-\(x) {
    if(x==0) {return(0)}
    else {return(2^(x-1))}
}
points = sapply(lengths,doublepoints)
sum(points)

# Part 2 -- lengths is our starting point.
# Boring, iterative solution
recursiveCards<-\(x) {
    cards = c(1)
    for (i in (length(x)-1):1) {
        #sum the last n card totals, where n is the value of the current lengths (iterating backwards over the lengths vector)
        cards<-append(cards,sum(tail(cards,x[i]))+1)
    }
    cards
}

sum(recursiveCards(lengths))