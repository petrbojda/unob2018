function [c] = matched_filter_freqdom(t,x_ref,x) 

X = fft(x);
X_ref = fft(x_ref);
C=X.*conj(X_ref);
c = ifft(C);

