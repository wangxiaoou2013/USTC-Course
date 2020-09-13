clear; close all;
wavelength=0.633; k=2*pi/wavelength;

%parameter of magnification
M_list=[1,2,6];

%parameter of lens
f=100;
d=100;

%parameter of range
img_width=40;
img_pixel_width=300;
m=6;

dx=img_width/img_pixel_width;
dy=dx;

lens_width=d;
lens_pixel_width=d/dx;
screen_width=img_width*m;
screen_half_width=screen_width/2;
screen_pixel_width=img_pixel_width*m;

LPW=lens_pixel_width;
SPW=screen_pixel_width;
IPW=img_pixel_width;
SHW=screen_half_width;

x=((1:SPW)-(1+SPW)/2)*dx; y=x;
[xx,yy]=meshgrid(x,y);
r=sqrt(xx.^2+yy.^2);

x_lens=((1:LPW)-(1+LPW)/2)*dx; y_lens=x_lens;
[xx_lens,yy_lens]=meshgrid(x_lens,y_lens);
r_lens=sqrt(xx_lens.^2+yy_lens.^2);

x_object=((1:IPW)-(1+IPW)/2)*dx; y_object=x_object;
[xx_object,yy_object]=meshgrid(x_object,y_object);
r_object=sqrt(xx_object.^2+yy_object.^2);

%import the object
img=imread('a.bmp');
object=im2double(img);
%img=zeros(IPW,IPW);
%img(IPW/2-5,IPW/2)=1;
%img(IPW/2+5,IPW/2)=1;
%object=img;


%import the lens
lens=exp(-1i*k/2/f*r_lens.^2);
lens(r_lens>(d/2))=0;

Indensity=zeros(SPW,SPW);

%Extension%
X(1:SPW)=x(1)-x(SPW:-1:1);
X(SPW+1:2*SPW)=x(1:SPW)-x(1);
Y(1:SPW)=y(1)-y(SPW:-1:1);
Y(SPW+1:2*SPW)=y(1:SPW)-y(1);
[XX,YY]=meshgrid(X,Y);

for m_order=3:1:3
    M=M_list(m_order);
    [z1,z2]=Z_Solve(f,M);
    for i=1:1:IPW
        for j=1:1:IPW
            tic
            location=['m:',num2str(M),' x:',num2str(i),'/',num2str(IPW),' y:',num2str(j),'/',num2str(IPW)];
            disp(location);
            if object(i,j)~=0
                x1=x_object(i);
                y1=y_object(j);
                U_before_lens=PSF_SW(object(i,j),x1,y1,z1,dx,dy,xx_lens,yy_lens,k);
                U_after_lens=lens_procession(U_before_lens,lens,LPW,SPW);
                U_PSF=RSF(k,z2,dx,SPW,XX,YY,U_after_lens);
                I_PSF=abs(U_PSF).^2;
                Indensity=Indensity+I_PSF;
            end
            toc
        end
    end
    str=['Figure ',num2str(m_order),' - The Energy Distribution when M=',num2str(M)];
    fig=figure(m_order);imagesc(-SHW:SHW/6:SHW,-SHW:SHW/6:SHW,Indensity);colorbar;
    title(str);xlabel('X(um)');ylabel('Y(um)');
end