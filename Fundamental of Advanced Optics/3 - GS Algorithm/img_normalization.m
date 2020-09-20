function img_output = img_normalization(img_input)
%IMG_NORMALIZATION 此处显示有关此函数的摘要
%   此处显示详细说明
img_abs=abs(img_input);
img_output=img_abs/max(max(img_abs));
end

