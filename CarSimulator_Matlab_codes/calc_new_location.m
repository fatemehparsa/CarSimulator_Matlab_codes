function [new_x, new_y]= calc_new_location(x, y, theta, step)
   if (theta<=90)
        new_x = floor(x + step * cosd(theta));
        new_y = floor(y + step * sind(theta));
   elseif (theta<=180)
        new_x = floor(x - step * sind(theta - 90));
        new_y = floor(y + step * cosd(theta - 90));
   elseif (theta<=270)
        new_x = floor(x - step * cosd(theta - 180));
        new_y = floor(y - step * sind(theta - 180));
   else
        new_x = floor(x + step * sind(theta - 270));
        new_y = floor(y - step * cosd(theta - 270));
   end
end