%pkg load image % for only octave

% sp03_boundaryoption: Border effects in image filtering
%
%  As we know, the convolution c(m,n) = g(m,n)*w(m,n) yields larger size than
%  both g and w. Let g and w be of sizes gm x gn and wm x wn, then the size
%  of c(m,n) becomes (gm+wm-1) by (gn+wn-1).
%  We often encounter two problems in filtering process how to deal with
%  the background outside the bound of the image and the size increasing.
%  (1) The background of an image (only for one of the largest size of g 
%      and w) is virtually specified before filtering in several ways:
%      - Pad zeros, 
%      - Reflect the array across the array border,
%      - Replicate the nearest array border value,
%      - Arrange the image periodically like as circularly shifted.
% 
%  (2) The size of convolution result may be taken by the increased size 
%      or the same size as the largest size of g and w.
%      (See the Matlab function 'imfilter')  
% 
%  For given g and w as
%     g =  1  2  3  4  5
%          2  3  4  5  6
%          3  4  5  6  7
%          4  5  6  7  8
%     w =  1  1  1
%          1  1  1
%          1  1  1
%
%  1. Append zeros to the border outside the input g by 2 zeros, i.e., the
%     zero padded gz is of size 8 x 9 and then write down gz and compute 
%     the convolution sum of gz and w.
%  2. Replicate the border outside the input g by 2 pixels with its nearest
%     border value, i.e., the replicated grp is of the same size as gz and
%     then write down grp and compute the convolution sum of grp and w.
%  3. Show the extended boundaries of g symmetrically and circularly by 2 pixels. 
%  4. For a given binary image threedisks.bmp, show the padding its boundary
%     by 4 options zeros, symmetric, replicate, and circular in the Matlab 
%     function 'paddarray'.
%
%  M function: imfilter, padarray,
%  C function: imarray, imarrayp, blanking
%      Output: sp25.eps

    close all; clear all;  clc;
    
% Consider the filtering of g(m,n) with w(m,n)  
% (a) Set g(m,n) of size 4 by 5 as
   g = [1 2 3 4 5; 14 15 16 17 6; 13 20 19 18 7; 12 11 10 9 8],  % Try one!
   g = [1 2 3 4 5; 2 3 4 5 6; 3 4 5 6 7; 4 5 6 7 8],    % size (4,5)
% (b) Set w(m,n) of size 3 by 3 as   
   w = ones(3),   
      %  w = 1  1  1
      %      1  1  1
      %      1  1  1 
%  Then, the convolution of c(m,n) = g(m,n)*w(m,n) is of size 6 by 7.
%
% (1) Append zeros to the border outside the input g by 2 zeros, i.e.,
%     the zero padded gz is of size 8 x 9 and then write down gz and 
%     compute the convolution sum of gz and w.
% The following gz is the 2 zero padded g around the border outside g. 
    N = 2;  
    gz = padarray(g, [N,N]);  blanking(gz,2)
     % gz =  0  0  0  0  0  0  0  0  0  
     %       0  0  0  0  0  0  0  0  0  
     %       0  0  1  2  3  4  5  0  0  
     %       0  0  2  3  4  5  6  0  0  
     %       0  0  3  4  5  6  7  0  0  
     %       0  0  4  5  6  7  8  0  0  
     %       0  0  0  0  0  0  0  0  0  
     %       0  0  0  0  0  0  0  0  0
 % Filtering (convolution sum of g  and w)    
   cz = imfilter(g, w,'full');  % Mathematically (4,5)*(3,3) = (6,7)
   czcr = imfilter(g, w);       % Cropped cz  to be size (4,5)
    blanking(cz,2), blanking(czcr,2)
     %  cz =  1   3   6   9  12   9   5  
     %        3   8  15  21  27  20  11  
     %        6  15  27  36  45  33  18  
     %        9  21  36  45  54  39  21  
     %        7  16  27  33  39  28  15  
     %        4   9  15  18  21  15   8  
     % czcr =     8  15  21  27  20  
     %           15  27  36  45  33  
     %           21  36  45  54  39  
     %           16  27  33  39  28  
 % (Note): The above 'cz' is obtained by convolving w with gz in the range 
 %  of whole w are included in g and thus cz is identical to the mathematical 
 %  convolution of g and w,i.e., cz = g*w. 
 %  Moreover, the 'czcr' is identical to the cropped  'cz' of the same 
 %  size as g, i.e., czcr = cz(2:end-1, 2:end-1).

