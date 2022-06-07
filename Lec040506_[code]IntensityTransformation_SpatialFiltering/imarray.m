 function F = imarray(M,N, Space, K, Cat2image)
% F = IMARRAY(M,N,Space, K, Cat2image) returns an arrangement of the same 
%   K subimages of the given image Cat2image on the MxN subimage planes
%   with the vertical and horizontal spaces (Vs, Hs) between neighbor 
%   subimages in the same order as 'subplot' usage in the Matlab.
% Cat2image is an image or a concatenated image set such as
%    Cat2image = X1
%    Cat2image = cat(2, X1, X2,...,XK)
%  Of course, Xk have the same number of row for all k to be able to 
%  concatenate Xk with the use of cat(2, ...).
% Space denotes the vertical and horizontal spaces and their gray level.
%   For example,  
%            Space = [Vs, Hs, g] 
%   denotes spaces of Vs-pixels vertically and Hs-pixels horizontally 
%   between neighbour images with gray level g (0<=g<=1). By default, 
%   the gray level g is 0.8, i.e.,
%        Space = [10,15] is identical to Space = [10,15,0.8].
% The resultant F consists of normalized intensities by [0,1]. 
% -----------------------------------------------------------------
 Ls = length(Space);
 if Ls == 2
    g = 0.8; 
 elseif Ls == 3
    g = Space(3); 
 else
    error('The length of Space is not equal to 2 or 3')
 end
  Vs = Space(1); Hs = Space(2);  
  [R,C2,z] = size(Cat2image);
  C = fix(C2/K);        % <--- To prevent the case of fractional C2/K
  Ro = R*M + Vs*(M-1);  % The whole image size (RoxCo) including spaces 
  Co = C*N + Hs*(N-1);
  F = g*ones(Ro,Co,z);  % Initially, F looks like background gray
  order = repmat(N*[0:M-1]',1,N) + repmat(1:N,M,1);
 for k = 1:K,
  [mo,no] = find(order==k);  % Position of the k-th image
  row = (mo-1)*(R+Vs) + [1:R]; 
  column = (no-1)*(C+Hs) + [1:C];
  Xk = Cat2image(:, (k-1)*C+[1:C],:); 
  Xk = mat2gray(Xk);         % All images are normalized to [0,1]  
  F(row,column,1:z) = Xk;  
 end
%  ---->  See (test_imarray.m) to readily apprehend the above function.
%  --------------------------------------------------------------------
% (Additional example): 
%  Let Xk be uint8 images of same size 300x400x3for k=1,2...,5.
%      Cat2image = cat(2,X1,X2,X3,X4,X5)                        
%      F = imarray(3,2, [10,50,0.7], Cat2image)
%  Then imshow(F) displays 5 images in single figure of size 920x850x3 
%  in order as follows.
%       X1    X2  
%       X3    X4 
%       X5
% Of course, between images, there are spaces of gray level 0.7 with 
% 10 pixels vertically and 50 pixels horizontally.
 
