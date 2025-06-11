function isDetectable = Ts_Detectable(A, C)
    % Check detectability of the pair (C, A)
    %
    % Args:
    %   A: System matrix
    %   C: Output matrix
    %
    % Returns:
    %   isDetectable: Boolean indicating if the pair (C, A) is detectable

    % Find eigenvalues and left eigenvectors of A
    [eigVecs, eigVals] = eig(A', 'vector');

    % Identify unstable eigenvalues (Real part > 0)
    unstable_indices = find(real(eigVals) > 0);
    unstable_eigVecs = eigVecs(:, unstable_indices);

    % Check if all unstable eigenvalues are observable
    isDetectable = true;
    for i = 1:size(unstable_eigVecs, 2)
        if norm(C * unstable_eigVecs(:, i)) == 0  % Eigenvalue is not observable
            isDetectable = false;
            break;
        end
    end

    % Return the detectability status
    return;
end

