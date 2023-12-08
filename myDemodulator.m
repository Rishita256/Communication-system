function [demodSym, demodBits] = myDemodulator(rxModSymbols, constellation)
%symbols are input to the function and they need to be mapped to the provided
%constellation to give bits
N = log2(length(constellation));

for ii = 1: length(rxModSymbols)
  distances = abs(constellation-rxModSymbols(ii));
  % distances is the norm of received symbols and each constellation 
  [~ , index] = min(distances)   ;
  %min of distances gives the index of the most appropriate constellation
  detModSym(ii) = constellation(index);
  
  %detModBit(N*i-N+1 :N*i) = dec2bin(index-1, N);
  detModBit(ii,:) = double(dec2bin(index-1, N))-48;
  
end

demodSym = detModSym;
demodBits = transpose(reshape(detModBit', [], 1));

% for n = 1:N*length(rxModSymbols) % to convert string of bits to binary bits
% demodBits(n)= str2num(detModBit(n));
% end

end