% (2) Replicate the border outside the input g  by 2 pixels with its nearest
%    border value, i.e., the replicated grp is of the same size  as gz and 
%    then write down grp and compute the convolution sum of grp and w.
% The following 'grp' is replicated g around the border outside g by 2 pixels. 
% And the filtering result 'crp' is the mathematical convolution of 'grp' 
% and w and 'crpcr' is the cropped 'crp' of the same size as g, i.e., 
%       crp = grp*w
%       crpcr = crp(2:end-1,2:end-1)
    grp = padarray(g, [N,N],'replicate');
    crp = imfilter(g, w, 'replicate', 'full');
    crpcr = imfilter(g, w, 'replicate');
      blanking(grp,3),     blanking(crp,2),     blanking(crpcr,2)
    % grp = 1   1   1   2   3   4   5   5   5   
    %       1   1   1   2   3   4   5   5   5   
    %       1   1   1   2   3   4   5   5   5   
    %       2   2   2   3   4   5   6   6   6   
    %       3   3   3   4   5   6   7   7   7   
    %       4   4   4   5   6   7   8   8   8   
    %       4   4   4   5   6   7   8   8   8   
    %       4   4   4   5   6   7   8   8   8   
    %  crp =    9  12  18  27  36  42  45  
    %          12  15  21  30  39  45  48  
    %          18  21  27  36  45  51  54  
    %          27  30  36  45  54  60  63  
    %          33  36  42  51  60  66  69  
    %          36  39  45  54  63  69  72  
    %  crpcr =     15  21  30  39  45  
    %              21  27  36  45  51  
    %              30  36  45  54  60  
    %              36  42  51  60  66  
  % (Note): Comparing (1) and (2), czcr and crpcr are different but their
  %        middle region  [27 36 45; 36  45  54] is the same since it is
  %        unaffected by the background components.
  
% (3) Show the extended boundaries of g by symmetrically and circularly by 2 pixels. 
   gsym = padarray(g, [N,N],'symmetric');
   gcirc = padarray(g, [N,N],'circular');
   blanking(gsym,3), blanking(gcirc,3),
    % gsym =  3   2   2   3   4   5   6   6   5   
    %         2   1   1   2   3   4   5   5   4   
    %         2   1   1   2   3   4   5   5   4   
    %         3   2   2   3   4   5   6   6   5   
    %         4   3   3   4   5   6   7   7   6   
    %         5   4   4   5   6   7   8   8   7   
    %         5   4   4   5   6   7   8   8   7   
    %         4   3   3   4   5   6   7   7   6   
    %
    % gcirc = 6   7   3   4   5   6   7   3   4   
    %         7   8   4   5   6   7   8   4   5   
    %         4   5   1   2   3   4   5   1   2   
    %         5   6   2   3   4   5   6   2   3   
    %         6   7   3   4   5   6   7   3   4   
    %         7   8   4   5   6   7   8   4   5   
    %         4   5   1   2   3   4   5   1   2   
    %         5   6   2   3   4   5   6   2   3 

% (4) For a given binary image threedisks.bmp, show the padding its boundary
%     by 4 options zeros, symmetric, replicate, and circular in the Matlab 
%     function 'paddarray'.
  f = im2double(imread('threedisks.bmp')); 
    [X,Y] = size(f);    % 200x170
 % Background extensions according to boundary options 
  yrep = padarray(f, [10,10],'replicate');  % Replicate
  ysym = padarray(f, [10,10],'symmetric');  % Symmetric
  ycir = padarray(f, [10,10],'circular');   % Circular
    yz = padarray(f, [10,10]);              % zero padding
 % Display 4 background extensions 
   Q4 =  imarray(2,2,[25,25,0.6],4, [yz,yrep,ycir,ysym]);
     chk = size(Q4) % 455x 395
   st = {'Zero padding','Replicate','Circular', 'Symmetric'};
figure(1); 
imshow(Q4,[-1,1]); 
hold on;
 title('\bfBackground sahpes according to boundary options');  
 for k = 1:4,
   [Ro,Co] = imarrayp(2,2, [25,25], k, 20+[X,Y], [11,11]) 
   %[Ro,Co] = imarrayp(2,2, [0,0], k, 20+[X,Y], [11,11]) 
   plot(Co+[0,Y,Y,0,0], Ro+[0,0,X,X,0],'b:') ; hold on;
   text( Co+55,Ro+X+17, ['\bf' st{k}]) 
 end

 % (Note): The background effects can be seen from figure(1):
 %    (2nd image), replicated rectangle shape in the right background
 %    (3rd image), circularly shifted rhombus shape in the left background
 %    (4th image), symmetrically reflected rhombus shape in the right background


