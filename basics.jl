
println(Sys.WORD_SIZE)

println("typeof(1): $(typeof(1))")
println("zero: $(zero(Float64))")
println("zero: $(one(Float64))")

for T in [Int8,Int16,Int32,Int64,Int128,UInt8,UInt16,UInt32,UInt64,UInt128]
    println("$(lpad(T,7)): [$(typemin(T)),$(typemax(T))]")
end

x = [1,2,3] .^ 3
println("vectorized operation using dot notation: $(x))")

# NaN is not equal to, not less than, and not greater than anything, including itself.
println(NaN == NaN)
println([1 NaN] == [1 NaN])
println([1 3] == [1 3])
println(isequal(NaN, NaN))
println(isfinite(8))
println(isinf(Inf))
println(isnan(7))

# can chain comparsions
v(x) = (println(x); x)
v(1) < v(2) <= v(3)

# rational numbers - note that number is reduced to smallest possible terms
x = 6//9
println("rational number: $(x), numerator: $(numerator(x)), denominator: $(denominator(x))")

# strings
println("""Can use triple "quotes" to escape embedded quotes""")
str = "Hello World!"
println("Single index: $(str[1]), $(typeof(str[1]))")  # also note indexing is 1-based
println("Same thing but using range: $(str[1:1]), $(typeof(str[1:1]))")
println("Using 'end' keyword: $(str[end])")

# function declaration - "traditional"
function f(x,y)
    x + y
end
println("1 + 2 = $(f(1, 2))")

# assignment form
g(x, y) = x + y
println("2 + 3 = $(g(2, 3))")

# anonymous function example - can also use more than 1 variable (or 0)
println(map(x -> x^2 + 2x - 1, [1,3,-1]))

# named tuples
x = (a=1, b=1+1)
println(x.a)

# argument destructuring
minmax2(x, y) = (y < x) ? (y, x) : (x, y)
range2((min, max)) = max - min  # note the extra set of parentheses
println("range of (10, 2): $(range2(minmax2(10, 2)))")

# varargs
bar(a,b,x...) = (a,b,x)
println("2 args (no varargs): $(bar(1,2))")
println("6 args: $(bar(1,2,3,4,5,6))")
x = (11, 12)
println("With splatting: $(bar(1, 2, x...))")

# Optional arguments
function Example(y::Int64, x::Int64=0, z::Int64=0)
    y + x + z
end

println(Example(2011, 2))

# Keyword arguments - note the semicolon
function circle(x, y; radius::Int=1)
    return (x=x, y=y, radius=radius)
end
println(circle(2, 3))
println(circle(4, 5; :radius => 6))

function keywords(; kwargs...)
    println(kwargs...)
end
keywords(x="Hello", y="World", z="!")

# do blocks - pass in function as the first argument
y = map([-2, -1, 0, 2]) do x
    if x < 0 && iseven(x)
        return 0
    elseif x == 0
        return 1
    else
        return x
    end
end
println(y)

# vectorizing functions (dot syntax)
f(x,y) = 3x + 4y
A = [1.0, 2.0, 3.0]
B = [4.0, 5.0, 6.0]
println(f.(pi, A))
println(f.(A, B))

Y = [1.0, 2.0, 3.0, 4.0]
X = similar(Y); # pre-allocate output array - more efficient than allocating for results
@. X = sin(cos(Y)) # equivalent to X .= sin.(cos.(Y))
println(X)

# compound expressions - begin blocks, note that they don't have to be multiline
z = begin
   x = 1
   y = 2
   x + y
end
println("compound expression: $(z)")

z = (x = 1; y = 2; x + y)  # using chain syntax - can be multiline
println("using chain syntax: $(z)")

# conditional statements - note that no local scope
function test(x,y)
   if x < y
       relation = "less than"
   elseif x == y
       relation = "equal to"
   else
       relation = "greater than"
   end
   println("x is ", relation, " y.")
end
test(1, 2)
test(2, 1)
test(2, 2)

# ternary operator
x = 1; y = 0
println(x < y ? "less than" : "not less than")

# short circuit evaluation
# you can use non-booleans as the last expression in a conditional chain
function fact(n::Int)
   n >= 0 || error("n must be non-negative")
   n == 0 && return 1
   n * fact(n-1)
end
println(fact(5))
println(fact(0))
#println(fact(-1))

# loops - while and for
i = 1
while i <= 5
   println(i)
   global i += 1
end

for i = 1:5  # 1:5 is a range object
   println(i)
end

for i in [1,4,0]
   println(i)
end

# same as using the keyword in
for s ∈ ["foo","bar","baz"]
   println(s)
end

for i ∈ [1,2,3,4,5,6]
    if iseven(i)
        continue
    elseif i == 5
        break
    end
    println(i)
end

# forms cartesian product of the iterables
for i = 1:2, j = 3:4
   println((i, j))
end

# exception handling
f(x) = x>=0 ? exp(-x) : throw(DomainError(x, "argument must be nonnegative"))
try
    f(-1)
catch e
    if isa(e, DomainError)
        println("you can only provide nonnegative numbers")
    else
        rethrow(e)
    end
finally
    println("we did it team")
end
