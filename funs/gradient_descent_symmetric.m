function S = gradient_descent_symmetric(B, max_iter, tol, alpha)
    % B: 非对称矩阵
    % max_iter: 最大迭代次数
    % tol: 收敛容忍度
    % alpha: 学习率 (步长)
    
    % 初始化 S 为 B 的对称部分
    S = (B + B') / 2;
    
    % 迭代优化
    for k = 1:max_iter
        % 计算梯度
        grad = 2 * (S - B);
        
        % 梯度下降步骤
        S_new = S - alpha * grad;

        % 投影步骤：将 S_new 投影到对称矩阵空间
        S_new = (S_new + S_new') / 2;
        norm(S_new - S, 'fro')^2
        
        % 检查收敛性
if norm(S_new - S, 'fro') < tol
            break;
end
S=S_new;
    end
    
    % 如果没有收敛，给出警告
    if k == max_iter
        warning('Max iterations reached without convergence');
    end
end
