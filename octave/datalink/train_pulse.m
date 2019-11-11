function x = train_pulse (t,n,tp,ti,ts,kod)

%  x = train_pulse (t,n,tp,ti,ts,kod)
%
%   x ..... impulzni signal
%   t ..... casova osa
%   n ..... pocet pulzu v case t
%   tp .... sirka impulzu
%   ti .... sirka mezery mezi impulzy
%   ts .... casova prodleva mezi zacatkem osy t a prvnim impulzem
%   kod ... vektor binarnich hodnot predstavujici digitalni posloupnost
%           prevedenou na impulzy (1 - imp. pritomen, 0 - imp.
%           nepritomen)

if(nargin < 6)
    kod = ones(1,n);
end;

x=zeros(size(t));
for i1 = 1:n
    x = double(x | ((t > ts + (i1-1)*(tp+ti)) & (t < ts + tp + (i1-1)*(tp+ti)) & kod(i1)));
end
