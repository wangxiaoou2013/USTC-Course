function Eout = PSF_SW(U0,x1,y1,z,dx,dy,xx,yy,k)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    R=sqrt((xx-x1).^2+(yy-y1).^2+z^2);
    U_out=U0*dx*dy*exp(1i*k*R)./R;
    Eout=U_out;
end

