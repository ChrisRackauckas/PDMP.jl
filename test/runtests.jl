using PDMP
using Base.Test

# cd(Pkg.dir("PDMP")*"/examples")

println("== start pdmp examples")

println("\n\n==== Example tcp ")
include("../examples/tcp.jl")
pdmp_data(result)
@test isequal(result.time[end],200.)
@test isequal(result.xd[1,end],30)


println("\n\n==== Example tcp fast with types ")
println("----> To make it interesting, this mathematical example can explode in finite time, hence the warning")
include("../examples/tcp_fast.jl")
@test isequal(length(result.time),200)
@test isequal(result.xd[1,end],4)

println("\n\n==== Simple example of neuron model")
include("../examples/pdmp_example_eva.jl")
PDMP.lsoda_ctx(F_eva,R_eva,nu_eva,parms,vec([xc0 0.]),[0.0,0.1])
@test isequal(result.time[end],100.)
@test isequal(result.xd[2,end],93)
#
#
println("\n\n==== Example sir ")
include("../examples/sir.jl")
@test isequal(result.xd[1,end],0)
@test isequal(result.xd[2,end],36)
@test isequal(result.xd[3,end],73)
#
include("../examples/sir-rejection.jl")
@test isequal(result.xd[1,end],0)
@test isequal(result.xd[2,end],73)
@test isequal(result.xd[3,end],36)

println("\n\n==== Example neural network ")
include("../examples/neuron_rejection_exact.jl")

#
# println("\n\n==== Simple example of neuron model, Morris-Leccar")
# include("../examples/morris_lecar.jl")
# @test isequal(result.xd[1,end],25)
# @test isequal(result.xd[2,end],0)
# @test isequal(result.xd[3,end],53)
# @test isequal(result.xd[4,end],9)
