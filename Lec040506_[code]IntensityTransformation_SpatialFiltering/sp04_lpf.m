%pkg load image % for only octave

% sp04_lpf: Low Pass Filtering
%
%  Consider the boundary or border effects of spatial low pass filtering. 
%  Depending on the boundary options of an image (zero padding, circular,
%  symmetric, and replicate), the borders of the spatial low pass filtered
%  image are somewhat different.  
%  To see the boundary effects readily, we examine two filtering examples: 
%   1. For a binary disk image threedisks.bmp, compare the following three
%      kinds of low pass filtering, gz, gc, and gs.
%           gz = imfilter(f,h)
%           gc = imfilter(f,h,'circular')
%           gs = imfilter(f,h,'symmetric')
%      where h = ones(20)/400.
%   2. For another color image Flower.tif, compare 4 kinds of Gaussian low 
%     pass filterings corresponding to the boundary options zero padding, 
%     circular, symmetric, and replicate.
%
%  M function: imfilter, fspecial
%  C function: imarray, imarrayp
%     Outputs: sp27 ~ 29.eps


   close all; clc; clear;
   
% Read the image threedisks.bmp
   f = im2double(imread('threedisks.bmp')); 
   [R,C] = size(f), 
  
% (1) compare the following two kinds of low pass filterings gz and gc.
% (Note): By default, imfilter(f, h) is a correlation,
%        while imfilter(f, h,'conv') is a convolution of f and h
%  When h is symmetrical, these are the same operation, i.e.,
%        imfilter(f, h) = imfilter(f, h,'conv')
   h = ones(20)/400;      % <--- symmetrical h: convolution = correlation  
   gz = imfilter(f, h);             % zero padding
   gc = imfilter(f, h, 'circular'); % circularly shifted
   gsym = imfilter(f, h, 'symmetric'); % circularly shifted
   im4 = imarray(2,2,[10,10,0.6],4,[f,gz,gc,gsym]); 
 
figure(1);   imshow(im4,[-1,1]); text(-15,1.7*R,'\rightarrow','color','r');  
  text(2*C+10,1.7*R,'\leftarrow','color','r');   
  title('LPFs corresponding to boundary options');
     con = {'Given binary image','zero','circular','symmetric'};
 for k=1:4,
    [ro, co] = imarrayp(2,2,[10,10],k,[R,C],[10,10]);
    text(co,ro, [ con{k} ], 'color','b');
 end
 
  % In the above figure, the borders marked by red arrows show clear difference
  % corresponding to the boundary option. 
  
% (2) For another color image Flower.tif, compare 4 kinds of Gaussian LPFs
%    corresponding to the boundary options zero padding, circular, symmetric, 
%    and replicate.
    f = imread('Flower.tif'); 
    [X,Y,z] = size(f),   % 351 351 3
    Xh = round(X/2), Yh =round(Y/2)
% Gaussian LPF h
    h = fspecial('gaussian', [25,25], 5);  
    % h is symmetric Gaussian of size 25x25 with standard deviation 5  
% GLPFs according to 4 boundary options    
   gr = imfilter(f,h, 'replicate');
   gc = imfilter(f,h, 'circular');  
   gz = imfilter(f,h); % zero padding
   gs = imfilter(f,h, 'symmetric');
   st = {'replicate','circular', 'zero','symmetric'};
   gm4 = imarray(2,2,[20,20],4, cat(2, gr,gc,gz,gs));  % Concatenate 4 GLPF images
   circ4 = imarray(3,3,[0,0],9, cat(2,f,f,f,f,f,f,f,f,f));  % Concatenate 9 images
   crop = imcrop(circ4,[Y-50, X-50, Y+100,X+100]);
figure(2); imshow(crop);  title('\bfCropped circularly arranged f');

figure(3); imshow(gm4);  
 title(['\bfGLPFs according to 4 boundary options: replicate, circular,',...
       ' zero, symmetric']); 
 for k=1:4
   [ro, co] = imarrayp(2,2,[20,20],k,[X,Y],[10,10]);
   text(co,ro, [ st{k} ], 'color','b');
 end

 % (Comments): 
 %  From figure(2) that is an example for the circularly arranged f,
 %      The circularly shifted image will effect on the border of image, 
 %       especially on the top boundary.
 %  In case of default option (zero padding), smoothed border appears on 
 %  the whole border of image. 
 
  