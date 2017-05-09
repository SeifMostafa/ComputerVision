function stitch(imgFiles)
    
    assert(length(imgFiles) == 3);
    
    % compute sift feature vectors
    [sifts, siftLoc, images] = getSift(imgFiles);
    
    doStitch(sifts, siftLoc, images);
end