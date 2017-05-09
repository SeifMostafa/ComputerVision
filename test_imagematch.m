% This is a driver file to use the imagematch object. It uses a test image
% called 'test.tif', and uses a subset of the image for the reference
% image. It then applies a transformation to the reference image and finds
% where the reference image is located within the current image.

%% Set Reference Image; get feature points and descriptors
ref = imread('Picture11.jpg');
ref=rgb2gray(ref);
ref_trunc = ref;%(70:230,30:200);

reference = imagematch;
reference.set_image(ref_trunc);
reference.get_featurepoints();
reference.get_descriptors();
reference.plot_featurepoints();

%% Set Current Image; get feature points and descriptors
T = maketform('affine',[.35 -.1 0; -.1 .35 0; 0 0 1]); % Note that this is heavy deformation; if you want to get more consistent results try lessening the magnitude of shear
tformfwd([10 20],T);
%cur = imtransform(ref,T);
cur = imread('Picture22.jpg');
cur=rgb2gray(cur);
current = imagematch;
current.set_image(cur);
current.get_featurepoints();
current.get_descriptors();
current.plot_featurepoints();

%% Match points
matchpoints = imagematch.get_matchpoints(reference,current);
imagematch.plot_matchpoints(reference,current,matchpoints);

%% Pose estimation
mat_pose = imagematch.get_pose(reference,current,matchpoints);
imagematch.plot_pose(reference,current,mat_pose);

%% Optional - View the gaussian pyramid for current and reference images;
reference.plot_pyramid();
current.plot_pyramid();