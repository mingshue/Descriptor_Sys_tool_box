function fit = stabilityFitness(F, A, B1, C2, E)
    F = reshape(F, size(B1, 2), size(C2, 1));  % 将线性向量重新形状化为矩阵
    A_mod = A + B1 * F * C2;
    eig_vals = eig(A_mod, E);
    if isempty(eig_vals)
        fit = Inf;  % 如果没有特征值，则返回无穷大
    else
        fit = max(real(eig_vals));  % 我们的目标是最小化最大实部
    end
end