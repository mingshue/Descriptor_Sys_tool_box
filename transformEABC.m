function [S] = transformEABC(E, A, B, C, g, N, N1)
% Transform {EABC} to {A0,B0,C0}  and slove (AX+XA+XRX+Q)
% E - Input matrix associated with E
% A - Input matrix associated with A
% B - Input matrix associated with B
% C - Input matrix associated with C
% g - Gamma, a scalar scaling factor
% N - Control parameter; if N=0, skip computation of the H-infinity norm
% N1 - Control parameter; if N1=0, suppress printing conditions of X0 and X

% Date:20240418
%% Load and compute
    addpath('00Function');
    Q=C'*C;
    R=g^(-2)*B*B';
    [m,n]=size(C*B)
    %
    Eige_EA=Create_UV(E,A,Q,R);
    V1= Eige_EA.V1;
    V2= Eige_EA.V2;
    X0= Eige_EA.X0;
    R0= Eige_EA.R0;
    Q0= Eige_EA.Q0;
    
    X=Eige_EA.X;
%% Compute A0, B0, C0
    A0=Eige_EA.A0;
    B0=V2'*B;
    C0=C*V1;    
    
%% Compute H_\infty nrom
    if N==1
    % Orignal {E,A,B,C}
        [m,n]=size(C*B);
        D =zeros(m,n);
        alpha =1;
        G0 =Fss2tf(E,A,B,C,D, alpha);
        [Hinf,singular_values] = H_inf(G0);
     % Transform A0,B0,C0
        [m0,n0]=size(A0);
        E0=eye(n0);
        G1=Fss2tf(E0,A0,B0,C0,D, alpha);
        [H0inf,singular_values] = H_inf(G1);
    % Save Hinf and  H0inf
        S.Hinf=Hinf;
        S.H0inf=H0inf;
    end   
    
    %% Cheak ARE & GRE
    ARE00=A0'*X0+X0'*A0+X0'*R0*X0+Q0;
    GRE01=E'*X-X'*E;
    GRE02=A'*X+X'*A+Q+X'*R*X;
    %
    if N1==1
        if abs(ARE00)<1e-6
            fprintf('X0 is the solution of ARE')
        end
        if and (abs(GRE01)<1e-6,abs(GRE02)<1e-6)
            fprintf('\n X is the solution of GRE \n')
        end
    end 
    %
 %% Set Structure S={A0,B0,C0....}
    S.A0=A0;
    S.B0=B0;
    S.C0=C0;
    
    S.X0=X0;
    S.X=X;
    %% Cheack part
    S.Solve.ARE00=ARE00;
    S.Solve.GRE01=GRE01;
    S.Solve.GRE02=GRE02;
    S.Details=Eige_EA;
    %S.H=Eige_EA;
end

