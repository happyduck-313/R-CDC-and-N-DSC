% Calculate normalized Laplacian matrix
function L = Calculate_Matrix_L(W)
    degreeMatrix = sum(W, 2);  
    L = diag(degreeMatrix) - W; 
end