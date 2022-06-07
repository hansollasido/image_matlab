function [Ro,Co] = imarrayp(M,N, Space, k, Size, varargin) 
% IMARRAYP(M,N,Space,Location, k,Size, Location) returns the coordinate 
%   of a point (Ro-th row and Co-th column), located at (r1,c1) defined by 
%   varargin on the k-th subimage arranged by imarrange(M,N, Space,K,Cat2) 
%   in plot mode.(1<=k<=K<=MN).
% Space = [vs, hs] or [vs, hs, 0.9] and vs=Space(1) and hs=Space(2) denote
%   the vertical and horizontal spaces between neighbor subimages.
% Size = [R,C] denote the size of a subimage and each of all subimages has
%   the same size (R rows and C columns).
% varargin = [r1, c1], denotes the coordinate of the given point at r1-th row
%   and c1-th column of the k-th subimage. By default, the point denotes
%   the top left corner of the k-th image.(r1 = c1 = 0) 

 vs = Space(1);    hs = Space(2);
 R = Size(1);       C = Size(2);
 A = reshape(1:M*N,N,M)';   % <--- A=[B;N+B;2*N+B;..(m-1)*N+B] with B=1:N 
 N = nargin;
if N ==6
   loc =  varargin{1};
   r1=loc(1); c1=loc(2);
else
   r1=0;      c1=0;
end
 [r, c] = find(A==k);
 Ro = (r-1)*(R + vs )+ r1;
 Co = (c-1)*(C + hs) + c1;
% ----> See (test_imarrayp.m) to readily apprehend the above function.
