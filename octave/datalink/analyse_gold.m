%% Signal generator

% simulation parameters
f_sampl = 100e3; % sampling frequency in kHz
T_int = 1; % entire signal length in ms
f_IF = 10.7e3; % IF frequency in kHz

chr = 1.023e3; % chip rate in kbps

% time scale shaping
t=0:1/f_sampl:T_int;

% gold code generator
prn_1 = PRNcode(1,2);

% baseband signal generator
I = 2*(train_pulse (t,length(prn_1),1/chr+eps,0,0,prn_1)-.5);
Q = zeros(size(t));

% quadrature modulator - IF band
x_bpsk = quad_comp (I,Q,t,f_IF,0,0,0,1); 

%% Decomposition



[x_BQ0, x_BI0] = quad_decomp (x_bpsk,t,10.7e3,0,0,0,11);
[x_BQ1, x_BI1] = quad_decomp (x_bpsk,t,10.70008e3,0,0,2,21);
[x_BQ2, x_BI2] = quad_decomp (x_bpsk,t,10.7005e3,pi/8,pi/16,2,31);

% fft_spektrum(x_bpsk,t,19);
% fft_spektrum(y_bpsk,t,29);
% fft_spektrum(m_bpsk,t,39);