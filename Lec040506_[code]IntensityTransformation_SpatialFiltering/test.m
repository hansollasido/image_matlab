
f = imread('Lighthouse.tif');
f_gray = rgb2gray(f);
f_gray = (f_gray);

f_min = min(min(f_gray));
f_max = max(max(f_gray));

g = (f_gray - f_min)/(f_max-f_min) * 255;

g_min = min(min(g));
g_max = max(max(g));

figure(1);
imshow(uint8(f_gray));

figure(2);
imshow(uint8(g));
