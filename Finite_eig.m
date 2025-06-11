function [V_finite, finiteEigenvalues, W_finite] = Finite_eig(A, E, N)
%Find those finite eigenvalues and corresponding eigenvectors
%
%W_finite'*A*V_finite=diag(finiteEigenvalues)
%20250605
%
%% Use eig(A,E)

   [V, D, W] = eig(A, E);
    eigenvalues = diag(D);
    finiteIndices = isfinite(eigenvalues) & abs(eigenvalues) < 1e10;
%%

    finiteEigenvalues = eigenvalues(finiteIndices);
    V_finite = V(:, finiteIndices);
    W_finite = W(:, finiteIndices);
    
%% Gram Schmit Process
    for i = 1:length(finiteEigenvalues)
        scaling_factor = W_finite(:, i)' * E * V_finite(:, i);
        if abs(scaling_factor) > eps % 檢查 scaling_factor 是否足夠大，避免除以接近零的數值
            scaling_factor = sqrt(scaling_factor);
            V_finite(:, i) = V_finite(:, i) / scaling_factor;
            W_finite(:, i) = W_finite(:, i) / scaling_factor;
        end
    end
    if N == 1
        finiteEigenvalues = diag(finiteEigenvalues);
    end





end

