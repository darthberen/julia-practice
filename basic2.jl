# let statements allocate new variable bindings each time they run
# this is also an example of how to do closures
let state = 0
   global counter() = (state += 1)
end

println(counter())
println(counter())
