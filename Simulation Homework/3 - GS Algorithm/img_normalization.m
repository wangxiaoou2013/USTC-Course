function img_output = img_normalization(img_input)
%IMG_NORMALIZATION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
img_abs=abs(img_input);
img_output=img_abs/max(max(img_abs));
end

