function Uout = PSF_SW_int(U0,xx0,yy0,z,dx,dy,xx1,yy1,k,W0,W1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    U_sigma=zeros(W1,W1);
    for x0_pixel=1:W0
        for y0_pixel=1:W0
            x0=xx0(x0_pixel,y0_pixel);
            y0=yy0(x0_pixel,y0_pixel);
            U_single=PSF_SW(U0(x0_pixel,y0_pixel),x0,y0,z,dx,dy,xx1,yy1,k);
            U_sigma=U_sigma+U_single;
        end
    end
    Uout=U_sigma;
end

