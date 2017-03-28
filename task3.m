 if exist('model.mat','file')
    load model;
 else
    pathPos = '/home/azizax/Documents/fci/Second/ComputerVision/Tasks/HoG-HumanDetector/HoG/data/caltech_faces/Caltech_CropFaces';
pathNeg  = '/home/azizax/Documents/fci/Second/ComputerVision/Tasks/HoG-HumanDetector/HoG/data/train_non_face_scenes';

    [fpos, fneg] = features(pathPos, pathNeg);  % extract features
    [ model ] = trainSVM( fpos,fneg );          % train SVM
    save model model;
 end