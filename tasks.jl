#=
Tasks aka
* symmetric coroutines
* lightweight threads
* cooperative multitasking
* one-shot continuations
NOTE: tasks are not scheduled to run on separate CPU cores

Channel is a waitable first-in first-out queue
A special Channel constructor which accepts a 1-arg function as an argument
can be used to run a task bound to a channel.  Channel object is bound to the
task and automatically closes when the Task finishes.
=#
function producer(c::Channel)
    put!(c, "start")
    for n=1:4
        put!(c, 2n)
    end
    put!(c, "stop")
end

chan1 = Channel(producer)
println(take!(chan1))
println(take!(chan1))
println(take!(chan1))
println(take!(chan1))
println(take!(chan1))
println(take!(chan1))

# example using a for loop
for x in Channel(producer)
   println(x)
end

function mytask(myarg)
    println("mytask received $(myarg)")
end

# tasks expect a 0 arg function so can use an anonymous function
taskHdl = Task(() -> mytask(7))
# or, equivalently using a convenience macro
taskHdl = @task mytask(7)
