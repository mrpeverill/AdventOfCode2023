library('tidyverse')
data<-read.table("input.s4.txt",header=FALSE,sep="")
winners = pmap(unname(data[,3:12]),c)
search = pmap(unname(data[,14:38]),c) 
intersections = mapply(intersect,winners,search)
lengths = sapply(intersections,length)
doublepoints<-\(x) {
    if(x==0) {return(0)}
    else {return(2^(x-1))}
}
points = sapply(lengths,doublepoints)
sum(points)
