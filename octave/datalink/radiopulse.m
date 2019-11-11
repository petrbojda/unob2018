function x = radiopulse (t,tp,ts,fc)

%  x = radiopulse (t,tp,ts,fc,kf,fmf,fig)
%   x ... vecor of 

ma = (t > ts)&(t < ts+tp);
%mf = kf*sin(2*pi*fmf*(t-ts));
%c = sin (2*pi*fc*(t-ts)+mf);
c = sin (2*pi*fc*(t-ts));
x = ma.*c;
