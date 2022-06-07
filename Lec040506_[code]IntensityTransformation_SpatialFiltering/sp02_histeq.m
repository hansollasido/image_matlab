%pkg load image % for only octave

% sp02_histeq: Histogram representation and histogram equalization
%
% The histogram of an image is the distribution of the number of pixels 
% for each intensity level. If we divide the histogram by the total number 
% of pixels, such normalized histogram becomes a probability density 
% function of unity area. 
% The histogram gives us useful information such as local and/or global 
% intensity distribution, modality of distribution, the optimum threshold 
% level, etc.
% When the histogram is distributed nearly in part of the whole intensity 
% range, the histogram can be broaden more uniformly throughout the whole 
% intensity range. Such operation is called the histogram equalization.
% In the probabilistic view, if the cdf (cumulative distribution function)
% of a variable X is linear, the pdf (probability density function) of X 
% becomes constant, i,e., X has a uniform pdf. 
% For simplicity, let a(x) and b(y) denote the pdfs of X and Y, respectively.
% Assume Y be a function of X, i.e., Y = f(X). Then the pdf of Y is given
% by
%           b(y) = |dx/dy| a(x) with x= f^(-1)(y)
% If the transformation function is the running integral such as
%           y = int^x a(x')dx'
% Then |dy/dx| = a(x). Thus the pdf of Y is constant (uniform).
% Similarly, the above concept can be expanded to the discrete case [1,2].
% The following example shows the histogram equalization.
%
% [1] Scott E Umbaugh, Computer Imaging: Digital Image Analysis and processing, .
%   CRC Press, 2005
% [2] Digital Image processing, R.C. Gonzalez and R.E. Woods, Addison-Wesley,
%     1993.

% For a given histogram H[n] with n = 0:10,
%     H = [2,9,32,25,17,8,0,3,1,2,1]
% 
%   1. Generate an 1D or a 2D image having its histogram equal to H above
%      and verify its histogram is equal to H.
%   2. With the use of the M function 'histeq' and the C function 'heq',
%      compute the histogram equalized image and its histogram.
%   3. Compute the histogram equalization directly.
%   4. Plot the gray level transformation function between the gray levels
%      of the original image and the histogram equalized image, and
%      these two histograms, and display two images before and after
%      histogram equalized.
%
%  M function: imhist, histeq, sum, cumsum, unique, length, find, int2str,
%              strvcat, reshape, imresize,round, zeros, stem, plot, scatter,
%  C function:  histim, heq, floatstem, imarray
%     Outputs:  sp11 ~ 13.eps

    close all;  clear all;  clc; 

% Given histogram H[n] with n = 0:10
  H = [2,9,32,25,17,8,0,3,1,2,1], 
  N = sum(H);
  BIN = length(H); 
  L = BIN - 1;      chk1 = [BIN,L,N],     %  chk1 = [11  10  100]

% (1) Generate an 1D image or a 2D image having its histogram equal to H
%    above and verify its histogram is equal to H.
   g = histim(H);         % Normalized 1D image between [0:1/L:1]
     Ho = imhist(g,BIN)';  
   g = reshape(g,10,10);  % Reshaping 1D g as 2D image of size 10x10
     Hoo = imhist(g,BIN)';     
     
     chk2 =[ isequal(H,Ho), isequal(Ho,Hoo)],%  chk2 = [1  1] (H=Ho=Hoo)

% (2) With the use of the M function 'histeq' and the C function 'heq',
%      compute the histogram equalized image and its histogram.
% Histogram equalization of g  
% (1) Use of histeq.m 
  g1 = histeq(g)';
  H1 = imhist(g1,BIN)'; 
  
  % (1) Use of histeq.m 
  g1 = histeq(g)';
  H1 = imhist(g1,BIN)'; 
% (2) Use of heq.m 
  [g2,H2,Hoo] = heq(g,BIN,[0,L]);
  H2 = imhist(g2,BIN)';  
  chk3 = isequal(H1,H2),     % chk3 = 0  (H1~=H2, g1~=g2)
  chk31 = isequal(H,Hoo),    % chk31 = 1  (H=Ho=Hoo)
  chk4 = [H; H1; H2],
   %  H     2     9    32    25    17     8     0     3     1     2     1
   % H1     2     9     0    32     0     0    25     0    17     8     7
   % H2     2     9     0     0    32     0     0    25     0    25     7
   %  -----> (H1 and H2 are not identical but similarly distributed)
   
% (2) Compute the histogram equalization directly.
%
%  (step-1): Find the cdf C of H 
% => Compute Transformation function using cdf
   C = cumsum(H);  
%  (step-2): Round the values of histogram equalized, vo = L*C/N
   BIN = length(C);  L= BIN-1;  N = C(end); 
   vo = L*C/N;  % L: max intensity, C : current value, N: number of pixels
   v = round(vo);  % round(C/10)
  chk5 = [H; C; v]
  %  H     2     9    32    25    17     8     0     3     1     2     1
  %  C     2    11    43    68    85    93    93    96    97    99   100
  %  v     0     1     4     7     9     9     9    10    10    10    10
  
%  (step-3) Find the histogram equalized image ge and its histogram H3
% => Apply the transformation function for histo equalization
    ge = g;  
    H3 = zeros(1,BIN);
  for k = 0:L
      ge(find((g== k/L))) = v(k+1)/L,  
    if find(v==k)
      H3(k+1) = sum(H(find(v==k))),
    end 
  end
  ge,  H3,   H3o = imhist(ge, BIN)';  
 chk6 = [ isequal(H2,H3), isequal(H3,H3o)],  % chk6 = [1  1] (H2=H3=H3o)
% --------------------------------------------------------------------- 
% (4) Plot the gray level transformation function v=LC/N between the gray 
%     levels of the original image and the histogram equalized image, and
%     these two histograms, and display two images before and after
%     histogram equalized.
  [B,I,J] = unique(v),
  colr = {'c:','c:','c:' 'c:','r:','b:'};
figure(1);  
stem(0:10,vo); 
axis([-1.5,11,-1,11]); 
hold on;
  %scatter(7:10,vo(8:11), 'bo','filled');
  scatter(7:10,vo(8:11), 'filled');
  axis([-1.5,11,-1,11]); hold on;
  
  %scatter(4:6,vo(5:7),'ro','filled');  
  scatter(4:6,vo(5:7),'filled');  
  
  %scatter(0:3,vo(1:4),'co','filled'); 
  scatter(0:3,vo(1:4),'filled'); 
  
  plot([-1,-1],[-0.5,11]); hold on; 
  
  %stem(7:10,vo(8:11), 'bo','filled');
  stem(7:10,vo(8:11));
  
  title('\bf Transformation function round(LC/N): L=10, N=100');
  text(1,10.5,'Gray levels 7,8,9,10 are transformed to 10','color','b');
  text(2,-0.9, '\bfGray level of the original image');
  text(-2,2.5,'\bfHistogram equalized value','Rotation', 90);
for k=0:L
    plot([k,-1],[vo(k+1), v(k+1)], colr{J(k+1)}); hold on;
    text(k+.2,vo(k+1), [ sprintf('%0.1f',vo(k+1))])
    text(-1.1,k, ['\bullet']);  text(-1.6,k, [ int2str(k)])
    text(k-0.1,-0.3, [int2str(k) ]); axis off
end
 
% Histograms before and after histogram equalization
  bias = 45;
figure(2);  
 floatstem(0:10,H,bias, 'o','o','o','filled','b'); 
 %floatstem(0:10,H,bias); 
 axis([-1,11,0,85]);
 floatstem(0:10,H2, 0, 'o', 'o', '.', 'filled','k'); 
 %floatstem(0:10,H2, 0); 
 hold on; 
 plot([-1,11],[0,0]); 
 hold on; 
 plot([-1,11],bias*[1,1]); 
 axis off;
 text(-0.5,bias+30, [ strvcat('H[n]', 'Original')],'color','b'); 
 text(-0.5,30, [ strvcat('H2[n]', 'Histogram equalized')]);
 text(10.9,0, '>  n'); text(10.9,bias, '>  n');
 title('\bf Histograms before and after histogram equalization') 
 for k=0:L
 text(k-0.1,-3, [ int2str(k)]); text(k-0.1,bias -3, [ int2str(k)]);
if H(k+1)~=0
  text(k-0.1,bias + H(k+1)+3, [ int2str( H(k+1)) ], 'color','b');
end
if H2(k+1)~=0
  text(k-0.1,H2(k+1)+3, [ int2str(H2(k+1)) ]);
end  
 end
  
   
% Images before and after histogram equalization
  g = imresize(g, [300,300],'nearest');
  ge = imresize(ge, [300,300],'nearest');
  Q2 = imarray(1,2,[10,35],2,[g,ge]);
figure(3); imshow(Q2,[-0.2,1]); text(20,322, '\bf An image of H'); 
  text(355,322, '\bf Histogram equalized image');  % impixelinfo;
  title('\bf An equivalent image of H and its histogram equalized image');
    
     
 %  (Results) ---------------------------------------------------------
 %          Original g                             Histogram equalized ge
 %      2 pixels of gray level 0        ----------->  gray level 0
 %      9 pixels of gray level 1        ----------->  gray level 1 
 %      32 pixels of gray level 2       ----------->  gray level 4
 %      25 pixels of gray level 3       ----------->  gray level 7
 %      25 pixels of gray level 4,5,6   ----------->  gray level 9
 %       7 pixels of gray level7,8,9,10 ----------->  gray level 10
 
