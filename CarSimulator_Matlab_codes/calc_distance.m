function dis = calc_distance(x, y, angle)
global road_backup;

new_x = x;  % next position of x in the image coordination
new_y = y;  % next position of y in the image coordination
angle = mod(angle + 360, 360);

plotState = 0;

% while the new point is inside the image
while(new_x < 720 && new_x > 0 && new_y > 0 && new_y < 660)
    
    [mapped_new_x, mapped_new_y] = map_axis(new_x, new_y);
    if(road_backup(mapped_new_x, mapped_new_y, 1) ~= 139)
        break;  % out of image
    end
    
    if plotState == 1
        plot_point(new_x, new_y);
    end
            
    if(angle == 0)
        new_x = new_x + 1;
        continue;
    elseif(angle == 90)
        new_y = new_y + 1;
        continue;
    elseif(angle == 180)
        new_x = new_x - 1;
        continue;
    elseif(angle == 270)
        new_y = new_y - 1;
        continue;
    end
    
    angle_backup = angle;
    if angle < 90
        
        angle = 90 - angle;
        %%
        rightPointX = new_x + 1;
        rightPointY = new_y;
        rightPointAngle = abs(atand((rightPointX - x)/(rightPointY - y)));
        
        upperPointX = new_x;
        upperPointY = new_y + 1;
        upperPointAngle = abs(atand((upperPointX - x)/(upperPointY - y)));
        
        upperRightPointX = new_x + 1;
        upperRightPointY = new_y + 1;
        upperRightPointAngle = abs(atand((upperRightPointX - x)/(upperRightPointY - y)));
        
        rightPointAngle = abs(rightPointAngle-angle);
        upperPointAngle = abs(upperPointAngle-angle);
        upperRightPointAngle = abs(upperRightPointAngle-angle);
        
        minDif = min([rightPointAngle upperPointAngle upperRightPointAngle]);
        if rightPointAngle == minDif
            new_x = rightPointX;
            new_y = rightPointY;
        elseif upperPointAngle == minDif
            new_x = upperPointX;
            new_y = upperPointY;
        else
            new_x = upperRightPointX;
            new_y = upperRightPointY;
        end
        
    elseif angle < 180
       %% 
       angle = angle - 90;
        leftPointX = new_x - 1;
        leftPointY = new_y;
        leftPointAngle = abs(atand((leftPointX - x)/(leftPointY - y)));
        
        upperPointX = new_x;
        upperPointY = new_y + 1;
        upperPointAngle = abs(atand((upperPointX - x)/(upperPointY - y)));
        
        upperLeftPointX = new_x -1;
        upperLeftPointY = new_y + 1;
        upperLeftPointAngle = abs(atand((upperLeftPointX - x)/(upperLeftPointY - y)));
        
        leftPointAngle = abs(leftPointAngle-angle);
        upperPointAngle = abs(upperPointAngle-angle);
        upperLeftPointAngle = abs(upperLeftPointAngle-angle);
        
        minDif = min([leftPointAngle upperPointAngle upperLeftPointAngle]);
        if leftPointAngle == minDif
            new_x = leftPointX;
            new_y = leftPointY;
        elseif upperPointAngle == minDif
            new_x = upperPointX;
            new_y = upperPointY;
        else
            new_x = upperLeftPointX;
            new_y = upperLeftPointY;
        end
        
        
    elseif angle < 270
       %% 
       angle = 90-(angle - 180);
        leftPointX = new_x - 1;
        leftPointY = new_y;
        leftPointAngle = abs(atand((leftPointX - x)/(leftPointY - y)));
        
        lowerPointX = new_x;
        lowerPointY = new_y - 1;
        lowerPointAngle = abs(atand((lowerPointX - x)/(lowerPointY - y)));
        
        lowerLeftPointX = new_x -1;
        lowerLeftPointY = new_y - 1;
        lowerLeftPointAngle = abs(atand((lowerLeftPointX - x)/(lowerLeftPointY - y)));
        
        leftPointAngle = abs(leftPointAngle-angle);
        lowerPointAngle = abs(lowerPointAngle-angle);
        lowerLeftPointAngle = abs(lowerLeftPointAngle-angle);
        
        minDif = min([leftPointAngle lowerPointAngle lowerLeftPointAngle]);
        if leftPointAngle == minDif
            new_x = leftPointX;
            new_y = leftPointY;
        elseif lowerPointAngle == minDif
            new_x = lowerPointX;
            new_y = lowerPointY;
        else
            new_x = lowerLeftPointX;
            new_y = lowerLeftPointY;
        end
        
    else
        angle = angle - 270;
        %%
        rightPointX = new_x + 1;
        rightPointY = new_y;
        rightPointAngle = abs(atand((rightPointX - x)/(rightPointY - y)));
        
        lowerPointX = new_x;
        lowerPointY = new_y - 1;
        lowerPointAngle = abs(atand((lowerPointX - x)/(lowerPointY - y)));
        
        lowerRightPointX = new_x + 1;
        lowerRightPointY = new_y - 1;
        lowerRightPointAngle = abs(atand((lowerRightPointX - x)/(lowerRightPointY - y)));
        
        rightPointAngle = abs(rightPointAngle-angle);
        lowerPointAngle = abs(lowerPointAngle-angle);
        lowerRightPointAngle = abs(lowerRightPointAngle-angle);
        
        minDif = min([rightPointAngle lowerPointAngle lowerRightPointAngle]);
        if rightPointAngle == minDif
            new_x = rightPointX;
            new_y = rightPointY;
        elseif lowerPointAngle == minDif
            new_x = lowerPointX;
            new_y = lowerPointY;
        else
            new_x = lowerRightPointX;
            new_y = lowerRightPointY;
        end
        
    end
    angle = angle_backup;
end

temp_delta_x = new_x - x;
temp_delta_y = new_y - y;
dis = sqrt((temp_delta_x * temp_delta_x) + (temp_delta_y * temp_delta_y));
end