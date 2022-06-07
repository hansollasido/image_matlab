function C = setborder(G, L)
%  C = setborder(G, Level) returns a modified border levels of G by L.
   G([1, end],:) = L;
   G(:, [1,end]) = L;
   C = G;
%   T.Y. Choi (February, 2013)   
%
% ---------------------------------------------------------------
%  For example, when G is given by
%  G = 0     0     0     0     0     0     0     0     0
%      0     0     1     1     1     1     1     1     1
%      0     0     1     1     1     1     1     1     1
%      0     0     1     1     1     1     1     1     1
%      0     0     1     1     1     1     1     1     1
%      0     0     1     1     1     1     1     1     1
% Gz = setborder(G, 0):
% Gz = 0     0     0     0     0     0     0     0     0
%      0     0     1     1     1     1     1     1     0
%      0     0     1     1     1     1     1     1     0
%      0     0     1     1     1     1     1     1     0
%      0     0     1     1     1     1     1     1     0
%      0     0     0     0     0     0     0     0     0
