function [phrase_input,img_output] = GS_steps(img_initial,U_0)
%GS_STEPS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
img_input=ifft2(ifftshift(img_initial));
phrase_input=angle(img_input);
img_begin=U_0.*exp(1i*phrase_input);

img_output=fftshift(fft2(img_begin));
end

