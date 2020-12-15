%__________________________________________________________________________

% This project contains the scripts associated to the manuscript "Disentangling
% consciousness from sleep, anesthesia, and patients with disorders of consciousness
% using interpretable deep learning."
%
% This script is EEG preprocessing using EEGLAB toolbox based on MATLAB.
%
%__________________________________________________________________________
%
% Please cite this function as:
% Lee M, 2021: (a further notice)
% minjilee@korea.ac.kr
%
%__________________________________________________________________________
%
% <data input>
% nbchan = number of channels (e.g., 60)
% data = 2D matrix (channel * sample)
% srate = sampling rate (e.g., 1450)
%
% <script output>
% eegData = 3D matrix (channel * sample * trial)
%
%% data load


EEG = pop_importdata('dataformat','matlab','nbchan',60,'data',data,'srate',1450,'xmin',0);
EEG = pop_importevent( EEG, 'event','\0_Raw Data\Trigger.txt','fields',{'type' 'latency' 'duration'},'skipline',1,'timeunit',1E-3);
EEG = pop_resample( EEG, 362.5);
EEG = pop_eegfilt( EEG, 0.5, 0, [], [0], 0, 0, 'fir1', 0);
EEG = pop_eegfilt( EEG, 0, 45, [], [0], 0, 0, 'fir1', 0);
EEG = pop_reref( EEG, []);

EEG = pop_chanedit(EEG, 'lookup','F:\\0_Codes\\0_Toolbox\\eeglab14_1_2b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','load',{'F:\\0_Codes\\3_Codes (KU)\\2017_Sleep(TMS-EEG)_Network\\SpecificData\\60chansCED.ced' 'filetype' 'autodetect'});
num = []; % interpolated EEG channel number
EEG = pop_interp(EEG, [num], 'spherical');
EEG = pop_saveset( EEG, 'filename',curFile2,'filepath','\1_PreprocessedData\');


%% Artifact removal using ICA

EEG = pop_loadset('filename',curFile,'filepath','\1_PreprocessedData\');
EEG = pop_epoch( EEG, {    }, [0 1]);
EEG = pop_runica(EEG, 'extended',1,'interupt','on');

com_num = []; % rejected EEG component number
EEG = pop_subcomp( EEG, [com_num], 0);
[EEG Indexes] = pop_eegthresh(EEG,1,[1:60] ,-100,100,0,2,2,0); % a threshold of ¡¾100 ¥ìv 

EEG = pop_rejepoch( EEG, Indexes ,0);
fname1 = ['Pre_',curFile]; % file name
EEG = pop_saveset( EEG, 'filename',fname1,'filepath','\3_clean_EEG\');

eegData = EEG.data;
save eegData
