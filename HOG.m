function result = HOG(I)
%path for samples 
pathPos = 'C:\Users\AzizaX\Desktop\faces\';
 pathNeg = 'C:\Users\AzizaX\Desktop\non-faces\';
 imlist = dir([pathPos '*.jpg']);
 %% read samples and get feature vector for both samples and tested image
 TestedImageFV = HOGFV(I);
 MinDiff = TestedImageFV;
 human = 0; % human = 1 , else = -1 and the initial = 0
for i = 1:length(imlist)
    im = imread([pathPos imlist(i).name]);
    vec = HOGFV(double(im));
    C = subs(vec,TestedImageFV)
    if C< MinDiff
    MinDiff = C;
    human=1;
    end
end
% extract features for negative examples
imlist = dir([pathNeg '*.jpg']);
for i = 1:length(imlist)
    im = imread([pathNeg imlist(i).name]);
    vec =HOGFV(double(im));
    C = subs(vec,TestedImageFV)
    if C< MinDiff
    MinDiff = C;
    human=-1;
    end
end
if human ==1 
    result = 'Person';
else result ='not a person';
    
end

