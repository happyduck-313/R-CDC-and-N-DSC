# R-CDC-and-N-DSC
This project contains the MATLAB implementations of two clustering algorithms: Ratio Cut Clustering (R-CDC) and Normalized Cut Spectral Clustering (N-DSC). These methods are used for graph-based clustering tasks, where the objective is to partition a graph into clusters based on similarity metrics defined on the graph edges.

# Getting Started
## Dependencies
MATLAB (preferably R2023b or later)
Statistics and Machine Learning Toolbox for some of the clustering functionalities

## Installing
Clone this repository to your local machine using: 
`git clone https://github.com/happyduck-313/R-CDC-and-N-DSC.git`

## Example
Here's a basic example of how to run a clustering analysis:

Click demo.m to run the work function on the results of iris, where the data set is modified in `load("iris_uni");` and the function name is modified in `[label_out, obj, F_original, labelY_comparison] = work(A, c, 30, lambda);`

In exp_mywork.m, the results including ACC, ARI, etc. about different parameters are obtained by running and stored in txt. You can change `algorithmChoice = 1;` to choose the algorithm: 1 for work (N-DSC), 2 for work_Ratio (R-CDC)
