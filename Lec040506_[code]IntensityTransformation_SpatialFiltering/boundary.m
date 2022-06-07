function Q = boundary(f)
%  y = boundary(x) returns the boundary image of the binary image x.
%  This is based on the vertical and horizontal differences of x.
% 
  Q = zeros(size(f));
  % (1) Horizontal approach   
  d = diff(f,1,2);
  [x,y] = find(d==1);
  [x1,y1] = find(d==-1);
  for k=1:length(x)
      Q(x(k),y(k)+1)=1;  % Shift 1 sample
  end
  for k=1:length(x1)
      Q(x1(k),y1(k))=1;
  end
 % (2) Vertical approach  
  d = diff(f,1,1);
  [x,y] = find(d==1);
  [x1,y1] = find(d==-1);
  for k=1:length(x)
      Q(x(k)+1,y(k))=1;  % Shift 1 sample
  end
  for k=1:length(x1)
      Q(x1(k),y1(k))=1;
  end

  
  