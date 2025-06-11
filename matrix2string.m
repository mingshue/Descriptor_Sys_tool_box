function matStr = matrix2string(M,p)
    % M 是你想要粘貼到 Matlab 的矩陣
    % M is the matrix you want to paste into Matlab
    % p 是你想要的數字精度
    % p is the precision you want for the numbers in the matrix
 %%
%{
    matStr = '[\matrix(';
    [rows, cols] = size(M);
    
    % 迭代每一行
    for i = 1:rows
        % 迭代每一列
        for j = 1:cols
            % 檢查元素是否為整數
            % Check if the element is an integer
            if M(i, j) == fix(M(i, j))
                % 元素為整數，直接輸出
                % The element is an integer, output directly
                matStr = [matStr, sprintf('%d', M(i, j))];
            else
                % 元素為浮點數，四捨五入到指定位數
                % The element is a floating-point number, round to the specified precision
                matStr = [matStr, sprintf(['%.' num2str(p) 'f'], M(i, j))];
            end
            % 根據位置決定是否添加&或@
            % Determine whether to add a comma or semicolon based on the position
            if j == cols % 如果是行尾
                if i ~= rows % 如果不是矩陣的最後一行
                    matStr = [matStr, '@'];
                end
            else % 如果不是行尾
                matStr = [matStr, '&'];
            end
        end
    end
    
    % 添加右方括号
    matStr = [matStr, ')]'];
    fprintf('%s\n', matStr)
    end
    %}
   
    matStr = '[\matrix(';
    [rows, cols] = size(M);

    for i = 1:rows
        for j = 1:cols
            % 检查元素是否是复数
            if ~isreal(M(i,j))
                % 元素是复数，输出实部和虚部
                matStr = [matStr, sprintf(['%.' num2str(p) 'f'], real(M(i,j)))];
                if imag(M(i,j)) >= 0
                    matStr = [matStr, '+'];
                end
                matStr = [matStr, sprintf(['%.' num2str(p) 'f'], imag(M(i,j))) 'i'];
            elseif M(i, j) == fix(M(i, j))
                % 元素是整数
                matStr = [matStr, sprintf('%d', M(i, j))];
            else
                % 元素是浮点数
                matStr = [matStr, sprintf(['%.' num2str(p) 'f'], M(i, j))];
            end
            
            if j == cols % 如果是行尾
                if i ~= rows % 如果不是矩阵的最后一行
                    matStr = [matStr, '@'];
                end
            else % 如果不是行尾
                matStr = [matStr, '&'];
            end
        end
    end

    matStr = [matStr, ')]'];
    fprintf('%s\n', matStr);
end
    