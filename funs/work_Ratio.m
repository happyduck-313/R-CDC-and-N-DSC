function [F, y_x, F_original] = work_Ratio(A, c, NUM, lamda)
    % Iteratively refine matrix F based on matrix A and other parameters
    % Inputs:
    % A - Input matrix
    % c - Number of columns for matrix F
    % NUM - Number of iterations
    % lamda - Regularization parameter
    % Outputs:
    % F - Refined matrix
    % y_x - Array of objective function values across iterations
    % F_original - Original random assignment of F
    % F_comparison - Placeholder for comparison purposes

    F = zeros(size(A, 1), c);  % Initialize F with zeros
    % for n = 1:size(F, 1)
    %     F(n, randi([1, size(F, 2)], 1, 1)) = 1;
    % end
    F = n2hi(A, c);
    F_original = F;
  
    y_x = zeros(1, NUM);  % Initialize objective function values
% [SSS,ob11] = solve_F(A,F);
    for i = 1:NUM
        B = cal_B(F, A, lamda);  % Calculate matrix B based on current F
        S = zeros(size(B));  % Initialize S as zeros with the same size as B
        for j = 1:size(B, 1)
            S(j, :) = EProjSimplex_new(B(j, :), 1);  % Project each row onto simplex
        end



        [F, obj] = solve_F(S, F);  % Solve for new F

        Q = inv(F' * F) * F' * Calculate_Matrix_L(S) * F;
        trace_value = trace(Q);
        y_x(i) = norm(S - A, 'fro')^2 + trace_value;  % Update objective function value

        if i > 1 && abs(y_x(i) - y_x(i - 1)) < 1e-6
            break;  % Convergence check
        end
    end
        % Convert F to a format that indicates the active indexes
    [~, F] = max(F, [], 2);

    % [~, SSSS] = find(full(SSS) == 1);

    %     % Save S matrix to a CSV file
    % csvwrite('./figrue/SR_matrix.csv', full(S));
end
