clear; close all; clc;

img_original=im2double(imread('Lenna.jpg'));
[Y,X]=size(img_original);

bar=waitbar(0,'Iterating...','Name','Progress');
dx=1;dy=1;
x=((1:X)-(X-1)/2)*dx;
y=((1:Y)-(Y-1)/2)*dy;
[xx,yy]=meshgrid(x,y);
r=sqrt(xx.^2+yy.^2);

omega_0=150;
U_0=exp(-(r/omega_0).^2);

rand_matrix=exp(2i*pi*rand(Y,X));
img_initial=img_original.*rand_matrix;


[phrase_input,img_output]=GS_steps(img_initial,U_0);
img_figure=img_normalization(img_output);
temp=corrcoef(img_figure,img_original);
value_sim=img_sim(img_figure,img_original);
str=['Iterating...',num2str(value_sim,'%.4f')];
waitbar(value_sim,bar,str);
i=0;


while value_sim<0.995
    phrase_output=angle(img_output);
    img_initial=img_original.*exp(1i*phrase_output);
    [phrase_input,img_output]=GS_steps(img_initial,U_0);
    img_figure=img_normalization(img_output);
    value_sim=img_sim(img_figure,img_original);
    i=i+1;
    str=['Iterating...',num2str(value_sim,'%.4f')];
    waitbar(value_sim,bar,str);
end

close(bar);

figure(1);
subplot(2,2,1);imshow(real(img_original));title('Original Image');
subplot(2,2,2);imshow(U_0),title('Distribution of Light');
subplot(2,2,3);imshow(phrase_input);title('Phrase Image');
subplot(2,2,4);imshow(img_figure);title('Result Image');