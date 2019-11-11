t=0:.000001:1;
t1 = .1;
t2 = t1 + 0.00000196;
lchirp = .5;
r_ref = chirppulse(t,lchirp,0,10,400000);
r1 = chirppulse(t,lchirp,t1,10,400000);
r2 = chirppulse(t,lchirp,t2,10,400000);
% r3 = chirppulse(t,.4,.25,6,60000);
% r4 = chirppulse(t,.4,.65,6,60000);
r_x = range_receiver(t,[r1;r2],3);

fft_spektrum (r_ref,t,1);
fft_spektrum (r_x,t,2);

tic
r_dec_f = matched_filter_freqdom(t,r_ref,r_x);
toc

figure(10);plot(t,r_x,'-k',t,abs(r_dec_f)/max(abs(r_dec_f)),'-r');
axis([0,1,-.2,1.2]);grid on;title('Freq domain algorithm');
%axis([.09999,.10001,-.2,1.2]);grid on;title('Freq domain algorithm');

length(t)