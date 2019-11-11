function [rec,x_0] = receiver_multipath(t,I,Q,f0,p0,pE,jtr,paths,SNR_dB) 

%  [rec,x_0] = receiver_multipath(t,I,Q,f0,p0,pE,jtr,paths,SNR_dB) 
%   
%     Function projects signal situation with respect of the point 
%     of receiver. 
%     It adds adequate noise level, specified in dB, and multipath
%     replicas of signal together with a direct path signal. What more,
%     it also formes the signal reference with a zero delay.
%
%       t ....... time scale vector
%       I,Q ..... baseband complex envelope, original
%       f0 ...... local oscilator frequency
%       p0 ...... starting phase of the LO signal (phase disbalance)
%       pE ...... phase error between LO and LO+pi/2 signals
%       jtr ..... sampling jitter (percent of sample period)
%       paths ... vector of delays representing specified paths
%       SNR_dB .. required signal to noise ratio
%       fig ..... figure number

x_0 = quad_comp (I,Q,t,f0,p0,pE,jtr);

x = zeros([length(path),length(t)]);

for i1 = 1:length(t)
    % zde dopsat poskladani zpozdenych kopii
end

rec = zeros(size(t));
for i1 = 1:length(t)
   for i2 = 1:length(paths)
       rec(i1) = rec(i1) + x(i2,i1);
   end
end

s = norm(rec)/sqrt(length(t));
snr = 10^(SNR_dB/10);
N = s/snr;
noise = N .* randn(size(t));
n = norm(noise,2)/sqrt(length(t));

SNR_dB_c = 10 * log10(s/n)

for i1 = 1:length(t)
    if abs(rec(i1)) < abs(noise(i1))
        rec(i1) = noise(i1);
    end
end
    
