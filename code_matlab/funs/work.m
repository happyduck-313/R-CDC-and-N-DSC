function [F, y_x, F_original, F_comparison] = work(A, c, NUM, lambda, method)
    % Function to perform iterative optimization on matrix F
    % Inputs:
    % A - Input matrix
    % c - Number of columns in F
    % NUM - Number of iterations
    % lambda - Regularization parameter
    % method - Algorithm choice (1 for optimize_S, 2 for optimize_S_fast, default is 1)
    % Outputs:
    % F - Optimized matrix F
    % y_x - Objective function values over iterations
    % F_original - Initial state of matrix F
    % F_comparison - Placeholder for comparison, not used

    if nargin < 5
        method = 1; % Default to method 1 if not specified
    end

    A = sparse(A); % Ensure A is in sparse format
    F = sparse(size(A, 1), c); % Initialize F as a sparse matrix of zeros

    for n = 1:size(F, 1)
        F(n, randi([1, size(F, 2)], 1, 1)) = 1; % Assign random ones within each row
    end

    F_original = F;
    F_comparison = F; % Currently unused, consider removing if not needed
    y_x = zeros(1, NUM); % Initialize array to store objective function values

    for i = 1:NUM
        B = cal_B(F, A, lambda); % Calculate matrix B using current F

        % Select optimization method based on input parameter
        if method == 2
            [S, obj_S] = optimize_S_fast(B); % Use faster optimization algorithm
        else
            [S, obj_S] = optimize_S(B); % Use default optimization algorithm
        end

        [F, obj] = solve_F(S, F); % Update F based on optimized S

        % Calculate the trace of Q to adjust the objective function
        Q = Calculate_Matrix_L(S) * F;
        Q = Q' * Q;
        trace_value = sum(diag(Q));
        y_x(i) = norm(S - A, 'fro')^2 + trace_value;

        % Check for convergence based on the change in the objective function
        if i > 1 && abs(y_x(i) - y_x(i - 1)) < 1e-6
            break; % Stop if changes are below threshold
        end
    end

    % Convert F to a format that indicates the active indexes
    [~, F] = find(full(F) == 1);
end
