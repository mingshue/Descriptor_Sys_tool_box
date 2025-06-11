function U_nonZeroColumns = remove0Columns(U)
    %REMOVEZEROCOLUMNS 去除矩阵中的全零列
    %   输入:
    %   U - 原始矩阵
    %   
    %   输出:
    %   U_nonZeroColumns - 去除全零列后的矩阵

    % 计算每列的非零元素数量
    nonZeroElementsPerColumn = sum(U ~= 0, 1);
    
    % 找到非零元素数量不为0的列
    nonZeroColumns = nonZeroElementsPerColumn > 0;
    
    % 提取这些列
    U_nonZeroColumns = U(:, nonZeroColumns);
end
