%__________________________________________________________________________

% This project contains the scripts associated to the manuscript "Disentangling
% consciousness from sleep, anesthesia, and patients with disorders of consciousness
% using interpretable deep learning."
%
% This script is converted EEG input for calculating ECI based on MATLAB.
%
%__________________________________________________________________________
%
% Please cite this function as:
% Lee M, 2021: (a further notice)
% minjilee@korea.ac.kr
%
%__________________________________________________________________________
%
% <script input>
% eegData = 3D matrix (channel * sample * trial)
%
% <script output>
% img = 4D matrix (trial * 2D mesh * sample)
% img_labels = 2D matrix (num. of trials * 1)
%
%%

addpath('\SpecificFunction');

SpatialInfor = Converted_4D(eegData); 

img1 = SpatialInfor;
img = permute(img1,[4 1 2 3]); 
img_labels = zeros(size(img,1),1);

for i=1:size(img1,4)
    img_labels(i,1) = 1; % prediction label: low = 1; high = 2 
end

save ConvertedData.mat img img_labels
