function [allFeatureVectors, allLabels] = training()
    % read the directory and check if it's existed
    training = '/home/azizax/Desktop/dataset';
    if ~isdir(training)
        return;
    end
    
    % read training data
    jpegFiles = dir(strcat(training,'*.png'));
    
    % read each file name -> read image -> reverese 1 to 0 and 0 to 1 ->
    % divide to blocks -> calculate centroid of each block -> all centroid
    % of all blocks is feature vector.
    for k = 1: numel(jpegFiles)
        baseFileName = jpegFiles(k).name;
        fullFileName = strcat(training,'/',baseFileName);
        
        allLabels{k} = substring(baseFileName, 0, find(baseFileName, '_') - 1);

        image = imread(fullFileName);
        
       allFeatureVectors{k} = HoG(image);
    end
    save '/home/azizax/Desktop/dataset/training.mat' allFeatureVectors allLabels;
end