function [ pano ] = Panorama( img1,img2 )
ref = img1;
ref=rgb2gray(ref);
ref_trunc = ref;    

reference = imagematch;
reference.set_image(ref_trunc);
reference.get_featurepoints();
reference.get_descriptors();
T = maketform('affine',[.35 -.1 0; -.1 .35 0; 0 0 1]); % Note that this is heavy deformation; if you want to get more consistent results try lessening the magnitude of shear
tformfwd([10 20],T);

cur =img2;
cur=rgb2gray(cur);
current = imagematch;
current.set_image(cur);
current.get_featurepoints();
current.get_descriptors();

%% Match points
matchpoints = imagematch.get_matchpoints(reference,current);
%imagematch.plot_matchpoints(reference,current,matchpoints);
image1 = [matchpoints.x_ref;matchpoints.y_ref];
image1= image1';
image2 = [matchpoints.x_cur;matchpoints.y_cur];
image2= image2';
 tforms = estimateGeometricTransform(image1,image2,'projective','Confidence',10.0,'MaxNumTrials',1000);
  pano=imwarp(img1,img2,tforms);
    imshow(pano);