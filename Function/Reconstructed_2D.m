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
% class_R = 3D matrix (sample * 2D mesh(10*11))
%
% <script output>
% class_Channel = 2D matrix (sample * channel(e.g., 60))
%
%%
function class_Channel = Reconstructed_2D(class_R)

class_Channel = zeros(size(class_R,1),60);

for i = 1:10
    if i == 1
        class_Channel(:,1) = squeeze(class_R(:,i,4));
        class_Channel(:,2) = squeeze(class_R(:,i,6));
        class_Channel(:,3) = squeeze(class_R(:,i,8));
    end
    if i == 2
        class_Channel(:,4) = squeeze(class_R(:,i,5));
        class_Channel(:,5) = squeeze(class_R(:,i,6));
        class_Channel(:,6) = squeeze(class_R(:,i,7));
    end
    if i == 3
        class_Channel(:,7) = squeeze(class_R(:,i,2));
        class_Channel(:,8) = squeeze(class_R(:,i,4));
        class_Channel(:,9) = squeeze(class_R(:,i,5));
        class_Channel(:,10) = squeeze(class_R(:,i,6));
        class_Channel(:,11) = squeeze(class_R(:,i,7));
        class_Channel(:,12) = squeeze(class_R(:,i,8));
        class_Channel(:,13) = squeeze(class_R(:,i,10));
    end
    if i == 4
        k = 1;
        for j = 14:24
            class_Channel(:,j) = squeeze(class_R(:,i,k));
            k = k+1;
        end
    end
    if i == 5
        k = 2;
        for j = 25:33
            class_Channel(:,j) = squeeze(class_R(:,i,k));
            k = k+1;
        end
    end
    if i == 6
        k = 1;
        for j = 34:44
            class_Channel(:,j) = squeeze(class_R(:,i,k));
            k = k+1;
        end
    end
    if i == 7
        class_Channel(:,45) = squeeze(class_R(:,i,1));
        class_Channel(:,46) = squeeze(class_R(:,i,2));
        class_Channel(:,47) = squeeze(class_R(:,i,4));
        class_Channel(:,48) = squeeze(class_R(:,i,5));
        class_Channel(:,49) = squeeze(class_R(:,i,6));
        class_Channel(:,50) = squeeze(class_R(:,i,7));
        class_Channel(:,51) = squeeze(class_R(:,i,8));
        class_Channel(:,52) = squeeze(class_R(:,i,10));
        class_Channel(:,53) = squeeze(class_R(:,i,11));
    end
    if i == 8
        class_Channel(:,54) = squeeze(class_R(:,i,5));
        class_Channel(:,55) = squeeze(class_R(:,i,6));
        class_Channel(:,56) = squeeze(class_R(:,i,7));
    end
    if i == 9
        class_Channel(:,57) = squeeze(class_R(:,i,5));
        class_Channel(:,58) = squeeze(class_R(:,i,6));
        class_Channel(:,59) = squeeze(class_R(:,i,7));
    end
    if i == 10
        class_Channel(:,60) = squeeze(class_R(:,i,6));
        
    end
end
