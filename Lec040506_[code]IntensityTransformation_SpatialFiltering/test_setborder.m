% text_setborder.m: Test of setborder.m
%
% Let us learn the use of <setborder.m> with the following examples.
%
% A binary image B is given by
%  B = 0     0     0     0     0     0     0     0     0
%      0     0     1     1     1     1     1     1     1
%      0     0     1     1     1     1     1     1     1
%      0     0     1     1     1     1     1     1     1
%      0     0     1     1     1     1     1     1     1
%      0     0     1     1     1     1     1     1     1
% 
% Now we want to erode B by 1 pixels from every direction (left, right, top, 
% and bottom). 
% Let Bw be the wanted such eroded B as  
% Bw = 0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0
%      0     0     0     1     1     1     1     1     0
%      0     0     0     1     1     1     1     1     0
%      0     0     0     1     1     1     1     1     0
%      0     0     0     0     0     0     0     0     0
%
% Find a method to obtain Bw from B.
%
%  M function: zeros, ones, strel, imerode, padarray, imcrop
%  C function: setborder

%  Given binary set B 
      B = zeros(6,9); 
      B(2:end,3:end) = 1,  
% (Approach 1): Morphological erosion of B with 3x3 square SE
     se = strel('square', 3);  % Or, se = ones(3)
     Be = imerode(B,se),
% Be = 0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0
%      0     0     0     1     1     1     1     1     1
%      0     0     0     1     1     1     1     1     1
%      0     0     0     1     1     1     1     1     1
%      0     0     0     1     1     1     1     1     1
% (Comment 1):
% It can be seen that the bottom right sides of B connected to the boundary
% are not eroded in Be since all the elements of background are assumed to
% be the highest level 1 for the erosion operation so that the bottom right
% boundary of B is unaffected by the erosion. 
%
% (Approach 2), Use of the C function setborder.m
     Bz = setborder(B,0)
     B2 = imerode(Bz,se),
% Bz = 0     0     0     0     0     0     0     0     0
%      0     0     1     1     1     1     1     1     0
%      0     0     1     1     1     1     1     1     0
%      0     0     1     1     1     1     1     1     0
%      0     0     1     1     1     1     1     1     0
%      0     0     0     0     0     0     0     0     0
%
% Bze= 0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0
%      0     0     0     1     1     1     1     0     0
%      0     0     0     1     1     1     1     0     0
%      0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0
% (Comment 2): Bze is not equal to the wanted Bw
%
% (Approach 3)  Pad zeros to the background  
   Bp = padarray(B,[1, 1]), 
   Bpe = imerode(Bp,se),
   Bpecrop = imcrop(Bpe,[2,2,8,5]), % Crop Bpe to be the same size of B
% Bp = 0     0     0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0     0     0
%      0     0     0     1     1     1     1     1     1     1     0
%      0     0     0     1     1     1     1     1     1     1     0
%      0     0     0     1     1     1     1     1     1     1     0
%      0     0     0     1     1     1     1     1     1     1     0
%      0     0     0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0     0     0
% Bpe =
%      0     0     0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0     0     0
%      0     0     0     0     1     1     1     1     1     0     0
%      0     0     0     0     1     1     1     1     1     0     0
%      0     0     0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0     0     0
% Bpecrop = 
%      0     0     0     0     0     0     0     0     0
%      0     0     0     0     0     0     0     0     0
%      0     0     0     1     1     1     1     1     0
%      0     0     0     1     1     1     1     1     0
%      0     0     0     1     1     1     1     1     0
%      0     0     0     0     0     0     0     0     0 
%  --> Bpecrop is exactly equal to the wanted Bw
% (Note): The 3rd method is the wanted method but it requires zero padding 
%         and cropping operations.
%         The 2nd method does not yield the wanted one, but it is simple
%         and quite similar wanted one for the large structuring element. 
