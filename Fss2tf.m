function [G] = Fss2tf(E,A,B,C,D, alpha)
% compute the transfer funciton with fractional system
% {G} = transfer function 
% {E,A,B,C,D} is system
% {alpha} = fractional order
% 20231219
   syms s  
    G = C*inv(s^alpha*E-A)*B+D;
    expr=G;
    G = simplify(expr);
end

