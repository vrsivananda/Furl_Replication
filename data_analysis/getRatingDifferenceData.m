function ratingDifferenceData = getRatingDifferenceData(dataStructure, ratingDifferenceData)
   
    % Get the trials where we're rating similarity
    attractivenessRating_TrialIndices = returnIndicesIntersect(dataStructure.trial_type,'image-slider-response');
    secondRating_Indices = attractivenessRating_TrialIndices((length(attractivenessRating_TrialIndices)/2)+1:end);
    
    % Get the relevant arrays for sorting
    gender = dataStructure.gender(attractivenessRating_TrialIndices);
    attractivenessRatings = dataStructure.response(attractivenessRating_TrialIndices);
    faceNumbers = dataStructure.faceNumber(attractivenessRating_TrialIndices);
    
    % Sort the arrays: gender --> faceNumber
    [faceNumbers, sortingIndex] = sort(faceNumbers);
    gender = gender(sortingIndex);
    attractivenessRatings = attractivenessRatings(sortingIndex);
    
    [gender, sortingIndex] = sort(gender);
    attractivenessRatings = attractivenessRatings(sortingIndex);
    faceNumbers = faceNumbers(sortingIndex);
    
    difference = attractivenessRatings(1:2:59)-attractivenessRatings(2:2:60);
    difference = abs(difference);
    
    % Load into ratingDifferenceData
    ratingDifferenceData = [ratingDifferenceData, difference];
    
end