function  F = histim(H)
%  F = histim(H) returns an 1D line image of length Nh with a normalized 
%  intensities between [0,1] having its histogram equal to the given H, 
%  where Nh denotes the total number of samples, Nh = sum(H). 
%  H is assumed as the K bins of histogram defined by H(k) for k=0:(K-1).
%  F is constructed by a normalized intensities between [0,1] such as
%       F( H(k) + [1:H(k+1)] ) = k/(K-1)  for k = 0:(K-1), 
%  That is
%       F(1:H(1)) = 0, 
%       F(H(1) + [1:H(2)]) = 1/(K-1), 
%       F(H(2) + [1:H(3)]) = 2/(K-1), 
%             ...            ...
%      F(H(K-2) + [1:H(K-1)]) = (K-1)/(K-1), 
%  This histim.m plays a dual operation of the function imhist.m, i.e.,
%  imhist(F, K) yields the transpose of H reversely.
    K = length(H);
    F = [];  
 for k = 0:K-1  
    F = [F,  k*ones(1,H(k+1))];
 end
     F = F/(K-1);   % Normalized intensities in [0, 1]
% -----------------------------------------------------------------------    
% For example, we can see that the following ho is equal to h. 
%   h = [2  5  3  7];   K = length(h)
%   F = histim(h), 
%   ho = imhist(F,K)';
%   chk = isequal(h,ho),    % <---  chk=1,  So ho=h.
% -----------------------------------------------------------------
%   (K-1)*F = 0  0  1  1  1  1  1  2  2  2  3  3  3  3  3  3  3  