# let statements allocate new variable bindings each time they run
# this is also an example of how to do closures
let state = 0
   global counter() = (state += 1)
end

println(counter())
println(counter())

# struct (composite type) example
struct Foo
     bar
     baz
 end

foo = Foo(1, 2)
println("bar: $(foo.bar), baz: $(foo.baz)")

# example of defining a new outer constructor method that only take 1 arg
Foo(x) = Foo(x, x)
foo = Foo(3)
println("bar: $(foo.bar), baz: $(foo.baz)")

# example of inner constructor method
struct OrderedPair
     x::Real
     y::Real
     OrderedPair(x,y) = x > y ? error("out of order") : new(x,y)
end

op1 = OrderedPair(1, 2)
println("(x, y) = ($(op1.x), $(op1.y))")

try
   op2 = OrderedPair(2, 1)
catch e
   println(e)
end

# conversion example
x = 2
println("typeof(x) = $(typeof(x))")
x = convert(Float64, x)
println("typeof(x) = $(typeof(x))")

# promotion - converting multiple different types to a common type
x = promote(1, 2.5, 3, 3//4)
println("promotion: $(x)")
x = promote(1 + 2im, 3//4)
println("promotion: $(x)")

# iteration - defined by iterate method
struct Squares
    count::Int
end
Base.iterate(S::Squares, state=1) = state > S.count ? nothing : (state*state, state+1)

for i in Squares(7)
    println(i)
end

println("is 25 a square number? $(25 in Squares(10))")

using Statistics
println("mean of the squares up to 100^2: $(mean(Squares(100)))")
