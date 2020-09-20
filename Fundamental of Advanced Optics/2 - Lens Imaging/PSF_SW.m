function Eout = PSF_SW(U0,x1,y1,z,dx,dy,xx,yy,k)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    R=sqrt((xx-x1).^2+(yy-y1).^2+z^2);
    U_out=U0*dx*dy*exp(1i*k*R)./R;
    Eout=U_out;
end

