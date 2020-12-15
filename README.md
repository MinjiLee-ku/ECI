# Source code for the Explainable Consciousness Indicator (ECI)

This project contains the scripts associated to the manuscript "Disentangling consciousness from sleep, anesthesia, and patients with disorders of consciousness
using interpretable deep learning."

* Programming Language: MATLAB
* Contact: Minji Lee (minjilee@korea.ac.kr)

## Step 1: EEG preprocessing and converted data
The raw EEG signals were converted into spatiotemporal 3D matrix.

## Step 2: Training CNN 
The converted 3D feature was used on a convolutional neural network (CNN) in the two components of consciousness: arousal and awareness. 
In each arousal and awareness state, the EEG data were trained as two classes (low versus high). 
For training and test phase, we used the leave-one subject-out approach as transfer learning. 

## Step 3: Calculating ECI
The output indicates the probability was averaged for calculating ECI. Finally, relevance scores based on layer-wise relevance propagation (LRP) was calculated.

## Etc
Scatter plot & Topo plot & Violin plot

The EEGLAB toolbox is freely available at https://sccn.ucsd.edu/eeglab/download.php. Source code for CNN and LRP is freely available online at https://github.com/sebastian-lapuschkin/lrp_toolbox. Source code for violin plot is available from https://www.mathworks.com/matlabcentral/fileexchange/45134-violin-plot. Source code for shaded error bar is available from https://github.com/raacampbell/shadedErrorBar. 
