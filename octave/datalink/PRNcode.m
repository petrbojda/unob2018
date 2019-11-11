function gold = PRNcode (x1,x2,len)

sr1(1:10)=[1 1 1 1 1 1 1 1 1 1];
sr2(1:10)=[1 1 1 1 1 1 1 1 1 1];
pp1(1:10)=[0 0 1 0 0 0 0 0 0 1];
pp2(1:10)=[0 1 1 0 0 1 0 1 1 1];

for i1=(1:len*1023)
    g1(i1)=sr1(10);
    in1=mod(sum(sr1.*pp1),2);
    
    g2(i1)=double(xor(sr2(x1),sr2(x2)));
    in2=mod(sum(sr2.*pp2),2);
    
    gold(i1)=mod(g1(i1)+g2(i1),2);
    
    sr1=[in1 sr1(1:9)];
    sr2=[in2 sr2(1:9)];
end
% k=xcorr(gold,gold,'coef');
% plot(k)
% grid on