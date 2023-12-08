clear
clear all
clc

numBits =1000;% number of bits
txBits = rand(1,numBits)<0.5;%generate bits with rand function
constellation = [1+1i 1-1i -1+1i -1-1i];% qpsk constellation
%constellation = [-1 1];% bpsk constellation
%constellation = [1+1i 3+1i 3+3i 1+3i -1+1i -3+1i -3+3i -1+3i 1-1i 3-1i ...
 %   3-3i 1-3i -1-1i -3-1i -3-3i -1-3i];% 16 qam constellation

modulatedSignal = myModulator(txBits, constellation);
% modulating signal by mapping bits to constellation

for n = 1:100
esnodb = n/10;% es/No in dB
esno = 10^(esnodb/10); 
snr = sqrt(esno);
%rxModSymbols = awgn( modulatedSignal , snr );% adding additive white gaussian noise
noise = (1/sqrt(2))*(randn(length(modulatedSignal),1) + 1i*randn(length(modulatedSignal),1));
% generating additive white gaussian noise
%rxModSymbols = awgn(modulatedSignal, n);
% generating additive white gaussian noise
rxModSymbols = (1/snr).*noise' + modulatedSignal;
% adding noise to modulated signal

[demodulatedSymbols, demodulatedBits] = myDemodulator(rxModSymbols, constellation);
% demodulating signal by mapping symbols to constellation


SER =round(abs(modulatedSignal-demodulatedSymbols),2)>0;% symbol error rate

BER = round(abs(txBits-demodulatedBits),2);% bit error rate

SER_percent(n) = sum(SER)/length(SER);% percentage of SER
BER_percent(n) = sum(BER)/length(BER);% percentage of BER
end

semilogy(BER_percent)
hold on
semilogy(SER_percent)
hold off


