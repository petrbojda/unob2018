function x = pulse (t,tp,ts)

%  x = pulse (t,tp,ts)
%   x ... vecor of 

x = (t > ts)&(t < ts+tp);
