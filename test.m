    function test()
    test = imread('/home/azizax/Desktop/yes_19.png');
    featureVector = HoG(test);
    
    %[allFeatureVectors, allLabels] = training();
    load '/home/azizax/Desktop/training.mat' allFeatureVectors allLabels;
    
    minIndex = 0;
    minValue = 99999999999999;
    d = zeros(1, numel(allFeatureVectors));
    for v = 1:numel(allFeatureVectors)
        temp = 0;
        for i = 1:numel(allFeatureVectors{v})
            for j  = 1:numel(featureVector{i})
                for k = 1:numel(featureVector{i}{j})
                    for l = 1:numel(featureVector{i}{j}{k})
                        for c = 1:numel(featureVector{i}{j}{k}{l})
                            temp = temp + abs(allFeatureVectors{v}{i}{j}{k}{l}(c) - featureVector{i}{j}{k}{l}(c));
                        end
                    end
                end
            end
        end
        d(v) = temp;
    end
    [m idx] = min(d);
    allLabels{idx}
    idx
    d
end