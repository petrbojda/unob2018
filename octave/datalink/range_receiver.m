function [rec] = range_receiver(t,targets,SNR_dB) 

rec = zeros(size(t));


a = size(targets);
for i1 = 1:length(t)
   for i2 = 1:a(1)
       rec(i1) = rec(i1) + targets(i2,i1);
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
    
