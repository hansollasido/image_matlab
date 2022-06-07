%pkg load image % for only octave

% sp05_laplacian: Laplacian Filtering 
%
% The impulse response h_a of a Laplacian filter is given by
%      h_a =  1/(1+a)*[ a    1-a    a 
%                      1-a,  -4,   1-a
%                       a    1-a    a ]
%  For example,  h_0 = [0   1   0 
%                       1  -4   1 
%                       0   1   0 ]  
%   and      
%               h_1/2 = (1/3)*[1   1   1   
%                              1  -8   1  
%                              1   1   1]
% Here we show a Laplacian filtering as a high pass filtering example. 
% A. For a given gray image f (ice.jpg),
%   1. Let g be the Laplacian filtering of f with h_0. And let fs=f-0.3g
%     and fb=f+0.3g. Then plot the 520th lines f, g, fs, fb at intervals
%     from 100 to 200. 
%   2. Display 4 images of f, g, fs, and fb together.
% B. For a color image f (yulan.tif and kdoor.tif)
%   3. Find the Laplacian filtering g of f with h_0 and display f,g, f-0.5g,
%      and f+0.5g together.
%
%  M function: imfilter, fspecial, mat2gray
%  C function: imarray, imarrayp, g2c
%     Outputs: sp30 ~ 35.eps

   close all; clear; clc;

% (1) Let g be the Laplacian filtering of f with h_0. And let fs=f-0.3g
%     and fb=f+0.3g. Then plot the 520th lines f, g, fs, fb at intervals
%     from 100 to 200. 
   f =im2double(imread('ice.jpg'));  
     [R,C] = size(f),  %  [531  675]
figure(1);  imshow(f); title('Given image');   
%  Laplacian filter h0
   h0 = fspecial('laplacian', 0),   
      %   h0 =  0   1   0 
      %         1  -4   1 
      %         0   1   0
% Laplacian filtering by h0  
   g = imfilter(f,h0,'replicate');  
   fs = f-0.3*g;
   fb = f+0.3*g;
% Analyze the 520th lines from 100 to 200 samples 
   line = 520;  
   w = 100:200;   
   n=0:100;  it  ={'a', 'b'};
figure(2); plot(n, f(line,w),'b.-', n, g(line,w),'r.-');
  text(55,0.67,'f(520,100:200)','color','r');  
  text(55,0.12,'g(520,100:200)','color','b'); axis off;
  title(['\bf(' it{1} ') 520th lines of f and its Laplacian g']);
 
figure(3); plot(n, fs(line,w),'b.-',n, fb(line,w)-0.4,'r.-')  
  text(65,0.67,'fs(520,100:200)','color','r');  
  text(65,0.28,'fb(520,100:200)','color','b');
  text(20,0.7,'Sharpened','color','r');  
  text(20,-0.04,'Blurred','color','b'); axis off;
  title(['\bf(' it{2} ') 520th lines of fs = f - 0.3g and fb = f + 0.3g']);
  
    
% (2) Display 4 images of f, g, fs, and fb together.
  im4 =  imarray(2,2,[20,20],4,[f,g,fs,fb]);
figure(4), imshow(im4);
 title('\bfEnsemble image display: f,g,fs=f-0.3g,and fb=f+0.3g') ; 
st ={'Given image f','Laplacian g','fs=f-0.3g: Sharpened',['fb=f+0.3g: ',...
    'Blurred']}
 for k = 1:4,
   [ro,co] = imarrayp(2,2, [20,20], k, [R,C], [20,20]); 
    text(co,ro, ['\bf' st{k}],'color','b') 
 end    

 
% For a color image f (yulan.tif and kdoor.tif),
% (3) Find the Laplacian filtering g of f with h_0 and display f,g, f-0.5g,
%      and f+0.5g together.
 ph = {'yulan.tif','kdoor.tif'};
for im =1:2
  f = im2double(imread([ ph{im} ]));  
  [X,Y,z] = size(f),   % [500 800 3], [480 640 3] for yulan,tif/kdoor.tif
% (1) Find the Laplacian filtering g of f with h_0, 
   g = imfilter(f, h0, 'replicate'); 
   gn = mat2gray(g);  
   % For the display purpose, convert [min, max] of g to [0,1] 
% Subtraction/addition for image sharpening
    fs = f-0.5*g;
    fb = f+0.5*g;
% Display ensemble    
   w = 20;  v = g2c(ones(X,w)); h = g2c(ones(w,2*Y+w));
   FG = [f,v, gn; h; fs,v, fb];   it  ={'a', 'b'};
 figure(4+im); imshow(FG);   text(w/2,X-w,'\bf  f','color','w');
   text(Y+3*w/2,X-w,'\bfg: Laplacian filtered f','color','w');
   text(w/2,2*X,'\bf f-0.5g','color','w');
   text(Y+3*w/2,2*X,'\bf f+0.5g','color','w');
   text(Y/2-6*w,2*(X+w),'\bf Sharpened','color','b'); 
   text(3/2*Y-4*w,2*(X+w),'\bf Blurred','color','b');
   title(['\bf(' it{im} ') Laplacian filtering results f, g, f+0.5g, ',...
       'and f-0.5g, clockwise from top left']);
 
end
% (Comment): With a proper choice of a positive alpha (when h0(2,2)=-4 <0),
%     f - alpha*g enhances f with sharpening,
%     while f + alpha*g blurs f.
