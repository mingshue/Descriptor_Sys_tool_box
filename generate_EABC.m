function idx = generate_EABC(n, m, m0, m1, up_bound, low_bound)
% GENERATE_EABD_AND_SAVE Generate an EABD system and save if generalized eigenvalues are preserved.
%
% Syntax:
%    idx = generate_EABD_and_save(n, m, m0, m1, up_bound, low_bound)
% Description:
%    The matrix E1 has the following block structure:
%
%        E1 = [ eye(n)      0       ]
%              [   0         0       ]
%
%    The matrix A1 has the following block structure:
%
%        A1 = [ diag(r)     0       ]
%              [    0     eye(m1)   ]
%
%    The matrix B1 has the following block structure:
%
%        B1 = [  B   ]        (size: n  x m)
%              [  B2  ]       (size: m1 x m)
%
%    The matrix C1 has the following block structure:
%
%        C1 = [  C   C2  ]    (size: m0 x (n + m1))
%
%
% Input arguments:
%    n         - Number of finite eigenvalues
%    m         - Input size
%    m0        - Output size
%    m1        - Size for extended matrix (m1+n = total size)
%    up_bound  - Upper bound for eigenvalue generation
%    low_bound - Lower bound for eigenvalue generation
%
% Output arguments:
%    idx       - 1 if the system was saved, 0 otherwise
%
% Example:
%    idx = generate_EABD_and_save(5, 2, 2, 2, -20, -5);
%
% Author: Ming Shue
% Date: 2025-06-11


idx = 0;  % local counter for this function call

% Generate system
r = up_bound + (low_bound - up_bound) .* rand(n,1);
A = diag(r); 
B = rand(n,m);
B2 = rand(m1,m);
C = rand(m0,n);
C2 = rand(m0,m1);

E1 = blkdiag(eye(n), zeros(m1));
A1 = blkdiag(A, eye(m1));
B1 = [B;B2];
C1 = [C, C2];

% Random transformation
W1 = rand(m1+n, m1+n);
W2 = inv(W1);

A01 = W2 * A1 * W1;
E01 = W2 * E1 * W1;
B01 = W2 * B1;
C01 = C1 * W1;

% Generalized eig
D1 = eig(A1,E1);
D01 = eig(A01,E01);

% Filter finite eig < 1e10
D1_finite = D1(isfinite(D1) & abs(D1) < 1e10);
D01_finite = D01(isfinite(D01) & abs(D01) < 1e10);

D1_finite = sort(D1_finite);
D01_finite = sort(D01_finite);

if length(D1_finite) == length(D01_finite)
    % 比較
    if all(abs(D1_finite - D01_finite) < 1e-8)
        % Save data
        G01 = Fss2tf(E01,A01,B01,C01,0,1);
        H_inf_G01 = H_inf(G01);
        filename = sprintf('System_set_rE=%d_Hinf_%.f.mat', n, round(H_inf_G01,2));
        save(filename, "E1","A1","B1","C1","E01","A01","B01","C01","W1","W2");
        disp('Data_Saved');
        idx = 1; % this iteration saved
    end
else
    disp('Skip: different length of finite eig');
end

end