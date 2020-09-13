function Eout = lens_procession(U_before_lens,lens,LPW,SPW)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    U=U_before_lens.*lens;
    U_normalized=zeros(SPW,SPW);
    U_normalized(1+(SPW-LPW)/2:LPW+(SPW-LPW)/2,1+(SPW-LPW)/2:LPW+(SPW-LPW)/2)=U;
    Eout=U_normalized;
end

