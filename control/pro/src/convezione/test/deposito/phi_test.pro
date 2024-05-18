

phi(X,T0,NU,F) :- F is exp(-(X-4*T0)^2/(4*NU*(T0+1))) + exp(-((X-4*T0-2*pi)^2)/(4*NU*(T0+1))).

phi1(X,T0,NU,F) :- F is -(X-4*T0)^2/(4*NU*(T0+1)).
phi2(X,T0,NU,F) :- F is exp(-(X-4*T0)^2/(4*NU*(T0+1))).
phi3(X,T0,NU,F) :- F is exp(-(X-4*T0-2*pi)^2/(4*NU*(T0+1))).
phi4(X,T0,NU,F) :- F is -((X-4*T0-2*pi)^2).
