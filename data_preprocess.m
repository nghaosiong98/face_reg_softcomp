%% Crop face
subjects = dir(fullfile('photos', '*'));
subjects = {subjects.name};
subjects(ismember(subjects, {'.', '..'})) = []; % remove . and ..

for sub = subjects
    ds = imageDatastore(strcat('photos\',sub),'IncludeSubfolders',true,'LabelSource','foldernames');
    cropandsave(ds,string(sub));
end