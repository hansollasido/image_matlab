%pkg load image % for only octave

% sp01_intransform.m: Intensity transformation
%
% Let fi(m,n) and fo(m,n) denote the input image and the transformed output, 
% respectively. Assume that the intensities of both fi(m,n) and fo(m,n) are
% normalized as values between [0,1].
% Now let us take two intensity transformation examples.
%   1. Gamma transformation between a and b and zeroing the others
%       fo(m,n) = ( (fi(m,n)-a)/(b-a) )^gamma,  min(a,b)<=fi(m,n)<=max(a,b)
%               =        0,    elsewhere 
%    Special cases:
%      Linear mapping (gamma=1):            fo(m,n) = (fi(m,n)-a)/(b-a)
%      Negative mapping (gamma=1, a=1, b=0 ): fo(m,n) = 1-fi(m,n)  
%   2. Contrast stretching transformation
%        fo(m,n) = 1/(1 + (M/fi(m,n))^alpha )
%
% For a given image Lighthouse.tif, 
%   1. Find its gamma transformation for gamma = 2 and 0.5, respectively.
%   2. Find its negative transformation.
%   3. Expand its intensity between [0.1, 0.9] to the full range [0,1].
%   4. Find its contrast stretching transformations for M=0.5 and for two 
%      cases of alpha=2 and 6, respectively.
%  
%  M function: imread, imadjust, eval, cat, print, eps,legend
%  C function: imarray, imarrayp
%  Outputs:  sp01 ~ 10.eps
%  (Note): The M and C functions denote the source of m functions from 
%          the MathWorks, Inc. and this book, respectively.

    close all;  clc;  clear;
    
% Read given image Lighthouse.tif in the folder photo
  f = imread('Lighthouse.tif');
  [R,C,z] = size(f); [R,C,z], %  426   568     3
 figure(1); imshow(f); 
   title('\bfGiven image (Lighthouse.tif)');   
   
% Convert data class of f from uint8 to double (for correct operation) 
   f = im2double(f);   % Conversion of [0,255]  ---> [0,1]
% Intensity transform of f according to the given 6 kinds in problems 1~4.
% (Gamma transformations):
   g1=imadjust(f,[],[],2);       % darken (gamma=2>1)
   g2=imadjust(f,[],[],1/2);     % brighten (gamma=0.5<1)
   g3=imadjust(f,[0,1],[1,0]);   % negative (gamma=1,a=0, b=1)
   g4=imadjust(f,[.1,.9],[0,1]); % expand [.1,.9] to [0,1](gamma=1,a=.1,b=.9)
% (Contrast stretching transformations):
    M = 0.5;   alpha1 = 2;     alpha2 = 6;          
   g5=1./(1+(M./(f + eps)).^alpha1);       
   g6=1./(1+(M./(f + eps)).^alpha2);       
     % (Note): The use of 'eps' is to prevent 1/0 for 1/x when x=0. 
% Concatenate transformed images (to display all together)
   G123 = imarray(2,2,[15,15],4, cat(2,f,g1,g2,g3) );
   G456 = imarray(2,2,[15,15],4, cat(2,f,g4,g5,g6) ); 
% Naming the intensity transformed data   
   tf = {'g1','g2','g3','g4','g5','g6','G123', 'G456'};
% Strings
   s1 = {' \gamma = 2',',', ' negative',',', ' \gamma = 0.5',','};
   s2 = {' map [.1~.9] to [0~1]',',',' (\alpha,M) = (6,0.5)',',',...
       ' (\alpha,M) = (2,0.5)'};
   st = [s1,s2];
% Corresponding 6 intensity mapping functions
    x = 0:0.01:1;
    y = zeros(6, length(x)); 
    y(1,:) = x.^2;
    y(2,:) = x.^(1/2);
    y(3,:) = 1-x; 
    y(4,:) = [zeros(1,10), 1.25*(x(11:91)-0.1), ones(1,10)];  
    y(5,:) = (1+ (0.5./(x+eps)).^alpha1).^(-1);
    y(6,:) = (1+ (0.5./(x+eps)).^alpha2).^(-1);
% Mapping names for titles 
  map = {'Gamma transformation with \gamma = 2 (darken)',
         'Gamma transformation with \gamma = 0.5 (brighten)',
         'Negative transformation with \gamma = 1, a=0, and b=1',
         'Linear mapping of [0.1 ~ 0.9] to [0 ~ 1]',
         'Contrast stretching with M = 0.5 and \alpha = 2',
         'Contrast stretching with M = 0.5 and \alpha = 6'};
     
% Display the transformed images and the transformation functions    
  col ={'k','k','w','k','k','k'};
 for k = 1:6  
    g = eval(tf{k}); 
    c1=455;    r1=11; 
    figure(k+1); imshow(g); title(['\bf' map{k} ]);
    hold on; plot(c1+[0:100],(r1+100)-100*y(k,:), col{k});  % Top down  
    hold on; plot(c1+[0,100,100,0,0], r1+[100,100,0,0,100],'y'); % Rim
   
    if (k==3)|(k==6)
         km = k-3;    kq = k/3;
         G = eval(tf{6+kq});
         figure(7+kq); imshow(G); 
         title(['\bf Clockwise from the top left, '... 
         'given image,' st{6*(kq-1)+[1:5]} ]);
        for i = 2:4
           [r,c]=imarrayp(2,2, [10,10], i,[R,C], [r1,c1]);  % top left corner 
           hold on; plot(c+[0:100], (r+100)-100*y((km+i-1),:), col{km+i-1}); 
           hold on; plot(c+[0,100,100,0,0], r+[100,100,0,0,100],'y'); 
        end
     
    end 
 end
 
% Plot the whole input-output transformation functions 
%   colr = {'c','c:','r:','r','b','b:'};
% figure(10);
% for m = 1:6
%   plot(x,y(m,:),colr{m},'linewidth',1.5); axis([0,1,0,1.1]); hold on;
% end
%   title('\bfIntensity mapping functions');  
%   xlabel('\bf x:  The input image intensity'); 
%   ylabel('\bf y:  The transformed intensity');
%   legend([st{1}],[st{5}],[st{3}],[st{7}],[st{11}],[st{9}],'Location','N'); legend boxoff;   
 

