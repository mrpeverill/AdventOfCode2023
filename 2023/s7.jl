using CSV
using DataFrames
using StatsBase

#Input
df = DataFrame(CSV.File(ARGS[1],header=false))
rename!(df,[:handString,:bid])

#Parse Hands
faces = Dict("A" => 14,"K" => 13, "Q" => 12, "J"=>11, "T"=>10)
parseHand(x) = [get(faces,y,tryparse(Int,y)) for y in split(x,"")]
df.Hands = parseHand.(df.handString)

#Solution 1
df.counts = sort.(counts.(df.Hands),rev=true)
df.pair1 = first.(df.counts)
second(x) = length(x) == 1 ? 0 : getindex(x,2)
df.pair2 = second.(df.counts)
println(string("Part 1 Solution: ", sum(sort(df, [:pair1, :pair2, :Hands]).bid .* (1:nrow(df)))))

#Solution 2
parseHand2(x) = [get(Dict(11 => 1),y,y) for y in x]
df.Hands2 = parseHand2.(df.Hands)
df.jokers = map(v -> sum(v .==1), df.Hands2)
filteredCount(x) = x == [1,1,1,1,1] ? [0] : counts(filter(a -> a ≠ 1, x))
df.counts2 = sort.(filteredCount.(df.Hands2),rev=true)
df.fpair1 = first.(df.counts2)+df.jokers
df.fpair2 = second.(df.counts2)
println(string("Part 2 Solution: ", sum(sort(df, [:fpair1, :fpair2, :Hands2]).bid .* (1:nrow(df)))))
