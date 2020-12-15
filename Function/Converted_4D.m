%__________________________________________________________________________

% This project contains the scripts associated to the manuscript "Disentangling
% consciousness from sleep, anesthesia, and patients with disorders of consciousness
% using interpretable deep learning."
%
% This script is converted EEG input for calculating ECI based on MATLAB.
% The EEG signals are converted from 60 channels to 2D mesh (10*11) using spatial
% information based on EEG channel location. More details are shown in
% Suppl. Fig. S10.
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
% SpatialInfor = 4D matrix (2D mesh * sample * trial)
%
%%

function SpatialInfor = Converted_4D(eegData)

nTrials = size(eegData,3);
nRange = size(eegData,2);
SpatialInfor = zeros(10,11,nRange,nTrials);

for j = 1:nRange
    SpatialInfor(1,4,j,:) = eegData(1,j,:); % mean 0-400 msec data
    SpatialInfor(1,6,j,:) = eegData(2,j,:); % mean 0-400 msec data
    SpatialInfor(1,8,j,:) = eegData(3,j,:); % mean 0-400 msec data
    
    SpatialInfor(2,5,j,:) = eegData(4,j,:); % mean 0-400 msec data
    SpatialInfor(2,6,j,:) = eegData(5,j,:); % mean 0-400 msec data
    SpatialInfor(2,7,j,:) = eegData(6,j,:); % mean 0-400 msec data
    
    SpatialInfor(3,2,j,:) = eegData(7,j,:); % mean 0-400 msec data
    SpatialInfor(3,4,j,:) = eegData(8,j,:); % mean 0-400 msec data
    SpatialInfor(3,5,j,:) = eegData(9,j,:); % mean 0-400 msec data
    SpatialInfor(3,6,j,:) = eegData(10,j,:); % mean 0-400 msec data
    SpatialInfor(3,7,j,:) = eegData(11,j,:); % mean 0-400 msec data
    SpatialInfor(3,8,j,:) = eegData(12,j,:); % mean 0-400 msec data
    SpatialInfor(3,10,j,:) = eegData(13,j,:); % mean 0-400 msec data
    
    
    k = 1;
    for i = 14:24
        SpatialInfor(4,k,j,:) = eegData(i,j,:); % mean 0-400 msec data
        k = k+1;
    end
    
    k = 1;
    for i = 25:33
        SpatialInfor(5,k+1,j,:) = eegData(i,j,:); % mean 0-400 msec data
        k = k+1;
    end
    
    k = 1;
    for i = 34:44
        SpatialInfor(6,k,j,:) = eegData(i,j,:); % mean 0-400 msec data
        k = k+1;
    end
    
    k = 1;
    for i = 45:53
        if k == 3
            k = k+1;
        end
        
        if k == 9
            k = k+1;
        end
        
        SpatialInfor(7,k,j,:) = eegData(i,j,:); % mean 0-400 msec data
        k = k+1;
    end
    
    SpatialInfor(8,5,j,:) = eegData(54,j,:); % mean 0-400 msec data
    SpatialInfor(8,6,j,:) = eegData(55,j,:); % mean 0-400 msec data
    SpatialInfor(8,7,j,:) = eegData(56,j,:); % mean 0-400 msec data
    
    SpatialInfor(9,5,j,:) = eegData(57,j,:); % mean 0-400 msec data
    SpatialInfor(9,6,j,:) = eegData(58,j,:); % mean 0-400 msec data
    SpatialInfor(9,7,j,:) = eegData(59,j,:); % mean 0-400 msec data
    
    SpatialInfor(10,6,j,:) = eegData(60,j,:); % mean 0-400 msec data
end

