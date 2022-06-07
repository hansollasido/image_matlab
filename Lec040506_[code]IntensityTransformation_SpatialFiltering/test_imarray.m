% test_imarray.m: Test of imarray.m  
%
% Let us learn the use of <imarray.m> with the following examples.
%  (Example 1): Let us divide a single image into MxN subblocks in the same 
%  order of 'subplot' mode. Take any one among 4 images gk for k=1,2,3,4.
%    - Display it as 1x5 subimages on single figure with horizontal space 
%      width 32 (Hs=32).
%    - Display it as 3x3 subimages on single figure with the same horizontal 
%      and vertical width 10 (Hs=Hv=10).
%  (Example 2): Let gk denote the images of the same size 480x640x3 (k=1~4).
%   And let G be a concatenated images such as
%         G = cat(2, g1, g2, g3, g4);
% Then discuss the following Fk for k=1~7.
%     F1 = imarray(2, 2,[30,10], 4,G);
%     F2 = imarray(1, 4,[0, 10], 4,G);
%     F3 = imarray(4, 1,[10, 0], 4,G);
%     F4 = imarray(2, 2,[ 0, 0], 4,G);
%     F5 = imarray(2, 1,[30, 0], 2,G);  
%     F6 = imarray(1, 2,[0, 10], 2,G);
%     F7 = imarray(3, 3,[10,30], 8,G);
%
%   M function: cat
%   C function: imarray

    clc; close all; clear all;
    
% First of all, choose 4 images of the same rows arbitrary 
   g1 = imread('..\photo\rootalive.tif'); 
      [R,C,z] = size(g1);    % <---- [R,C,z] = [480, 640,3]
   g2 = imread('..\photo\nagwoosong.tif'); 
   g3 = imread('..\photo\sunset.jpg');  
   g4 = imread('..\photo\calmsea.jpg'); 
       [Ro,Co,z] = size(g4),  % <---- [Ro,Co,z] = [2736,  2736,3]
   g4 = g4(5*[1:480],5*[1:640],:); % Downsampling g4 to be same size 480x640x3
 chk = [size(g1), size(g2), size(g3), size(g4)]
    %  chk = 480  640   3  480  640   3  480  640   3  480  640   3
% (1) Let's take g3 as a test image. .    
%  (1a) Display g3 as 1x5 subimages on single figure with horizontal space 
%      width 32 (Hs=32).
      F1 = imarray(1, 5,[0, 10],5,g3 );
%  (1b) Display g3 as 1x5 subimages on single figure with horizontal space 
%      width 32 (Hs=32).
      w1 = 1:160;   w2 = 160 + w1;   w3 = 320 + w1;  
      ga = g3(w1,:,:);   gb = g3(w2,:,:);    gc = g3(w3,:,:);  
      Cat2image = cat(2,ga,gb,gc); 
      F2 = imarray(3, 3,[15, 15], 9, Cat2image );

figure(12);  imshow(F1); 
  title('\bfDisplay 5 subimages with Hs=32 spaces on the 1x5 grids')
figure(22);  imshow(F2); 
 title('\bf Display 9 subimages with Hv=Hs=10 spaces on the 3x3 grids,')


% (2) Discuss the following Fk. 
%   (Note-1): G = cat(2,g1,g2,g3,g4), of size Rx(4*C)x3 = 480x2560x3.
%   (Note-2): F = imarray(M,N,[Vs,Hs],K, G) consists of K subimages of 
%             same size  R x fix(4*C/K) x 3. And if K>4, so each image may
%             be divided. 
    G = cat(2, g1, g2, g3, g4);
    F1 = imarray(2, 2,[30,10], 4,G);
    F2 = imarray(1, 4,[0, 10], 4,G);
    F3 = imarray(4, 1,[10, 0], 4,G);
    F4 = imarray(2, 2,[ 0, 0], 4,G);
    F5 = imarray(2, 1,[30, 0], 2,G);  
    F6 = imarray(1, 2,[0, 10], 2,G);
    F7 = imarray(3, 3,[10,30], 8,G);
% The arrangements of Fk is noted within the title of each figure below.

figure(21); imshow(F1); title(['\bf2x2 grid-type arrangements of 4 images '...
    'with 30 vertical and 10 horizontal spaces between neighbours'])
figure(22);  imshow(F2); title(['\bf Horizontally arranged with ',...
      '10 spaces between neighbour images'])
figure(23);  imshow(F3); title('\bf Vertically arranged with 10 spaces ')
figure(24);  imshow(F4); title(['\bf2x2 grid-type arrangements of 4 images '...
    'without any space between neighbours'])
figure(25);  imshow(F5); title(['\bf2x1 grid-type arrangements of 4 images '...
    'with 30 vertical space only'])
figure(26);  imshow(F6); title(['\bf1x2 grid-type arrangements of 4 images '...
    'with 10 horizontal space only'])
figure(27);  imshow(F7); title('\bfOn 3x3 grid, 8 subimages with 10/30 spaces')

