%__________________________________________________________________________
%
% This project contains the scripts associated to the manuscript "Disentangling
% consciousness from sleep, anesthesia, and patients with disorders of consciousness
% using interpretable deep learning."
%
% This script is trained for CNN model and unseen data are tested for calculating 
% the explainable consciousness indicator (ECI).
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
% img = 4D matrix (trial * 2D mesh * sample) (e.g., #*10 *11*72(200-400ms))
% img_labels = 2D matrix (num. of trials * 1)
%
% <script output>
% final = 2D matrix (true label * predicted label)
% yscore = 2D matrix (interclass probability)
% R = relevance scores for input
% index = ECI for arousal or awareness in a single session
% acc = single-trial clssification accuracy in a single session
%
%% data load

addpath('\SpecificFunction'); % LRP toolbox
import model_io.*
import data_io.*
import render.*

folders = dir('\All_Data');
nfolders = {folders.name};
folders = nfolders(3:end); 

for i = 1:length(folders)
    
    curFile = folders{i};
    load(curFile);
    nTrial(i,1) = size(img_labels,1);
    
    if i == 1
        all_img = img;
        all_labels = img_labels;
    else
        all_labels = [all_labels; img_labels];
        all_img = [all_img; img];
    end
end

session = zeros(size(nTrial,1),2);

for k = 1:length(nTrial)
    if k == 1
        session(k,1) = 1;
        session(k,2) = nTrial(k,1);
    else
        session(k,1) = session(k-1,2) + 1;
        session(k,2) = session(k-1,2) + nTrial(k,1);
    end
end

Xtrain = all_img;
Ytrain = all_labels;

%%

for k = 1:length(session) % target subject
    
    %% OVR approach
    Xtrain = all_img;
    Ytrain = all_labels;
        
    n_curFile = folders{k};
    
    Xtest = Xtrain(session(k,1):session(k,2),:,:,:);
    Ytest = Ytrain(session(k,1):session(k,2),:);
       
    Xtrain(session(k,1):session(k,2),:,:,:) = [];
    Ytrain(session(k,1):session(k,2),:) = [];
         
    % data randomization
    n = size(Ytrain,1);
    ordering = randperm(n);
    Xtrain = Xtrain(ordering,:,:,:);
    Ytrain = Ytrain(ordering,:);
    
    nXtest = gpuArray(Xtest);
    nXtrain = gpuArray(Xtrain);
    nYtest = Ytest;
    nYtrain = Ytrain;
       
    % CNN
    
    I = nYtrain;
    nYtrain = zeros(size(nXtrain,1),2);
    nYtrain(sub2ind(size(nYtrain),1:size(nYtrain,1),I')) = 1;
    
    I = nYtest;
    nYtest = zeros(size(nXtest,1),2);
    nYtest(sub2ind(size(nYtest),1:size(nYtest,1),I')) = 1;
    
    
    %% train the CNN model
    
    % CNN architecture
    maxnet = modules.Sequential({
        modules.Convolution([3 3 72 100],[1 1]),
        modules.Rect(),
        modules.Convolution([2 2 100 80],[1 1]),
        modules.Rect(),
        modules.MaxPool([2 2],[1 2])
        modules.Convolution([3 3 80 60],[1 1]),
        modules.Rect(),
        modules.Convolution([2 2 60 40],[2 1]),
        modules.Rect(),
        modules.MaxPool([2 1],[2 1])
        modules.Convolution([1 1 40 2],[1 1]),
        modules.Flatten(),
        modules.SoftMax()
        });
    %
    learningrate = 0.005;
    
    numTimeStepsTrain = floor(0.8*size(nXtrain,1));
    Xtrain1 = nXtrain(1:numTimeStepsTrain+1,:,:,:);
    Ytrain1 = nYtrain(1:numTimeStepsTrain+1,:);
    Xtrain_val = nXtrain(numTimeStepsTrain+1:end,:,:,:);
    Ytrain_val = nYtrain(numTimeStepsTrain+1:end,:);
    
    maxnet.train(Xtrain1,Ytrain1,Xtrain_val,Ytrain_val,25, size(Xtrain1,1)*5,learningrate,'sublinear'); 
    
    %% test the target subject in single session
    
    clear yscore yt yp R final final_prob
   
    for i = 1:size(nYtest,1)
       
        x = nXtest(i,:,:,:);
        
       %% forward pass and prediction
        
        yscore(i,:) = maxnet.forward(x);
        [~,yt(i,:)] = max(nYtest(i,:)); % true label
        [~,yp(i,:)] = max(yscore(i,:)); % predicted label         
        R(i,:,:,:) = maxnet.lrp(yscore(i,:),'alphabeta',2); % relevance score
        
    end
    
    %% Results    
    
    final(:,1) = yt; final(:,2) = yp;          
    acc = length(find(yt == yp)) /  length(yt) * 100; % single-trial claasification performance     
    index = mean(yscore(:,2)); % averageing the inter-probability in a single session
    
    cd '\Final_Results'
    fname = ['Arousal_',n_curFile];
    save(fname, 'final', 'yscore', 'R', 'index','acc');
    
    fprintf( 'ECI^aro is %1.3f in a single session.\n', index )

end

