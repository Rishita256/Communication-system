function mod = myModulator(txBits, constellation)
%bits are input to the function and they need to be mapped to the provided
%constellation
numBits = length(txBits);%number of bits in the binary vector

M = length(constellation); %M determines the type of keying
N = log2(M); %number of bits in each symbol

reshaped_txBits = transpose(reshape(txBits',[N,numBits/N])); 
%we reshape the vector of bits to obtain a vector of symbols of size M each

reshaped_txBits_str = num2str(reshaped_txBits);
%convert from number to string 

symNumVec = bin2dec(reshaped_txBits_str);
%maps bits representing symbols to integers

modSymbols = constellation(symNumVec+1);
%symbol numbers mapped to constellation
mod = modSymbols;
end



