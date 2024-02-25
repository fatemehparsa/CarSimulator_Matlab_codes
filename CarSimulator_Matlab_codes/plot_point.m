function plot_point(input_x, input_y)
global road;
    
if input_x>720 || input_y>660
    error('out of image');
end

[x y] = map_axis(input_x, input_y);
for(i = x-1:x+1)
    for(j = y-1:y+1)
        road(i, j, 1) = 255;
        road(i, j, 2) = 0;
        road(i, j, 3) = 0;
    end
end
end