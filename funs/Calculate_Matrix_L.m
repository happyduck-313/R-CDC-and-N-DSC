% Calculate normalized Laplacian matrix
function L_norm = Calculate_Matrix_L(W)
    degree = sum(W, 2);  
    
    degree(degree == 0) = 1;
    
    D_neg_sqrt = diag(degree.^(-0.5));
    
    L_norm = eye(size(W)) - D_neg_sqrt * W * D_neg_sqrt;
end
