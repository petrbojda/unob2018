function [xk,xvz,kod,c_kod,tkod,prevod] = kvantizace(x,t,n,tvz)

% [xk,xvz,kod,c_kod,tkod,prevod] = kvantizace(x,t,n,tvz)
% funkce realizuje prevod analogoveho signalu na digitalni, seriovy kod
%
% vstupy:
%    x ....... "analogovy" signal
%    t ....... casova osa "analogoveho" signalu
%    n ....... vektor kvantizacnich urovni
%    tvz ..... casova zakladna vzorkovani
% 
% vystupy:
%    xk ...... numericka rada kodu signalu
%    xvz ..... hodnoty signalu v okamzicich vzorkovani
%    kod ..... zakodovany signal pro seriovy prenos
%    c_kod ... takt (bit-rate) serioveho prenosu
%    tkod .... casova zakladna kodovaneho signalu
%    prevod .. tabulka prevodu analogovych hodnot na kod 
%              (kvantizacni tabulka)
%
% Funkce vyuziva m-file train_pulse vytvoreny v ramci teorie prenosu
% a m-file de2bi z Communicaton Toolboxu
%
% Priklad pouziti:
% >> t=0:0.01:1;x=sin(2*pi*1*t);
% >> tvz=(0:0.1:1);
% >> n=(-1:.2:1);
% >> [xk,xvz,kod,c_kod,tkod,prevod] = kvantizace(x,t,n,tvz);
% >> figure(1);subplot(2,1,1);plot(t,x);grid on;
% >> figure(1);subplot(2,1,2);plot(tkod,kod,tkod,0.25+c_kod/4);axis([min(tkod),max(tkod),-.5,1.5]);grid on;
% >> fft_spektrum(x,t,2);
% >> fft_spektrum(kod,tkod,3);
%
% Petr Bojda  kveten 2005




%%%%%%%%% vypocet casovani pro vyslani kodu %%%%%%%%%%%%%%%%
pocet_kvant_urovni = length(n)
pocet_bitu = ceil(log(pocet_kvant_urovni)/log(2))
vzorkovaci_interval = abs(tvz(1) - tvz(2))
vzorkovani_kodu = vzorkovaci_interval / (50*pocet_bitu)

tkod = min(tvz):vzorkovani_kodu:max(tvz);

%%%%%%%%% vytvoreni prevodni tabulky kod - hodnota %%%%%%%%%%
for i1 = 1:pocet_kvant_urovni
    prevod(1,i1) = n(i1);
    prevod(2,i1) = i1-1;
end

%%%%%%%%% kvantizace vstupniho signalu %%%%%%%%%%%%%%%
kvantum = max(n)-min(n)/pocet_kvant_urovni;
for i1=1:length(tvz)
    index_casovani = 0;
    index_casovani = find( t>=tvz(i1) & t<tvz(i1)+vzorkovaci_interval*.95 );
    xvz(i1) = x(min(index_casovani));       %  vzorkovany signal
    if xvz(i1)>max(n), 
        xk(i1) = max(prevod(2,:));
    elseif xvz(i1)<min(n), 
        xk(i1) = min(prevod(2,:));
    else
        index_urovne = find( (xvz(i1) >= n) & (n > xvz(i1)-kvantum) );
        xk(i1) = prevod(2,max(index_urovne));
    end
end

%%%%%%%% taktovani (bitrate) kodu pro dig. prenos %%%%%%%%%%%%
c_kod = zeros(size(tkod));
for i1 = 1:length(xk)
    c_kod = c_kod | train_pulse(tkod,pocet_bitu,30*vzorkovani_kodu,20*vzorkovani_kodu,pocet_bitu*50*vzorkovani_kodu*(i1-1),ones(1,pocet_bitu));
%    pocet_bitu*50*(i1-1)
end

%%%%%%%% vytvoreni impulzniho kodu pro dig. prenos %%%%%%%%%%%%
kod = zeros(size(tkod));
for i1 = 1:length(xk)
    kod =kod | train_pulse(tkod,pocet_bitu,30*vzorkovani_kodu,20*vzorkovani_kodu,pocet_bitu*50*vzorkovani_kodu*(i1-1),de2bi(xk(i1),pocet_bitu));
%    pocet_bitu*50*(i1-1)
end

