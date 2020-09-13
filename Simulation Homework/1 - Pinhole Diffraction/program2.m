clear; close all;
wavelength=0.633; k=2*pi/wavelength;
pixel=0.5;
f=500;

%parameter of hole
diameter=500; radius=diameter/2;

%parameter of range
xy_range=1000;
screen_range=xy_range/pixel;
z_min=480;
z_max=520;
vertical_range=(z_max-z_min+1)/pixel;
x=((1:screen_range)-(1+screen_range)/2)*pixel; y=x;
[xx,yy]=meshgrid(x,y);
r=sqrt(xx.^2+yy.^2);

%initialization of object
hole=zeros(size(r));
hole(r<=radius)=1;
lens=exp(-1i*k/2/f*r.^2);
object=hole.*lens;

screen=zeros(screen_range,screen_range,vertical_range);

ii=0;

%Extension%
X(1:screen_range)=x(1)-x(screen_range:-1:1);
X(screen_range+1:2*screen_range)=x(1:screen_range)-x(1);
Y(1:screen_range)=y(1)-y(screen_range:-1:1);
Y(screen_range+1:2*screen_range)=y(1:screen_range)-y(1);
[XX YY]=meshgrid(X,Y);

for z=z_min:pixel:z_max
    ii=ii+1;

    rr=sqrt(XX.^2+YY.^2+z^2);
    G=1/(2*pi).*exp(1i*k*rr)./rr.^2*z.*(1./rr-1i*k);
    U0=zeros(2*screen_range,2*screen_range);
    U0((1:screen_range)+(screen_range)/2,(1:screen_range)+(screen_range)/2)=object;
    fft_U0=fft2(U0); fft_G=fft2(G);
    fft_U=fft_U0.*fft_G;
    U=fftshift(ifft2(fft_U))*pixel^2;
    UU=abs(U);
    Intensity=UU((1:screen_range)+(screen_range)/2,(1:screen_range)+(screen_range)/2);
    screen(:,:,ii)=Intensity;
    
end

monitor_half_range=50;
monitor_half_pixel_range=monitor_half_range/pixel;

Intensity_slice=zeros(monitor_half_pixel_range*2+1,vertical_range);
Intensity_slice(:,:)=screen(screen_range/2,screen_range/2-monitor_half_pixel_range:screen_range/2+monitor_half_pixel_range,:);

figure(1);imagesc(z_min:5:z_max,-monitor_half_range:10:monitor_half_range,Intensity_slice);colorbar;
title('Figure 1 - The Energy Distribution of Y-Z Surface');xlabel('Z(um)');ylabel('Y(um)');