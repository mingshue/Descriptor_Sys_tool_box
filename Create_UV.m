function [Eigen_EAQR] = Create_UV(E,A,Q,R)
%20240417
% Find U, the finite eigenvector of {E,A,Q,R}
%Version 1
%% Set E1--->[-E',E], A1---->[Q,A'; A,R],
    %addpath('00Function');
    [mE,nE]=size(E);
    E1= [zeros(nE),E'; E,zeros(nE)];
    A1= [-Q,-A';A,R];
    V1= null(E);
    V2= null(E');
    V= blkdiag(V1,V2);
    [mE1,nE1]= size(E1);
    %% find U    
    
    [Dh]= eig(A1,E1);
    Ds= Dh(real(Dh) < 0 & real(Dh) > -inf);
    Ds= diag(Ds);
    
    [mDs,nDs]= size(Ds);
    Kr= kron(eye(nDs),A1)-kron(Ds',E1);
    U = null(Kr);
    [Um,Un]=size(U);
    U = vec_inv(U, mE1, (Um*Un/mE1));
    U1=U(1:nE,:);
    U2=U(nE+1:end,:);
    
    U1=remove0Columns(U1);
    U2=remove0Columns(U2);
    U=[U1;U2];
    
    
%% Set {A,Q,R}--->{A0,Q0,R0}
%    
    A0=V2'*A*V1;
    R0=V2'*R*V2;
    Q0=V1'*Q*V1;

    % Check if the 'icare' function exists
    if exist('icare', 'file')
        [X0,K1,L1] = icare(A0,[],Q0,[],[],[],R0);
        %[X0,K1,L1] = icare(A0,[],Q0,[],[],[],-R0);
    else
        [X0,K1,L1] = care(A0,-R0,Q0);
        %care(A,B,Q)
    end
    
    W=[U1,V1];
    X=[U2,V2*X0]*(inv(W));
%
 %% Set Structure of  {E,A,Q,R}
    Eigen_EAQR.A0=A0;
    Eigen_EAQR.Q0=Q0;
    Eigen_EAQR.R0=R0;
    Eigen_EAQR.X0=X0;
    
    Eigen_EAQR.X=X;
    Eigen_EAQR.Eigenvalue=L1;
    
    Eigen_EAQR.E_bar=E1;
    Eigen_EAQR.A_bar=A1;
    Eigen_EAQR.V=V;
    Eigen_EAQR.V1=V1;
    Eigen_EAQR.V2=V2;
    
    Eigen_EAQR.Ds=Ds;
    Eigen_EAQR.U=U;
    Eigen_EAQR.U1=U1;
    Eigen_EAQR.U2=U2;   
end

