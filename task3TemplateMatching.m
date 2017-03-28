circle = rgb2gray(imread('/home/azizax/Documents/fci/Second/ComputerVision/Tasks/task3-TemplateMatching/football.jpeg'));
circles = rgb2gray(imread('/home/azizax/Documents/fci/Second/ComputerVision/Tasks/task3-TemplateMatching/footballs.jpg'));
 cc = normxcorr2(circle,circles);
 [max_cc,imax] =max(abs(cc(:)));
 sprintf('highest matching %f',max_cc)
 [y_maxx,x_maxx] = ind2sub(size(cc),imax(1))
 yoffSet = y_maxx-size(circle,1);
xoffSet = x_maxx-size(circle,2);
hAx  = axes;
imshow(circles,'Parent', hAx);
imrect(hAx, [xoffSet+1, yoffSet+1, size(circle,2), size(circle,1)]);