# Direct Spectral Clustering with New Graph Learning

## Overview
This repository implements the algorithm from the paper *"Direct Spectral Clustering with New Graph Learning for Better Fitting"* (Kong et al., 2025), which introduces a new graph learning technique for spectral clustering.

## Key Features
- Implements **N-DSC** and **R-CDC** clustering algorithms.
- Provides an experimental framework for testing various lambda values.
- Records clustering performance metrics: Accuracy, NMI, Purity, Precision, Recall, F-measure, Rand Index (RI), and SDCS.

## File Description
- **exp_mywork.m**: Main script for running experiments with dataset loading, graph construction, and clustering algorithms.
- **funs/**: Folder with helper functions for clustering and graph construction.
- **Iris Dataset**: The dataset used in the experiments, compatible with others following a similar structure.

## Requirements
- MATLAB (R2021 or later)
- Functions in `funs/` must be in the MATLAB path.
- Dataset (`iris_uni`) should be in the same directory or specified in the script.

## Installation
1. Clone the repository or download the files.
2. Open MATLAB and navigate to the folder.
3. Add `funs/` folder to your MATLAB path.
4. Ensure the dataset (`iris_uni`) is available or modify the `datasetFile` variable.

## Running the Code
1. Open **exp_mywork.m** in MATLAB.
2. Set the `datasetFile` variable to your dataset (e.g., `iris_uni`).
3. Modify parameters (`t`, `lambda`, `numIter`, `algorithmChoice`).
4. Run the script. Results will be saved to a text file (e.g., `iris_uni_largexp_mywork.txt`).



## Citation

If you use this code in your research, please cite the following paper:

```bibtex
@article{kong2025direct,
  title={Direct Spectral Clustering with New Graph Learning for Better Fitting},
  author={Kong, Lingyi and Xue, Jingjing and Nie, Feiping and Li, Xuelong},
  journal={IEEE Transactions on Knowledge and Data Engineering},
  year={2025},
  publisher={IEEE}
}
