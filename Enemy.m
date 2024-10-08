classdef Enemy < handle
    properties
        direction = [];
        length = [];
        acceleration = []; 
        velocity = [];   
        position = []; 
        a = []; 
    end
    
    methods
        function obj = init(obj,ground)
            obj.direction = [false false]; % [LEFT, RIGHT]
            obj.length = 30;
            obj.position = [100 ground(100)]; 
            obj.acceleration = [0 0]; 
            obj.velocity = [0 0]; 
            obj.a = 50;
        end

        function obj = updateEnemyData(obj, player, dt, ground)
            % Enemy chases player based on player's x position
            if player.position(1) > obj.position(1)
                obj.acceleration(1) = obj.a;  % Accelerate towards the player (right)
            else
                obj.acceleration(1) = -obj.a; % Accelerate towards the player (left)
            end

            % Update velocity and position based on acceleration
            obj.velocity(1) = obj.velocity(1) + dt * obj.acceleration(1);
            obj.position(1) = obj.position(1) + dt * obj.velocity(1);

            % Forced ground collision (Y-axis stays fixed on the ground)
            obj.position(2) = ground(obj.position(1)) + obj.length / 2; 

            % Reset acceleration for the next frame
            obj.acceleration = [0, 0];
        end

        function visualizeEnemy(obj)
            % Visualize the enemy as a square or rectangle
            half_length = obj.length / 2;
            x = [-half_length, half_length, half_length, -half_length] + obj.position(1);
            y = [-half_length, -half_length, half_length, half_length] + obj.position(2);
            fill(x, y, 'r'); % Fill the square with red color
        end
    end
end
