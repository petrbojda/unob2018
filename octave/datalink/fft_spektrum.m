function [X,f] = fft_spektrum (x,t,fig,vz)

%  [X,f] = fft_spektrum (x,t,fig)
%   x ... vecor of 

trange = max(t)-min(t);
tstep = (trange/(length(t)-1));
f = [0:1/trange:0.5/tstep + 0.5/trange,-0.5/tstep:1/trange:0-1/trange];

X = fft(x);

if(nargin > 2),
    figure(fig);
    if(nargin <= 3) vz = 0; end
    subplot(2,1,1); 
    if vz == 0, plot(t,x);grid on;
    else stem(t,x,'.b');grid on;    
    end
    subplot(2,1,2);semilogy(f,abs(X));grid on;
    %subplot(3,1,3);plot(f,angle(X)*180/pi);grid on;
end    