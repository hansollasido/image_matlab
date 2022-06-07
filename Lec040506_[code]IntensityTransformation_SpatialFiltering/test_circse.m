% test_circse.m: Test of circse.m
%
% Let us learn the use of <circse.m> with the following examples.
%  1. Display and plot a CSE of radius 5
%  2. Find and display a ring of inner and outer radii [30,45]. And dilate 
%     the ring with a CSE of radius 5 and display the dilated ring.   
%  3. Dilate the ring obtained in 2 with a CSE of radius 40 and display
%     the dilated result.  
%
%   M function: imfill, imdilate, imerode, label2rgb, plot, scatter, int2str,
%   C function: circse, stringmatrix, 

  clc; close all; clear all;
 
   prob = '23',  % '1' or '23' for problem 1 and other 2,3
switch prob
case '1'
% (1) Display and plot a CSE of radius 5.   
    R = 5;   
    W = 2*R+1;
   [SE, C] = circse(R),    
   [M,N] = size(C);
   chk =stringmatrix(C,0,0)
    % chk= (row)   0-1-2-3-4-5-5-5-5-5-4-3-2-1 0 1 2 3 4 5 5 5 5 5 4 3 2 1
    %     (column) 5 5 5 4 3 2 1 0-1-2-3-4-5-5-5-5-5-4-3-2-1 0 1 2 3 4 5 5

% (1a) Display in the image mode   
 figure(1); imshow(SE+1,[-1,2],'InitialMagnification','fit'); hold on;
    % arcircle(R, [R+1,R+1],  2*pi*[0:90]/90, 'b:');
    a = pi*[0:360]/180;  plot(R+1+R*cos(a),R+1+R*sin(a),'b');  axis([1,W,1,W]); 
    title(['\bfCSE of radius ' int2str(R) ' in counterclockwise direction' ]);
 % Line drawing by connecting every samples of the CSE
    hold on; plot(R+1+C(1,:),R+1+C(2,:), 'r')
 
 % Scattering every samples of the CSE
   for k=1:N
    row = C(1,k);
    col = C(2,k);
    scatter(R+1+col, R+1+row,'r','filled');  hold on;
    if abs(row)>abs(col)
       text(R+1+ col-0.2, R+1+row - 0.4*sign(row),[ int2str(k)]);
    else
       text(R+1+ col + (sign(col)-1/4)/2, R+1+row,[ int2str(k)]);
    end
     pause(0.15);
  end
  
% (1b) Plot in the plot mode   
   a = pi*[0:360]/180; 
  figure(2);  plot(R*cos(a),-R*sin(a),'b');  axis([-R,R,-R,R]); 
    hold on; plot(C(1,:),C(2,:), 'r');    hold on; grid on; 
    title(['\bf CSE distribution of radius ' int2str(R) ]);
  
  for k=1:N
    row = C(1,k);
    col = C(2,k);
    scatter(col, -row,'r','filled');  hold on; axis off
    if abs(row)>abs(col)
       text(col-0.2, -row + 0.4*sign(row),[ int2str(k)]);
    else
       text(col + (sign(col)-1/4)/2, -row,[ int2str(k)]);
    end
     pause(0.15);
  end  
% (Note): The above two figures do not have the same axes: 
%   Fig.1 has top down y-axis since the axes are based on the image.
%   On the other hand, Fig.2 has bottom up y-axis as in the ordinary Math. 
%   So they have different signs in scatter and text (look carefully). 

case '23' 
% (2) Find and display a ring of inner and outer radii [30,45]. 
     ri = 30-1;   % Radius of the closest ring just inside the inner ring 
     ro = 45;
     Si = circse(ri);  wi = [-ri:ri];
     So = circse(ro);  wo = [-ro:ro];
     
     ci = zeros(300);          co = ci;  
     ci(171+wi,151+wi) = Si;     co(171+wo,151+wo) = So;
     diski = imfill(ci);
     disko = imfill(co);
     ring = disko&(~diski);  
      % Or, equivalently ring = disko-diski;
  figure(3); imshow(ring); title('\bf Ring of inner and outer radii [30,45]');
  
% And dilate the ring with a CSE of radius 5 and display the dilated ring.   
      se = circse(5);
      rd = imdilate(ring, se);
      rdrgb = label2rgb(rd+ring, 'spring',[4  3  2]/4);
  figure(4); imshow(rdrgb); title('\bf Dilated ring by a CSE of radius 5');
     text(20,20, 'Yellow: Given ring')
     text(20,40, 'Magenta: Dilated ring up to radius 5','color','b'  )
     text(20,60, '   (both inside and outside of ring)'  )

% (3) Dilate the ring obtained in 2 with a CSE of radius 40 and display
%     the result.   
      re = imerode(ring, circse(40));
      rergb = label2rgb(re+2*ring, 'spring',[4  3  2]/4);
      chk = stringmatrix(re(170:172,151+[-7:7]),0,2), 
        % chk = 0  0  0  1  1  1  1  1  1  1  1  1  0  0  0
        %       0  0  1  1  1  1  1  1  1  1  1  1  1  0  0
        %       0  0  0  1  1  1  1  1  1  1  1  1  0  0  0
  figure(5); imshow(rergb); title('\bf Eroded ring by a CSE of radius 40');
     text(20,20, 'Yellow: Given ring')
     text(20,40, 'Magenta: Erosion yields a ring of radius 5','color','b'  )
end     
