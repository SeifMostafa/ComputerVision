function  houghlines(im, h, thresh)

    [rows, cols] = size(im);  
    [nrho, ntheta] = size(h);
    
    rhomax = sqrt(rows^2 + cols^2);
    drho =  2*rhomax/(nrho-1);         
    
    dtheta = pi/ntheta;                % The increment in theta between entries.
    theta = [0:dtheta:(pi-dtheta)];    % Array of theta values across the accumulator matrix.
    
    [rhoindex,thetaindex] = nonmaxsuppts(h, 7)

    rho = drho*(rhoindex' - nrho/2);
    theta = dtheta*(thetaindex' - 1);
    
    x = [0; cols]*ones(1, length(rhoindex)) 
    y = [rho./sin(theta); (rho - x(2,:).*cos(theta))./sin(theta)]
    
    figure(1)
    imagesc(h), colormap(gray);
    hold
    plot(thetaindex, rhoindex,'rx')
    hold
    figure(2)
    line(x, y,'Color','r')