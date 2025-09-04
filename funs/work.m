function [F, y_x, F_original] = work(A, c, NUM, lambda)
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



    A = sparse(A); % Ensure A is in sparse format
    F = zeros(size(A, 1), c);  % Initialize F with zeros

for n = 1:size(F, 1)
        F(n, randi([1, size(F, 2)], 1, 1)) = 1;  % Assign random 1s in each row
    end



    F_original = F;
    y_x = zeros(1, NUM); % Initialize array to store objective function values

    for i = 1:NUM
        B = cal_B(F, A, lambda); % Calculate matrix B using current F

       
        [S, obj_S] = optimize_S_fast(B); 


        [F, obj] = solve_F(S, F); % Update F based on optimized S

        % Calculate the trace of Q to adjust the objective function
        Q = Calculate_Matrix_L(S) * F;
        Q = Q' * Q;
        trace_value = sum(diag(Q));
        y_x(i) = norm(S - A, 'fro')^2 + trace_value;

        % % Check for convergence based on the change in the objective function
        if i > 1 && abs(y_x(i) - y_x(i - 1)) < 1e-6
            break; % Stop if changes are below threshold
        end


    end

    % Convert F to a format that indicates the active indexes
    [~, F] = max(F, [], 2);

    %         fprintf('lambda=%0.6f \n',lambda);
    % fprintf('S-A^2=%0.6f \n',norm(S-A,'fro')^2);
    % fprintf('lambda*SC=%0.6f \n\n',lambda*trace_value);

    % Save S matrix to a CSV file
    csvwrite('./figrue/S_matrix.csv', full(S));
end
