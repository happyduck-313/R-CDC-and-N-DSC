function Q = calculate_Q(F, S)
    % 计算 F^T * F 的特征值分解的子集
    [U, Lambda] = eigs(F' * F, size(F, 2));

    % 计算 Q = F^(-T) * L * F^(-1)
    sqrtLambda_inv = diag(1./sqrt(diag(Lambda))); % 取Lambda的平方根的逆
    Q = U * sqrtLambda_inv * (U' * Calculate_Matrix_L(S) * U) * sqrtLambda_inv * U';
end
