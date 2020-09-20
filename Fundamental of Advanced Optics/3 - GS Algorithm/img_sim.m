function value = img_sim(img1,img2)
%IMG_SIM 此处显示有关此函数的摘要
%   此处显示详细说明
value_matrix=corrcoef(img1,img2);
value=min(value_matrix(:));
end

