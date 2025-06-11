function A = vec_inv(v, m, n)
%VEC_INV 将向量v逆向量化成一个m行n列的矩阵
    A = reshape(v, [m, n]);
end