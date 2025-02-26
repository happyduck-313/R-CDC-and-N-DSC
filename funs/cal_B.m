function B = cal_B(F, A, lamda)
    % Calculate matrix B given matrices F, A and scalar lamda
    % Input:
    % F - input matrix
    % A - coefficient matrix
    % lamda - regularization parameter
    %
    % Output:
    % B - output matrix

    n = size(F, 1); % Size of F (number of rows)

G = F / sqrtm(full(F' * F));

    % Precompute squared norms of G to avoid recomputation
    G_norm_squared = sum(G.^2, 2);

    % Vectorized computation of matrix M avoiding explicit loops
    G_diff = repmat(G_norm_squared, 1, n) - 2 * G * G.' + repmat(G_norm_squared.', n, 1);
    M = sqrt(G_diff);

    % Compute matrix B using matrix operations
    B = A - lamda * 1/2 * M;
end
