function incompleteData = check_incompleteData(dataStructure, nTrials)
    
    if(length(dataStructure.trial_index == nTrials))
        incompleteData = false;
    else
        incompleteData = true;
    end
    
end% End of function