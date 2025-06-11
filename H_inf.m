function [ Hinf,singular_values] = H_inf(G)
% caculate H infy norm for transfer function G
%  20231219
    syms s
    omega = logspace(-10, 10, 500);
    singular_values = zeros(length(omega), 1);
    
    % 遍历所有频率点
    for i = 1:length(omega)
        s = 1j*omega(i);  % 将 s 替换为 jω
        G_evaluated = eval(G);  % 计算 G(jω)
        singular_values(i) = max(svd(G_evaluated));  % 计算并存储最大奇异值
    end
    Hinf=max(singular_values);
    %{
    % plot
        semilogx(omega, singular_values,'LineWidth',2);
        xlabel('Frequency (rad/s)');
        ylabel('Singular Values');
        title('Singular Value Plot of G(s)');
        % 找到最大值
        [maxValue, maxIndex] = max(singular_values);
        maxX = omega(maxIndex);
        text(maxX, maxValue, ['MaxValue: ', num2str(maxValue)], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
        grid on 
    %}
    
end

