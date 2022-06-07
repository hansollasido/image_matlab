function B = blanking(x, b)
%  B = blanking(x, b) returns x with spacing b-balnks between strings.
% x is an integer matrix or vetor and b is a non negative integer.
 [M,N] = size(x);     
  Dp=length(int2str(max(x(:))));  % The number of digits
  Dn=length(int2str(min(x(:))));
 D = max(Dp,Dn);  % The number of digits including the sign
 
    B = [];
 for m=1:M,
    z=[];
 for n = 1:N,
    s = int2str(x(m,n));
    Ds = length(s);
   % z = [z s blanks(b+D-Ds)];
    z = [z blanks((D-Ds)) s blanks(b)];
 end
    B = [B; z];
 end

