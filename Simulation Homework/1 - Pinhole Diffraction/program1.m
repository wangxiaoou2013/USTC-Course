clear; close all;
wavelength=0.633; k=2*pi/wavelength;
pixel=0.1;

%parameter of hole
diameter=10; radius=diameter/2;

%parameter of range
xy_range=25;
screen_range=xy_range/pixel;
z_range=100;
vertical_range=z_range/pixel;
x=((1:screen_range)-(1+screen_range)/2)*pixel; y=x;
[xx,yy]=meshgrid(x,y);
r=sqrt(xx.^2+yy.^2);

%initialization of object
object=zeros(size(r));
object(r<=radius)=1;

screen=zeros(screen_range,screen_range,vertical_range);

ii=0;

%Extension%
X(1:screen_range)=x(1)-x(screen_range:-1:1);
X(screen_range+1:2*screen_range)=x(1:screen_range)-x(1);
Y(1:screen_range)=y(1)-y(screen_range:-1:1);
Y(screen_range+1:2*screen_range)=y(1:screen_range)-y(1);
[XX,YY]=meshgrid(X,Y);

for z=0.1:0.1:100
    ii=ii+1;
    U=RSF(k,z,pixel,screen_range,XX,YY,object);
    Intensity=abs(U);
    screen(:,:,ii)=Intensity;
end

Intensity_slice=zeros(screen_range,vertical_range);
Intensity_slice(:,:)=screen(screen_range/2,:,:);

figure(1);imagesc(0:10:z_range,-xy_range/2:5:xy_range/2,Intensity_slice);colorbar;
title('Figure 1 - The Energy Distribution of Y-Z Surface');xlabel('Z(um)');ylabel('Y(um)');