% Stitching two images together using something simpler and better
% than in the "bigsur.m" script
%
% Cris Luengo, April 2011.
%
% Requires the DIPimage toolbox: http://www.diplib.org/


a = imread('C:\Users\AzizaX\Desktop\Matlab\project\pano\ex1\Picture1.jpg');
b = imread('C:\Users\AzizaX\Desktop\Matlab\project\pano\ex1\Picture2.jpg');

sz = size(a);

% Figure out how images align
if 0
   dipshow(1,a);
   ca = dipgetcoords(1,1);
   dipshow(1,b);
   cb = dipgetcoords(1,1);
else
   % (I clicked on the same rock in both pictures, these are the results)
   ca = [764,227];
   cb = [103,215];
end
s = ca - (cb+[sz(1),0]);

% Extend images -- assuming [a,b] is the general alignment
z = (sz);
a = iterate('cat',1,a,z);
b = iterate('cat',1,z,b);

% Align images
b = iterate('dip_wrap',b,s);

% Crop images
a = a(0:imsize(a,1)+s(1)-1,:);
b = b(0:imsize(b,1)+s(1)-1,:);
if s(2)>0
   a = a(:,s(2):imsize(a,2)-1);
   b = b(:,s(2):imsize(b,2)-1);
else
   a = a(:,0:imsize(a,2)+s(2)-1);
   b = b(:,0:imsize(b,2)+s(2)-1);
end

   % This is the same as the images 'bigsur1x.jpg' and 'bigsur2x.jpg' on the
   % original blog post

% Difference image
d = max(abs(a-b));
d(0:sz(1)-1+s(1),:) = 0;
d(sz(1):imsize(d,1)-1,:) = 0;

   % As 'bigsur_diff.jpg', but without the inversion.

% Seeds image
c = newim(d,'sint8');
c(0:sz(1)+s(1),:) = 1;
c(sz(1)-1:imsize(d,1)-1,:) = 2;

% Ordered region growing -- more or less the same as watershed + graph cut
c = dip_growregions(c,d,[],1,0,'high_first');
w = c==2;

   %writeim(w*255,'bigsur_mask_new.jpg','jpeg')

% Compose
out = a;
out(w) = b(w);

   %writeim(out,'bigsur_new.jpg','jpeg')

stitch4 = out(sz(1)+s(1):sz(1)-1,:);

% Alternative: simple compose
m = newim(w,'bin');
m(round(imsize(m,1)/2):end,:) = 1;
out = a;
out(m) = b(m);
stitch1 = out(sz(1)+s(1):sz(1)-1,:);

% Alternative: simple compose with blur
m = gaussf(m,3);
out = a*(1-m) + b*m;
stitch2 = out(sz(1)+s(1):sz(1)-1,:);

% Alternative: the composition I made in the original blog post
out = readim('bigsur.jpg');
stitch3 = out(sz(1)+s(1):sz(1)-1,:);

% Side-by-side comparison of stitchings
stitch = iterate('cat',1,stitch2,stitch3,stitch4);
stitch = stitch(:,round(imsize(stitch,2)/2):imsize(stitch,2)-1);

   %writeim(stitch,'bigsur_3stitches_new.jpg','jpeg')
