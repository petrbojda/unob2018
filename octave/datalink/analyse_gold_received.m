%% Signal generator

% simulation parameters
f_sampl = 50e3; % sampling frequency in kHz
T_int = 0.1; % entire signal length in ms
f_IF = 15e3; % IF frequency in kHz

chr = 1.0e3; % chip rate in kbps
tic
% time scale shaping
t=0:1/f_sampl:T_int;

% gold code generator
prn_1 = PRNcode(1,2,10);

% baseband signal generator
I = 2*(train_pulse (t,length(prn_1),1/chr+eps,0,0,prn_1)-.5);
Q = zeros(size(t));

% quadrature modulator - IF band
x_bpsk = quad_comp (I,Q,t,f_IF,0,0,0); 
toc
%% Receiving the signal

r_x = range_receiver(t,[x_bpsk],20);

%% Processing

% IQ detection
[rx_BQ, rx_BI] = quad_decomp (r_x,t,f_IF,0,0,0,11);

% Resampling


% Correlation
r_dec_Q = matched_filter_freqdom(t,Q,rx_BQ);
r_dec_I = matched_filter_freqdom(t,I,rx_BI);

figure(20);plot(t,rx_BQ,'-k',t,abs(r_dec_Q)/max(abs(r_dec_Q)),'-r');
axis([0,T_int,-.2,1.2]);grid on;title('matched filter output Q');
figure(21);plot(t,rx_BI,'-k',t,abs(r_dec_I)/max(abs(r_dec_I)),'-r');
axis([0,T_int,-.2,1.2]);grid on;title('matched filter output I');

fft_spektrum (r_x,t,30);


