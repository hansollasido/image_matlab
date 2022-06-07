function [x, y] = arcircle(R, O, THETA, Col, Width)
% [x, y] = arcircle(R, O, THETA, Col, Width) returns a graphic representation 
%   of an arc of radius R, within radian angle THETA with respect to the center O.
%  R is a scalar and represents the radius of the arc.
%  O is a vector of [m,n] and denotes the coordinate of the center of the arc.
%  THETA is a vector (radians) representing the sample angle.  For example,
%  THETA = pi*[10:60]/80, i.e., pi/8<=THETA<=0.75*pi with resolution pi/8.
%  Col is color of the arc such as 'r', 'g',..., etc. 
%  Width is the linewidth of the arc such as 1.5,2,..., etc.
%

 error(nargchk(3,5, nargin))
   x = R*cos(THETA) + O(1);
   y = R*sin(THETA) + O(2);
 if nargin==3
   plot(x,y); 
 elseif nargin == 4
  if ischar(Col)
      plot(x,y,Col);
  else
     plot(x,y,'linewidth',Col);
  end
 else  % nargin = 5
  if ischar(Col)
     plot(x,y,Col,'linewidth',Width );
  else
     plot(x,y,Width, 'linewidth', Col);
  end
 end
%  Example: Draw a circle of radius 5, centerd at (1,1) between radian angle
%          with  pi*[30:110]/90,  
%    R=5;   cent=[1,1];  theta = pi*[30:110]/90;
%   figure;  arcircle(R,cent, theta, 'b');  axis(2*R*[-1,1,-1,1]); 

