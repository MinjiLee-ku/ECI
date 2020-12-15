%__________________________________________________________________________

% This project contains the scripts associated to the manuscript "Disentangling
% consciousness from sleep, anesthesia, and patients with disorders of consciousness
% using interpretable deep learning."
%
% This script is for plotting topo plot.
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
% Topo = 2D matrix (channel * 1)
% poslocs = channel location
% 
%%

addpath('\eeglab14_1_2b') % EEGLAB toolbox

load('Topo.mat ')
load('poslocs.mat'); % 60 channels in this study

figure; set(gcf,'Color',[1,1,1]); 
topoplot(Topo,poslocs,'conv','on'); colormap(jet); set(gcf,'Color',[1,1,1]); 



