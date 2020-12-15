%__________________________________________________________________________
%
% This project contains the scripts associated to the manuscript "Disentangling
% consciousness from sleep, anesthesia, and patients with disorders of consciousness
% using interpretable deep learning."
%
% This script is the violin plot for the layer-wise relevance propagation (LRP).
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
% R = relevance scores for input (4D matrix; # of trials * 2D mesh(10*11) * sample)
%
%% data load

addpath('\SpecificFunction'); % LRP toolbox / violin
import model_io.*
import data_io.*
import render.*

folders = dir('\Final_Results');
nfolders = {folders.name};
folders = nfolders(3:end); 

for i = 1:length(folders)
    
    curFile = folders{i};
    load(curFile);
    
    class1_R = mean(R,4);
    
    % reconstruction: 3D -> 2D
    class1_Channel = Reconstructed_2D(class1_R);
    %
    % spatial region [Toth et a., Int. J. Psychophysiol., 2014]
    frontal = [1:13];
    temporal = [14,24:25,33:34,44];
    parietal = [36:42, 46:52];
    
    class1_frontal(i,1) = mean(mean(class1_Channel(:,frontal),2));
    class1_temporal(i,1) = mean(mean(class1_Channel(:,temporal),2));
    class1_parietal(i,1) = mean(mean(class1_Channel(:,parietal),2));
    
end

%% statistics

% class1_frontal: averaged relevance score over frontal region in class 1
% class1_temporal: averaged relevance score over temporal region in class 1
% class1_parietal: averaged relevance score over parietal region in class 1

class1 = [class1_frontal class1_temporal class1_parietal]; % class1-NREM
[p,~,stats] = kruskalwallis(class1);
[results,means] = multcompare(stats,'CType','lsd')

figure();
[h, L, MX, MED] = violin(class1); 
