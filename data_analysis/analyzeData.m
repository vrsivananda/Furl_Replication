% This script goes through the data, subject-by-subject, and analyzes them. 
% This analyzes the data in a data structure form by default, but you can
% change it to analyze the cell array or other data if you have it

clear;
close all;

% Switches and dynamic parameters
saveFigure = 0; % Save the figure
nTrials = 469; % Number of trials in dataStructure
choseDThreshold = 0.20; % %_chosenD to determine discarding


% Create a path to the text file with all the subjects
path='subjects1-2.txt';
% Make an ID for the subject list file
subjectListFileId=fopen(path);
% Read in the number from the subject list
numberOfSubjects = fscanf(subjectListFileId,'%d');

% Gatekeeping variables
discarded.incompleteData = {};
discarded.choseDAboveThreshold = {};

% Define the structure array
percentChosen.T.matrix  = [];
percentChosen.NT.matrix = [];
percentChosen.D.matrix  = [];

percentChosen.T.linReg  = [];
percentChosen.NT.linReg = [];
percentChosen.D.linReg  = [];

percentChosen.n_distractorRanks  = [];


% For loop that loops through all the subjects
for i = 1:numberOfSubjects
    
    % Read the subject ID from the file, stop after each line
    subjectId = fscanf(subjectListFileId,'%s',[1 1]);
    % Print out the subject ID
    fprintf('subject: %s\n',subjectId);
    
    % Import the data
    Alldata = load([pwd '/Data/structure_data_' subjectId '.mat']);
    % Data structure that contains all the data for this subject
    dataStructure = Alldata.data;
    
    
    % ------ Run Gatekeepers ------
    % Gatekeeper #1
    % Check if they have enough trials
    incompleteData = check_incompleteData(dataStructure, nTrials);
        
    % Gatekeeper #2
    %Check if they answered distractor a certain amount
    choseDAboveThreshold = check_choseDAboveThreshold(dataStructure, choseDThreshold);
    
    % If it has less than the number of trials we want, then we store the
    % subjectId and continue to the next subject
    if(incompleteData)
        
        discarded.incompleteData{size(discarded.incompleteData,1)+1,1} = subjectId;
        continue;
        
    % If the subject chose distractor above the threshold, then we store the
    % subjectId and continue to the next subject
    elseif(choseDAboveThreshold)
        
        discarded.choseDAboveThreshold{size(discarded.choseDAboveThreshold,1)+1,1} = subjectId;
        continue;
        
    % Else we continue with the analyzing the data
    else
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%% Your data extraction here %%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        percentChosen = getPercentChosen(dataStructure, percentChosen);
    
    
    
    
    
    end % End of gatekeeping
    
end % End of for loop that loops through each subject


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Your analysis here %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Analyze the percentChosen
percentChosen = analyzePercentChosen(percentChosen);

% Plot %_choseT vs D_Rank
plot_percentChosen(percentChosen, saveFigure);







