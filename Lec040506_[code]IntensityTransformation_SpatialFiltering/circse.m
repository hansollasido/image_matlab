function  [CSE, C] = circse(R)
% [CSE,C] = circse(R) returns the Circle Structuring Element (CSE) of radius R.
%  R is a positive integer or zero. 
%  C is a matrix of two rows representing the coordinates (x,y) of SE on 
%    a circle of radius R in the counter clockwise direction, where (x,y) 
%    represents the xth-row and yth-column as the image coordinate assuming 
%    the center of CSE as (0,0) such as 
%        top left:    (-R, -R),   top right:    (-R, R)
%        bottom left: ( R, -R),   bottom right: ( R, R)
%        The center point: (0,0)
%
% (Example): [CSE,C] = circse(2)
% CSE = 0     1     1     1     0
%       1     0     0     0     1
%       1     0     0     0     1
%       1     0     0     0     1
%       0     1     1     1     0
%
%  C =  0    -1    -2    -2    -2    -1     0     1     2     2     2     1
%       2     2     1     0    -1    -2    -2    -2    -1     0     1     2
%
%    T.Y. Choi (January 2013)
%
%-----------------------------------------------------------------------
% The 1st quadrant Q1 of the primitive CSE
   Q1 = zeros(R+1);  
 for row = -R:0,
 for col = 0:R,
    d = sqrt(row^2+col^2);
 if (d>R-1/2)&(d<=(R+1/2))
    Q1(row+1+R,col+1) = 1;
 end
 end
 end
% (Note-1): In general, the above Q1 has several Giyeok type boundary points
%           as shown in the SE so and in Ex-1 below.
% Now remove the corner points of Giyeok shapes in Q1 by HMT (Hit-or-miss 
% transformation) with the use of a disjoint pair SEs (so,si) defined by
      si = [0 0; 1 0];
      so = [1 1; 0 1];      
% This SE so has a form of Giyeok (the first Korean consonant).
% (Note-2) Both si and so are of size 2x2 and so the origin is assumed as
%          the top left.(See Ex-2 below)
% To prevent the background problem in nthe morpholgical erosion operations
% in the HMT, pad zeros. 
   Q1z = padarray(Q1,[1,1]);    % zero padded to 4 sides of Q1
   Hmz = bwhitmiss(Q1z,so,si);  % HMT of Q1z by (so,si)
   Hm = Hmz(2:R+2,1:R+1);       % <-- shift by -1 
   Q1g = Q1.*~Hm;   % <-- remove padded zeros reversely: double data class
 % The Final CSE of radius R is constructed by symmetrical displacement 
 % for the other 2nd,3rd,4th quadrants
   Slr = fliplr(Q1g); Sud = flipud(Q1g); Sudlr = fliplr(Sud);
   CSE = [Slr, Q1g; Sudlr, Sud];
   CSE(R+1,:) = []; CSE(:,R+1) = []; %  Remove overlapped the middle 
                                     %  vertical and horizontal lines
% Coordinates (x,y) of CSE: (xth row, yth column)
%   Attention: The coordinate (x,y) is the form of the general image such 
%            that the upper leftmost is (-R,-R).(top down and left to right)
% The 1st quadrant (the upper right of the image)
   R1 = [];    C1 = [];
 for k = (2*R+1):-1:(R+2),
   q = find(CSE(1:(R+1),k))';   % Row vector 
   R1 = [R1, fliplr(q)];
   C1 = [C1, k*ones(size(q))];
 end
 % The 2nd quadrant (the upper left of the image)
   R2 = [1, fliplr(R1(2:end))];  
   C2 = [R+1, 2*R+2-fliplr(C1(2:end))]; 
 % The 3rd quadrant (the bottom left of the image)
   R3 = [R+1, fliplr(C1(2:end))];    C3 = R2;
 % The 4th quadrant (the bottom right of the image)
   R4 = C1;   C4 = R3;
% Complete circle coordinate counterclockwise  
    C = [[R1,R2,R3,R4]; [C1,C2,C3,C4]];
    C = C-(R+1);  % Make the center of SE to be the origin (0,0)
%    
% ----> See (test_circse.m) to readily apprehend the above function.
% ------------------------------------------------------------------    
% %------ (Ex-1: Giyeok type zigzag boundary of a primitive CSE) ---------- 
% % When R =4, the 1st quadrant Q1 of primitive CSE has 3 Giyeok types 
% %    (Giyeok is the 1st letter of 14 Korean consonants)  
% % Q1 = 1     1     1     0     0
% %      0     0     1     1     0
% %      0     0     0     1     1
% %      0     0     0     0     1
% %      0     0     0     0     1
% %----- (Ex-2: HMT example) ------------------------------ 
%   x=zeros(5); x(3,3)=1;   y= imdilate(x,so); yc=~y;  v= 2*ones(5,1);
%   hit = imerode(y,so);   hitc = imerode(yc,si); hmt=bwhitmiss(y,so,si);
%  chk1 = [x, v, y],
%  chk2 = [y, v, hit],
%  chk3 = [yc,v, hitc], 
%  chk4 = hmt,   
% % chk1 =            x                          y = imdilate(x,so)
% %      0     0     0     0     0     2     0     0     0     0     0
% %      0     0     0     0     0     2     0     0     0     0     0
% %      0     0     1     0     0     2     0     0     1     1     0
% %      0     0     0     0     0     2     0     0     0     1     0
% %      0     0     0     0     0     2     0     0     0     0     0
% % chk2 =            y                       hit = imerode(y,so)
% %      0     0     0     0     0     2     0     0     0     0     0
% %      0     0     0     0     0     2     0     0     0     0     0
% %      0     0     1     1     0     2     0     0     1     0     0
% %      0     0     0     1     0     2     0     0     0     0     0
% %      0     0     0     0     0     2     0     0     0     0     0
% % chk3 =           yc                     hitc = imerode(yc,si)
% % 
% %      1     1     1     1     1     2     1     1     1     1     1
% %      1     1     1     1     1     2     1     1     0     0     1
% %      1     1     0     0     1     2     1     1     1     0     1
% %      1     1     1     0     1     2     1     1     1     1     1
% %      1     1     1     1     1     2     1     1     1     1     1
% % chk4 = bwhitmis(y,so,si) = hit&hitc
% % 
% %      0     0     0     0     0
% %      0     0     0     0     0
% %      0     0     1     0     0
% %      0     0     0     0     0
% %      0     0     0     0     0
