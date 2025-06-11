function [Eigen_EAQR] = Create_UV_1(E,A,Q,R)
%20250211
% Find U, the finite eigenvector of {E,A,Q,R}
% 
% Fix the problems of version 1
    % 1. Simpfy the code 
    % 2.rank(EU_1)= r 
%% Set E1--->[-E',E], A1---->[Q,A'; A,R],
%addpath('00Function');
[mE,nE]=size(E);
    E1= [zeros(nE),E'; E,zeros(nE)];
    A1= [-Q,-A';A,R];
    V1= null(E);
    V2= null(E');
    V= blkdiag(V1,V2);
[mE1,nE1]= size(E1);
%% Find U    and  such that rank(E*U_1)=rank(E)=r
[V, D] = eig(A1,E1);
    eigenvalues = diag(D);
    idx = real(eigenvalues)< 0 &real(eigenvalues)>-inf;
    Ds=eigenvalues(idx);
    U= V(:, idx);
    U1=U(1:nE,:);
    U2=U(nE+1:end,:);
    
    idx_00=sum(idx) % num of finte eigenvalues 
    U1_sort = zeros(nE, idx_00); 
    idx_01 = 0; %num of find U1
    %fid U1 >> rank(E*U_1)=r
    for i=1:sum(idx)
        p=E*U1(:,i);
        p1= norm(p)
        if p1>10^(-8)
            idx_01=idx_01+1;
               U1_sort(:,idx_01)=U1(:,i);
        end
    end
    U1_sort = remove0Columns(U1_sort);
    W=[U1_sort,V2];

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

