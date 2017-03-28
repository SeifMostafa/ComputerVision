function h = hough(im, Thresh, nrho, ntheta)
    BW = edge(im,'canny', Thresh);
    
    [rows, cols] = size(im);
    
    h = zeros(nrho, ntheta);

    
    rhomax = sqrt(rows^2 + cols^2);    % The maximum possible value of rho.
    drho =  2*rhomax/(nrho-1);         % The increment in rho between successive entries
                                       % in the accumulator matrix. Remember we go between
                                       % +-rhomax.
    
                                       
    dtheta = pi/ntheta;                % The increment in theta between entries.
    theta = [0:dtheta:(pi-dtheta)];    % Array of theta values across the accumulator matrix.
    
    % To convert a value of rho or theta to its appropriate index in the array use:
    % rhoindex = round(rho/drho + nrho/2);
    % thetaindex = round(theta/dtheta + 1);

    
    for i = 1:rows
        for j = 1:cols
            if BW(i, j)                         % for each non-zero point 
                for thetaindex = 1:ntheta
                    rho = j*cos(theta(thetaindex)) + i*sin(theta(thetaindex));
                    rhoindex = round(rho/drho + nrho/2);
                    h(rhoindex, thetaindex) = h(rhoindex, thetaindex) + 1;
                end
            end
        end
    end