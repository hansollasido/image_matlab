function [Feq, Heq, H] = heq(F, BIN, block) 
% [Feq,Heq,H] = heq(F, BIN, block) returns the block histogram equalization 
%    of F within limited gray level only between block = [g1, g2] of F 
%    while keeping the others themselves for F<g1 and F>g2.
%  F has a histogram function H of BIN-bins.
%  Heq is the histogram of Feq, that is, Heq and H differ for gray levels 
%    [g1, g2] only.  
% (For Example): For simplicity, assume F is an uint8 data class between
%   [0,255], i.e., BIN = 256. Then 
%    (1) Feq = heq(F, 256) = heq(F, 256,0:255) is simply the histogram 
%             equalization of F. 
%    (2) Feq = heq(F, 256,[100,200]) is the same as F for F<100 and F>200 
%        but is the histogram equalized version of F for 100<=F<=200.
%   
  ni = nargin;
if (ni==1)|(ni>3)
    error('Too small or large inputs')
elseif ni==2
  g1 = 0;   g2 = BIN-1;
else
  g1 = block(1);   g2 = block(2);
end
% Normalize F to be [0,1]
  F = double(F);
  F = F/max(F(:));
% Histogram H of F (H takes a row vector form)
  H = imhist(F, BIN)';
% Cumulative density function C between [g1, g2]
  C = cumsum(H(1+[g1:g2]));   %  1 for the initial value 0 
  gw = g2-g1;                   % Block width between [g1, g2]
  q = round(gw*C/C(end)) + g1;  % HEQed values between [g1,g2]
 % Block histogram equalized image Feq of F between [g1, g2]  
  Feq = F;  
  Heq = H;  Heq(1+[g1:g2]) = 0;
  bw = BIN-1;
for k = 0:gw
  B = (F==(g1+k)/bw);  
  Feq(B) = q(k+1)/bw;  
  if find(q==g1+k)
    Heq(g1+k+1) = sum(H(g1+find(q==g1+k)));
  end
end


% %  (Example)  ---------------------------------
% %  For a given histogram function H of F as
%    H = [5 2,9, 10,8,9,2,14,1,5,2, 32,25,17,8, 0,3,5,2,1, 2]
%    F = histim(Heq);  % Equivalent 1D line image of Heq
%       Ho = imhist(F,21)';   chk1 = isequal(Heq,Ho)  % chk =1
% %  Find the histogram equalization [Feq,Heq,H] = heq(F,21,[3,10])  
%     [Feq,Heq,H] = heq(F,21,[3,10]);
%     Heq1 = imhist(Feq,21)';  
%     chk2 = [Heq; Heq1]
%      f= reshape(F,18,9);
%      feq = reshape(Feq,18,9);
%    figure; imshow(imarray(1,2,[2,2],2,[f,feq]),'InitialMagnification','fit')
%      5     2     9    10     8     9     2    14     1     5     2    32    25    17     8     0     3     5     2     1     2
%      5     2     9     0    10     8     0    11     0    15     7    32    25    17     8     0     3     5     2     1     2
%                       | <-------------     HEQ     -------------->|      

