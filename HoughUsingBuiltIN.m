I = rgb2gray(imread ('/home/azizax/Documents/fci/Second/ComputerVision/Tasks/Hough-LineDetection/lines.jpg'));
rotI = imrotate(I,33,'crop');
BW = edge(rotI,'canny');
[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
