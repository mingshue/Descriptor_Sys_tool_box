function [X0]=LMI_BRL0(A0,B0,C0,g)
    % use matlab  LMI tool box find the solution 
    % 20240419
    %  
    % g = gamma
    %   
    g2=g^2;
    %% 描述LMI
    [m,n]=size(A0)
%start
    setlmis([])
% unknown
    X0=lmivar(1,[n,1])
%%            
    % set LMI1
        %set eq [A0'X0+X0'A0+C0'C0, X0B0]
        %       [B0'X             , -gI ]
    lmiterm([1,1,1,X0],A0',1, 's');
    lmiterm([1,1,1,0],C0'*C0);
    lmiterm([1,1,2,X0],1,B0);
    lmiterm([1,2,1,X0],B0',1);
    lmiterm([1,2,2,0],-g2*1);
    lmisys=getlmis%get LMI eq
  %}
  %
    %% slove LMI
    [tmin,xfeas]=feasp(lmisys)
    if(tmin<0)
        disp('Feasible');
        X0 = dec2mat(lmisys,xfeas,X0);
    else
        X0=NaN;
    end
%[]