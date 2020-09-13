function Eout = RSF(k,z,pixel,screen_range,XX,YY,object)
%RSF 此处显示有关此函数的摘要
%   此处显示详细说明
    rr=sqrt(XX.^2+YY.^2+z^2);
    G=1/(2*pi).*exp(-1i*k*rr)./rr.^2*z.*(1./rr+1i*k);
    U0=zeros(2*screen_range,2*screen_range);
    U0((1:screen_range)+(screen_range)/2,(1:screen_range)+(screen_range)/2)=object;
    fft_U0=fft2(U0); fft_G=fft2(G);
    fft_U=fft_U0.*fft_G;
    U=fftshift(ifft2(fft_U))*pixel^2;
    Eout=U((1:screen_range)+(screen_range)/2,(1:screen_range)+(screen_range)/2);
end

