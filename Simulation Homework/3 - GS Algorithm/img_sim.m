function value = img_sim(img1,img2)
%IMG_SIM �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
value_matrix=corrcoef(img1,img2);
value=min(value_matrix(:));
end

