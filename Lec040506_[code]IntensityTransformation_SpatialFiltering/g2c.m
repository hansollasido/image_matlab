function C = g2c(G)
%  C = g2c(G) returns a gray image of 3D RGB color format such as
%      C = cat(3,G,G,G)
%  which can be used for concatenation of a color image and a gray image G
%  in the same 3D format. For example, assume A is a color image of size 
%  (M,N,3) and G is a gray image of size (M,N). In this case, we can 
%  concatenate  A and g2c(G) and display it in one Figure:
%    F = [A, g2c(G)]; ( or  F=[A; g2c(G)]) 
%    imshow(F).
%
%    T.Y. Choi (April, 2011)
     C = cat(3,G,G,G);