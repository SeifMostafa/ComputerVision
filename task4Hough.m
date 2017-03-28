I = rgb2gray(imread ('/home/azizax/Desktop/lines.jpg'));
h = hough(I,0.5,10,10);
houghlines(I,h,0.7);