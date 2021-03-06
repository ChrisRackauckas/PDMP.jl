"""
  A type storing the status at the end of a call.
"""
type pdmpStats
  termination_status::String
  nsteps::Int64
end

"""
  A type storing the call.
"""
type pdmpArgs
	xc::Vector{Float64} # continuous variable
	xd::Vector{Int64}# discrete variable
	F::Any
	R::Any
	Delta::Any
	nu::Matrix{Int64}
	parms::Vector{Any}
	tf::Float64
end

"""
  This type stores the output, and comprises of:

      - **time** : a `Vector` of `Float64`, containing the times of simulated events.
      - **xc** : a `Matrix` of `Float64`, containing the simulated states for the continuous variable.
      - **xd** : a `Matrix` of `Int	64`, containing the simulated states for the continuous variable.
      - **stats** : an instance of `PDMPStats`.
      - **args** : arguments passed.
""" 
type pdmpResult
	time::Vector{Float64}
	xc::Matrix{Float64}
	xd::Matrix{Int64}
	stats::pdmpStats
	args::pdmpArgs
end

"""
  This takes a single argument of type `pdmpResult` and returns a `DataFrame`.
"""
function pdmp_data(s::pdmpResult)
	println("--> Entry in pdmp_data_list")
	df = hcat(DataFrame(time=s.time),convert(DataFrame,s.xd'))
	df
end
