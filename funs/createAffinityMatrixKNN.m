function A = createAffinityMatrixKNN(X, k)
    numPoints = size(X, 2);
    A = zeros(numPoints, numPoints);
    
    % 计算距离矩阵
    D = pdist2(X', X');
    
    % 对于每个点，找到最近的k个邻居并更新亲和矩阵
    for i = 1:numPoints
        [~, idx] = sort(D(i, :), 'ascend');
        nearestNeighbors = idx(2:k+1); % 排除自身
        A(i, nearestNeighbors) = 1;  % 或者使用其他非零值
    end
    
    % 使矩阵对称
    A = max(A, A');
end
