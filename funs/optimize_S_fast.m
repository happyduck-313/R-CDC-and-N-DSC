function [B,S_B] = optimize_S_fast(B)
    % Optimizes matrix S by adjusting matrix B iteratively
    % Input:
    % B - initial matrix
    %
    % Output:
    % B - optimized matrix
    % S_B - convergence monitoring array

    n = size(B, 2); % Size of B (number of columns)
    B_original = B; % Preserve original matrix for convergence monitoring
    index = 100; % Number of iterations
    S_B = zeros(1, index); % Array to store Frobenius norms for convergence checking

    for i = 1:index
        S = zeros(size(B)); % Initialize S as zeros matrix with the same size as B
        for j = 1:size(B,1)
            S(j, :) = EProjSimplex_new(B(j, :), 1); % Project each row onto simplex
        end
        B = 0.5 * (S + S'); % Ensure B remains symmetric

        % Store Frobenius norm difference for convergence monitoring
        S_B(i) = norm(B - B_original , 'fro')^2;
        if i > 1 && abs(S_B(i) - S_B(i - 1)) < 1e-4
            S_B = S_B(1:i); % Trim the zero values if converged
            break;
        end
    end
end
