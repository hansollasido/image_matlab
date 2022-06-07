function Xs = stringmatrix(X, N_frac, N_space)
% Xs = stringmatrix(X, N_frac, N_space) returns the matrix X in the string 
%   format with N_frac fractional digits and insertion of N_space blanks 
%   between adjacent row elements with respect to the decimal position 
%   based on the Matlab function SPRINTF. 
% X is a data matrix of class double.
% N_frac is the number of fraction: When N_frac = 2, the number 123.45723
%   is written as a string 123.46 with sprintf('%0.2f', 123.45723).
% N_space denotes the number of blanks between adjacent row elements.
%  (Example 1)  X = [    2.1257,    13.251,     -10;
%                     -123.45723,    0.2571,     -2.1234],
%       Xs = stringmatrix(X, 2, 5) yields tabulated strings as
%       Xs =       2.13       13.25      -10.00
%               -123.46        0.26       -2.12
%  (Example 2)  Y = [  10.3,    9.1; 
%                     -10.3,    0.2; 
%                      -7.15,   0.3]
%       Ys = stringmatrix(Y, 17, 3) yields tabulated strings as
%       Ys =    10.30000000000000100     9.09999999999999960
%              -10.30000000000000100     0.20000000000000001
%               -7.15000000000000040     0.29999999999999999
%
% ---------------------------------------------------------------
 [R, C] = size(X); 
 F = ['%0.' int2str(N_frac) 'f'];        
 Lp = length( sprintf(F,  max(X(:)))); 
 Ln = length( sprintf(F,  min(X(:))));  
 L = max(Lp, Ln);  % L denotes the maximum possible string length 
                   % including the minus sign (-) and decimal point (.)
 Xs =  [];
for r = 1:R
  Xr =  [];
for c = 1:C
  str =  sprintf(F, X(r,c));
  Nsp = L - length(str) + N_space; 
  Xr = [Xr, blanks(Nsp),  str];
end
  Xs = [Xs; Xr];
 end
end
%  ----> See (test_stringmatrix.m) to readily apprehend the above function.
%  -----------------------------------------------------------------------
% (Verification with the Example 1 above): 
%   Given N_frac=2,  max(X(:)) = 13.251,and  min(X(:)) = -123.45723,
%     Lp = length(13.25) = 5 (including the point)
%     Ln = length(-123.46) = 7 (including the point and minus sign)
