%__________________________________________________________________________
%
% This project contains the scripts associated to the manuscript "Disentangling
% consciousness from sleep, anesthesia, and patients with disorders of consciousness
% using interpretable deep learning."
%
% This script is the scatter plot for the explainable consciousness indicator (ECI).
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
% ECI = 2D matrix (num. of sessin * 3 (ECI^aro/ECI^awa/Group))
% or
% ECI = 2D matrix (num. of sessin * 3 (PCI/ECI^awa/Group))
%
%%

nECI = sortrows(ECI,3); 

X = nECI(:,1:2);
G = nECI(:,3);

figure()
gscatter(X(:,1), X(:,2), G); axis equal, hold on;
xlim([0 1]); ylim([0 1]);

hold on; line([0 1], [0.5 0.5]) % optimal-cutoff for awareness 
hold on; line([0.5 0.5], [0 1]) % optimal-cutoff for arousal
hold on; line([0.31 0.31], [0 1]) % optimal-cutoff for PCI
