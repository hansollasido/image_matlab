% test_imarrayp.m: Test of imarrayp.m with imarray.m 
%
% Let us learn the use of <imarrayp.m> with the following examples.
% (Ex-1): Find the top left corner point (R1,C1) of 8th subimage of size 
%       100x150 when 12 subimages are arranged in the form of 4x3 with
%       vertical and horizontal spaces 20 and 15, respectively. 
%
% (Ex-2): Display 6 images in 3x2 subblocks scheme: 
%     -  With vertical and horizontal spacing intervals between subimages 
%        10 and 50, respectively. 
%     -  Write down the title of each image at (150, 520) of each subimage
%        plane, where 150 and 520 denote the column and row coordinates, 
%        respectively.
%
%   M function: imerode, cat, strcat
%   C function: imarrayp, imarray, circse,

    clc; close all; clear all;
% ---------------------------------------------------------------
% (Ex-1): Find the top left corner point (R1,C1) of 8th subimage of size 
%       100x150 when 12 subimages are arranged in the form of 4x3 with
%       vertical and horizontal spaces 20 and 15, respectively. 
    Space = [20,15];  
    Size = [100,150];
    [R1,C1] = imarrayp(4,3,Space,8, Size); 
    chk = [R1,C1]  % chk = 240   165
% (Comment): The 8th subimage is located in the same order as 'subplot' 
%  usage in the Matlab as follows.
%        1     2     3
%        4     5     6
%        7    (8)    9
%       10    11    12  
% Thus R1 = 2*(100+20) and C1 = 150+15.
% ---------------------------------------------------------------
% (Ex-2): Display 6 images in 3x2 subblocks scheme: 
%     -  With vertical and horizontal spacing intervals between subimages 
%        10 and 50, respectively. 
%     -  Write down the title of each image at (150, 520) of each subimage
%        plane, where 150 and 520 denote the column and row coordinates, 
%        respectively.

    f = im2double(imread('..\photo\bgasample.jpg')); 
    [M,N,z] = size(f),  % 570 760 3 
    f = f(:,:,1)<0.6;   % Threshold by 0.6
    
% 6 example images: 
% Erode f with CSEs(circle structuring elements) of radii 10,20,30,40,50.    
    C = f;
for k = 2:6
    fo = imerode(f,circse(10*k));  %  circle structuring element (CSE)
    C = cat(2,C,fo);
end
   F = imarray(3,2, [10,50], 6,C);  % Vertical/horizontal spaces 10/50
   
% Entitle each images:
   ti = {'Given image'},
   for k = 1:5
   tk =  ['imerode(f, circse(' int2str(10*k) '))']; 
   ti = strcat([ti,  {tk}])
   end
   
figure; imshow(F);
title('\bf Test of the C functions both <imarrayp.m> and <imarray.m>');
 for k=1:6
   [r, c] = imarrayp(3,2, [10,10], k,[M,N],[520,150]); 
           % (r,c) = (150,520) = (column, row) of each image 
   text(c,r, ti{k},'color','c' )
 end
