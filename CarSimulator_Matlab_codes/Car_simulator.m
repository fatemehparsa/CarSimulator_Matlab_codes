function Car_Trajectory(road_num) %(initState, car_angle, step)
global road     % used in User interface
global road_backup; % used for calculation


% parameters
initState = 30;     % Determine initial position of car in road, [0, 90]
car_angle = 90;     % Determine initial car angle
default_step =30;  % Determine defualt step (speed) of car
road_number =5;    % Determine which road loaded
adjust_speed = 1;   % 1 for adjusting speed, 0 for fix speed, fix speed = defualt step
each_stage_move = 100;   % Determine the number of moves done in each stage in user interface
max_number_of_stages = 100;






if (road_number==4 || road_number==5|| road_number==3)
    initState = 45;



if(nargin == 1)
    road_number = road_num;
end

%Initialize
close all;
step = default_step;
imagePath = ['road' int2str(road_number) '.png'];
road = imread(imagePath);
road_backup = road;
x = 720 - 90 + initState;
y = 90;
plot_point(x, y);
imshow(road);
if (road_number==4 || road_number==5)
    myfis = readfis('sogeno46.fis');
else
    myfis = readfis('sogeno.fis');
end



%myfis = readfis('mamdani_Car_Simulator.fis');


for i=1:max_number_of_stages
    for j=1:each_stage_move
        X1 = calc_distance(x, y, car_angle);
        X2 = calc_distance(x, y, car_angle + 90);
        X3 = calc_distance(x, y, car_angle - 90);

        % if we want to turn right, turn angle should be positive, and vise versa
        turn_angle = evalfis([X1, X2, X3], myfis);
        %turn_angle = evalfis([X1, X2, X3], myfis);
        car_angle = mod(car_angle - turn_angle + 360,360);  % correcting negetive or more than 360 degree car_angles

        % Adjust speed
        if(adjust_speed == 1)
            if(X1 <= step+6)
                step = X1 / 3;
            else
                step = default_step;
            end
        end
        %if(abs(turn_angle) <= 15)
        %    step = step + 5;
        %elseif(step > 20)
        %    step = step - 10;
        %end

        [x y] = calc_new_location(x, y, car_angle, step);
        plot_point(x, y); 
        step = default_step;
    end     % end of for
    imshow(road);
    pause;
end
