using PDMP

function R_sir(xc,xd,t::Float64,parms,sum_rate::Bool)
  (S,I,R,~) = xd
  (beta,mu) = parms
  infection = beta*S*I
  recovery = mu*I
  const rate_display = 0.01
  if sum_rate == false
    return [infection,recovery,rate_display]
  else
    return infection+recovery + rate_display
  end
end

function F_sir(xdot,xc,xd,t::Float64,parms)
  # vector field used for the continuous variable
  xdot[1] = 0.0
  nothing
end

xc0 = vec([0.0])
xd0 = vec([99,10,0,0])
nu = [[-1 1 0 0];[0 -1 1 0];[0 0 0 1]]
parms = [0.1/100.0,0.01]
tf = 150.0

srand(1234)
dummy = PDMP.sample(1,xc0,xd0,F_sir,R_sir,(x,y,t,p,id)->vec([0.]),nu,parms,0.0,tf,false)
result = @time PDMP.sample(1000,xc0,xd0,F_sir,R_sir,(x,y,t,p,id)->vec([0.]),nu,parms,0.0,tf,false)

# Plots.plotlyjs()
# Plots.plot(result.time,result.xd[1,:],color=:red)
# Plots.plot!(result.time, result.xd[2,:],color=:green)
# Plots.plot!(result.time, result.xd[3,:],color=:blue,title = string("SIR - #Jumps = ",length(result.xd[1,:])))
