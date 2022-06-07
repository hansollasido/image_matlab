%pkg load image % for only octave

% sp06_median: Median filtering 
%
%  In the linear filters such as Gaussian, Laplacian, etc., the filtering 
%  is the convolution operation. That is a sliding operation, pixel by pixel.
%  Instead, nonlinear filtering is not convolution but widely used in 
%  the machine vision. The morphological operations (dilation and erosion) 
%  and median filter are belonging to the nonlinear operations. These are 
%  special cases of the rank order filter, i.e., taking the first-rank 
% (maximum), the last (minimum), and the median value among pixels within 
% a given window, respectively.
% The median filter is very effective in reduction of black and white noise
% or salt and pepper noise. For example, when f is given by
%               f = [0 0 0 1 0;
%                    0 0 1 0 0;
%                    0 1 0 0 0] 
% When used 3x3 window, the median value of f at (2,3) is 0 since the 5th 
% rank of 9 pixels within the window centered at (2,3) is 0.(There are 6 0s 
% and 3 1s).
% The following example shows the salt and pepper noise reduction by
% median filter.
% For an image saltpepper.tif corrupted by salt and pepper noise about 8%, 
%   1. Compute the median filtering with 3x3 and 5x5 windows, respectively.
%   2. Compare the numbers of salt and pepper noise of given image and two
%      kinds of median filtering results above.
%
%  M function:  medfilt2, sum, numel, length
%     Outputs:  sp42~44.eps
%

   close all; clc;  clear;
    
 %  Read salt and pepper noisy image (saltpepper.jpg) with 8% density.
    f = imread('saltpepper.jpg');  size(f)  %   1704  2272 
  figure(1); imshow(f); 
   title('\bfGiven image corrupted by 8(%) salt and pepper noise');
 
 % The numbers of salt and peppers in f    
     Nsp = [length(find (f==255)), length(find (f==0))]  
 % Salt and pepper noise reduction by median filtering:
  for k=1:2
  if k==1        % median filtering using 3x3 window
    g = medfilt2(f,'symmetric');    win ='3x3';    
  else           % median filtering using 5x5 window
    g = medfilt2(f,[5,5], 'symmetric');  win ='5x5';   
  end
    Nk = [length(find (g==255)), length(find (g==0))];
    Nkp = 100*sum(Nk)/2/numel(f),
    Nsp = [Nsp; Nk]; 
  figure(k+1),imshow(g); 
   title(['\bfMedian filtering using ' win ' window ' num2str(Nkp) '(%)',...
    ' salt and pepper noise'] ); 
  end
  Nsp,  percent = 100*Nsp/numel(f),
    %  Nsp  =  305443      307938          percent = 7.8896    7.9540
    %             603         645                    0.0156    0.0167
    %               0           0                         0         0
% (Note) medfilt2(f,[M,N],'symmetric') performs median filtering of f
%  in 2D with symmetrical extended background outside the border of f.