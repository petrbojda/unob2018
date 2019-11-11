function [x_BQ, x_BI] = quad_decomp (x,t,f0,p0,pE,jtr,fig)

%   [x_BQ, x_BI] = quad_decomp (x,t,f0,p0,pE,fig)
%
%   Function represents the quadratic demodulator
%       x ..... real signal to be decomposed to I and Q
%       t ..... time scale vector
%       f0 .... local oscilator frequency
%       p0 .... starting phase of the LO signal (phase disbalance)
%       pE .... phase error between LO and LO+pi/2 signals
%       jtr .... sampling jitter (percent of sample period)
%       fig .... figure number
%    

trange = max(t)-min(t);
tstep = (trange/(length(t)-1));
t_jitter = jtr*tstep/100 * randn(size(t));
t_noisy = t + t_jitter;


s_I = cos(2*pi*f0*t_noisy + p0);
s_Q = sin(2*pi*f0*t_noisy + p0 + pE);

x_I_mix = x .* s_I;
x_Q_mix = x .* s_Q;

X_I_mix = fft(x_I_mix);
X_Q_mix = fft(x_Q_mix);

f = [0:1/trange:0.5/tstep + 0.5/trange,-0.5/tstep:1/trange:0-1/trange];
LP_flt = (f > -1.3*f0)&(f < 1.3*f0);
X_I_f = X_I_mix .* LP_flt;
X_Q_f = X_Q_mix .* LP_flt;

x_BQ = ifft(X_Q_f);
x_BI = ifft(X_I_f);

if(nargin > 6),
%     figure(fig);
%     subplot(2,1,1); 
%     plot(t,x);grid on;title('IF signal');xlabel('time');
%     subplot(2,1,2);semilogy(f,abs(fft(x)));grid on;xlabel('frequency');
    
%     figure(fig + 1);
%     subplot(3,1,1);plot(t,x_I_mix);grid on;
%     title('Mix result - I channel');xlabel('time');
%     subplot(3,1,2);semilogy(f,abs(X_I_mix));grid on;xlabel('frequency');
%     subplot(3,1,3);plot(f,abs(LP_flt));grid on;
%     title('LP filter /freq response');xlabel('frequency');
%     
%     figure(fig + 2);
%     subplot(3,1,1);plot(t,x_Q_mix);grid on;
%     title('Mix result - Q channel');xlabel('time');
%     subplot(3,1,2);semilogy(f,abs(X_Q_mix));grid on;xlabel('frequency');
%     subplot(3,1,3);plot(f,abs(LP_flt));grid on;
%     title('LP filter /freq response');xlabel('frequency');
    
%     X_BQ = fft(x_BQ);
%     figure(fig + 3);
%     subplot(3,1,1); plot(t,x_BQ);grid on;
%     title('Envelope - Q channel (imaginary)');xlabel('time');
%     subplot(3,1,2);semilogy(f,abs(X_BQ));grid on;
%     title('Envelope spectrum - after fft');xlabel('frequency');
%     subplot(3,1,3);semilogy(f,abs(X_Q_f));grid on;
%     title('Envelope spectrum - after filtration');xlabel('frequency');
%     
%     X_BI = fft(x_BI);
%     figure(fig + 4);
%     subplot(3,1,1); plot(t,x_BI);grid on;
%     title('Envelope - I channel (real)');xlabel('time');
%     subplot(3,1,2);semilogy(f,abs(X_BI));grid on;
%     title('Envelope spectrum - after fft');xlabel('frequency');
%     subplot(3,1,3);semilogy(f,abs(X_I_f));grid on;
%     title('Envelope spectrum - after filtration');xlabel('frequency');  

    figure(fig);
    subplot(3,1,1); plot(t,x);grid on;title('Real signal');xlabel('time');
    subplot(3,1,2); plot(t,x_BQ);grid on;
        title('CPLX Envelope - Q channel (imaginary)');xlabel('time');
    subplot(3,1,3); plot(t,x_BI);grid on;
        title('CPLX Envelope - I channel (real)');xlabel('time');
    
    figure(fig+5);
    
    plot(x_BI,x_BQ,'-g',x_BI,x_BQ,'+b');
    title('Constellation diagram');xlabel('In-phase');ylabel('Quadrature');
%   axis(1.1*[min(x_BI),1.1*max(x_BI),1.1*min(x_BQ),1.1*max(x_BQ)]);
    axis([-1.1,1.1,-1.1,1.1]);grid on;
end


    

