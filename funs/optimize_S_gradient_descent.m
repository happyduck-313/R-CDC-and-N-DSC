function [S_optimal, errors] = optimize_S_gradient_descent(B, alpha, max_iter, tol)
    % 输入参数:
    % B: 稀疏矩阵
    % alpha: 学习率
    % max_iter: 最大迭代次数
    % tol: 收敛阈值

    % 初始化 S 为 B
    S = B;
    n = size(B, 2);

    % 初始化 errors 数组来存储每次迭代的误差
    errors = zeros(1, max_iter);

    % 迭代优化
    for iter = 1:max_iter
        % 梯度下降更新
        grad = 2 * (S - B);
        S_new = S - alpha * grad;

        % 投影到约束集
        S_new = max(S_new, 0); % 确保 S >= 0
        S_new = S_new * diag(1 ./ sum(S_new, 1)); % 确保每列和为 1
        S_new = 0.5 * (S_new + S_new'); % 确保对称性

        % 计算并存储误差
        errors(iter) = norm(S_new - B, 'fro')^2;

        % 检查收敛
        if norm(S_new - S, 'fro') < tol
            errors = errors(1:iter); % 裁剪未使用的部分
            break;
        end

        S = S_new;
    end

    S_optimal = S;

    % 绘制误差图
    figure;
    plot(1:length(errors), errors, 'LineWidth', 2);
    xlabel('Iteration');
    ylabel('||S - B||^2');
    title('Error vs. Iteration');
    grid on;
end
