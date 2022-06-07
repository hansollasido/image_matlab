%% Read in an image
clc;
clear all;
close all;

img1 = imread('Penguins_gray.png');
img2 = imread('lena.png');

figure(1);
imshow(img1);

figure(2);
imshow(img2);

imSize1 = size(img1);
imSize2 = size(img2);
img1_binary = dec2bin(img1);
img1_shift = bitshift(img1,-2);
img1_shift_binary = dec2bin(img1_shift);
img1_shift_reshape = reshape(img1_shift,[],1);


img1_shift_reshape_bitget = zeros(65536,8);

for i=1:65536
    img1_shift_reshape_bitget(i,1:1:8) = bitget(img1_shift_reshape(i,1),8:-1:1);
end

%% img2

img2_binary1 = dec2bin(img2(:,:,1));
img2_binary2 = dec2bin(img2(:,:,2));
img2_binary3 = dec2bin(img2(:,:,3));

img2_reshape1 = reshape(img2(:,:,1),[],1);
img2_reshape2 = reshape(img2(:,:,2),[],1);
img2_reshape3 = reshape(img2(:,:,3),[],1);

img2_reshape_bitget1 = zeros(65536,8);
img2_reshape_bitget2 = zeros(65536,8);
img2_reshape_bitget3 = zeros(65536,8);

for i=1:65536
    img2_reshape_bitget1(i,1:1:8) = bitget(img2_reshape1(i,1),8:-1:1);
    img2_reshape_bitget2(i,1:1:8) = bitget(img2_reshape2(i,1),8:-1:1);
    img2_reshape_bitget3(i,1:1:8) = bitget(img2_reshape3(i,1),8:-1:1);
end


