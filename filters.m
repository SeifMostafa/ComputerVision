I = imread ('/home/azizax/Desktop/lab2/simA.jpg');
h = fspecial('gaussian');
[GX,GY] = gradient(h);
imgFX = imfilter(I,GX);
imgFY = imfilter(I,GY);
imgFX = imgFX.*imgFX;
imgFY = imgFY.*imgFY;
newImg=imgFX.*imgFY;
imFX = imfilter(imgFX,h);
imFY = imfilter(imgFY,h);
imImg = imfilter(newImg,h);
[m,n] = size(I);
for i=1:m
   for j=1:n
   M=[imFX(i,j),imImg(i,j);imImg(i,j),imFY(i,j)];
   R(i,j)=det(double(M))-.04*((trace(M))*(trace(M)));
   end
end
imshow(R,[]);
for i=1:m
   for j=1:n
       if (R(i,j)<5000)
           R(i,j)=0;
       else R(i,j)=1;
       end
   end
end
figure;
imshow(R,[]);
%(imFX(i,j)*imFY(i,j)-(imImg(i,j)*imImg(i,j)))