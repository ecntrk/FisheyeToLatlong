function [result] = grilledFish( inp )
% takes a fisheye HDR image and coverts it into latitude longitude format
    img = hdrimread(inp);
    result = doJob(img);
    %RemoveSpecials(ClampImg(result, 1e-9, max(result(:))));
end

function [op] = doJob(img)

    [h, w, ~] = size(img); 
    r = floor(h/2);
    h1 = floor(h);
    op = zeros(h/2, h1, 3);
    
    deltheta = (pi/2)/(r);
    delphi = (2*pi)/(h1);
    for j = 1:r %theta loop
        for i = 1:h1 %phi loop
            theta = deltheta*(j);% Pi / 2*h
            phi = delphi*(i); % 2*Pi / w
            a = r*cos(theta);
            x1 = a*cos(phi);
            y1 = a*sin(phi);
            if (x1<=0 && y1 <=0)
                x = ceil(x1) + (w/2)+1;
                y = ceil(y1) + (h/2)+1;
            elseif (x1>0 && y1 <=0)
                x = floor(x1) + (w/2)-1;
                y = ceil(y1) + (h/2)+1;
            elseif (x1<=0 && y1>0)
                x = ceil(x1) + (w/2)+1;
                y = floor(y1) + (h/2)-1;
            elseif (x1>0 && y1>0)
                x = floor(x1) + (w/2)-1;
                y = floor(y1) + (h/2)-1;                
            end
                

            if (sanityCheck(x,y,w,h)==true)
            op ( r-j +1, (h1)-i+1, :) = img(y, x, :);
            end           
        end
    end
    
end


function isTrue = sanityCheck(x,y, w, h)
if isnan(x) || isnan (y)
    isTrue = false;
    return;
end
    
if (x>0) && (x <= w)
    if (y>0) && (y <=h)
        isTrue = true;
    else 
        isTrue = false;
        return;
    end
else
    isTrue = false;
    return;
end

end

