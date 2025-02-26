function [B, S_B] = optimize_S(B)
    % Function to optimize matrix S by iteratively adjusting matrix B
    % This version is optimized for sparse matrices.
    % Inputs:
    % B - Initial sparse matrix
    % Outputs:
    % B - Optimized sparse matrix
    % S_B - Convergence monitoring array

    n = size(B, 2);  % Number of columns in B
    B_original = B;  % Store the original B for convergence checking
    index = 500;  % Set the number of iterations
    S_B = zeros(1, index);  % Initialize array to monitor changes in B

    for i = 1:index
        temp = sum(B, 2);  % Sum of each row in B
        mu = -1/n * temp;  % Compute mu, no need for mu1 and mu2 as they are identical
        ones_n = sparse(ones(n, 1));  % Use sparse ones vector for large n
        B = B + (n + sum(temp)) / n^2 * ones(n) + mu * ones_n' + ones_n * mu';

        % Zero out negative elements using sparse matrix operations
        B = max(B, 0);

        % Store Frobenius norm of the change for convergence monitoring
        S_B(i) = norm(B - B_original, 'fro')^2;

        % Break if changes are smaller than a threshold
        if i > 1 && abs(S_B(i) - S_B(i - 1)) < 1e-4
            S_B = S_B(1:i);  % Trim the zero values
            break;
        end
    end
end
