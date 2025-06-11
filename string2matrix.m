function result = string2matrix(data, p)
    % 去除數據中的方括號
    data = data(2:end-1);
    
    % 用 '@' 符號分割不同的行
    rows = split(data, '@');
    
    % 初始化一個空的 cell array 來存放最終的矩陣
    result = {};
    
    % 遍歷每一行
    for i = 1:length(rows)
        % 用 '&' 分割同一行中的數字
        numbers = split(rows{i}, '&');
        % 轉換字符串數字為實際的數字並存入 result
        result{i} = str2double(numbers);
        % 四舍五入到指定的小數位數
        result{i} = round(result{i}, p);
    end
    
    % 轉換 cell array 為數值矩陣
    result = cell2mat(result);
end