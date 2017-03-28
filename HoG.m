function [featureVector] = HoG(image)
    % read image
    % image = imread('C:\Users\ASUS\Desktop\data set\1.png');
    blockRows = 16;
    blockCols = 16;
    blockCellsRows = 2;
    blockCellsCols = 2;
    cellRows = blockRows / blockCellsRows;
    cellCols = blockCols / blockCellsCols;
    % transform colored image to gray level image
    image = rgb2gray(image);
    % append cols and rows
    [imRows, imCols] = size(image);
    
    numOfBlocksPerRows = floor((imRows - 1) / blockRows) + 1;
    numOfBlocksPerCols = floor((imCols - 1) / blockCols) + 1;

    imRows = numOfBlocksPerRows * blockRows;
    imCols = numOfBlocksPerCols * blockCols;
    image = imresize(image, [imRows imCols]);
    
    numOfBlocksPerRows = numOfBlocksPerRows * 2 - 1;
    numOfBlocksPerCols = numOfBlocksPerCols * 2 - 1;
    % get gradient of x and y
    [GX, GY] = gradient(double(image));
    % get magnitude and phase
    phase = atand(GX./GY); % Matrix containing the angles of each edge gradient
    phase = imadd(phase, 90); %Angles in range (0,180)
    magnitude = sqrt(GX.^2 + GY.^2);
    % divide to blocks
    magBlocks{numOfBlocksPerRows, numOfBlocksPerCols} = 0;
    phaseBlocks{numOfBlocksPerRows, numOfBlocksPerCols} = 0;
    rowStart = 1;
    for i = 1: numOfBlocksPerRows
        colStart = 1;
        for j = 1: numOfBlocksPerCols
            magBlocks{i, j} = magnitude(rowStart: rowStart + blockRows - 1, colStart: colStart + blockCols - 1);
            phaseBlocks{i, j} = phase(rowStart: rowStart + blockRows - 1, colStart: colStart + blockCols - 1);
            colStart = colStart + blockCols/2;
        end
        rowStart = rowStart + blockRows/2;
    end
    % loop on blocks and calculate feature vector
    for i = 1: numOfBlocksPerRows
        for j = 1: numOfBlocksPerCols
            % initialize feature vector
            for k = 1: blockCellsRows
                for l = 1: blockCellsCols
                    featureVector{i}{j}{k}{l} = zeros(1, 9);
                end
            end
            % calculate feature vector
            for k = 1: blockRows
                for l = 1: blockCols
                    tempPhase = phaseBlocks{i, j}(k, l);
                    tempMag = magBlocks{i, j}(k, l);
                    blockCellTempRow = floor((k - 1) / cellRows) + 1;
                    blockCellTempCol = floor((l - 1) / cellCols) + 1;
                    if tempPhase>10 && tempPhase<=30
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(1) = tempMag * (30 - tempPhase) /20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(1);
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(2) = tempMag * (tempPhase - 10) /20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(2);
                    elseif tempPhase>30 && tempPhase<=50
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(2) = tempMag * (50 - tempPhase) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(2);
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(3) = tempMag * (tempPhase - 30) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(3);
                    elseif tempPhase>50 && tempPhase<=70
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(3) = tempMag * (70 - tempPhase) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(3);
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(4) = tempMag * (tempPhase - 50) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(4);
                    elseif tempPhase>70 && tempPhase<=90
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(4) = tempMag * (90 - tempPhase) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(4);
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(5) = tempMag * (tempPhase - 70) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(5);
                    elseif tempPhase>90 && tempPhase<=110
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(5) = tempMag * (110 - tempPhase) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(5);
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(6) = tempMag * (tempPhase - 90) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(6);
                    elseif tempPhase>110 && tempPhase<=130
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(6) = tempMag * (130 - tempPhase) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(6);
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(7) = tempMag * (tempPhase - 110) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(7);
                    elseif tempPhase>130 && tempPhase<=150
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(7) = tempMag * (150 - tempPhase) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(7);
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(8) = tempMag * (tempPhase - 130) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(8);
                    elseif tempPhase>150 && tempPhase<=170
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(8) = tempMag * (170 - tempPhase) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(8);
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(9) = tempMag * (tempPhase - 150) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(9);
                    elseif tempPhase>=0 && tempPhase<=10
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(1) = tempMag * (10 + tempPhase) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(1);
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(9) = tempMag * (10 - tempPhase) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(9);
                    elseif tempPhase>170 && tempPhase<=180
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(9) = tempMag * (190 - tempPhase) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(9);
                        featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(1) = tempMag * (tempPhase - 170) / 20 + featureVector{i}{j}{blockCellTempRow}{blockCellTempCol}(1);
                    end
                end
            end
        end
    end
end