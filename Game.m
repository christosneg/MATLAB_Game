classdef Game
    properties
        acceleration = [0 0];  % x, y
        velocity = [0 0];      % x, y
        position = [0 0];      % x, y
        playerradius = 10;     
        ground;        
        boardSize = [-1000 1000 -50 1000];
        time_previous = posixtime(datetime('now'));
        step = 10;
        friction = 0.95;
        max_velocity = 10;
        gravity = 9.8;
        isJumping = false;
    end
    
    methods
        function obj = init(obj)
            obj.ground = -obj.playerradius;
        end
        
        function obj = updateData(obj)
            % calculate dt
            current_time = posixtime(datetime('now'));
            dt = (current_time - obj.time_previous) /1;
            obj.time_previous = current_time;
            

            if obj.position(2) > obj.ground + obj.playerradius || obj.isJumping
                obj.acceleration(2) = obj.acceleration(2) + obj.gravity * dt;
            end
            
            obj.velocity = obj.velocity + dt * obj.acceleration;
            

            obj.velocity(1) = obj.velocity(1) * obj.friction;
            obj.velocity(2) = obj.velocity(2) * obj.friction;
            

            obj.velocity(1) = min(obj.max_velocity, max(-obj.max_velocity, obj.velocity(1)));
            obj.velocity(2) = min(obj.max_velocity, max(-obj.max_velocity, obj.velocity(2)));
            

            obj.position = obj.position + dt * obj.velocity;
            

            if obj.position(1) - obj.playerradius < obj.boardSize(1)
                obj.position(1) = obj.boardSize(1) + obj.playerradius;
                obj.velocity(1) = 0;
            elseif obj.position(1) + obj.playerradius > obj.boardSize(2)
                obj.position(1) = obj.boardSize(2) - obj.playerradius;
                obj.velocity(1) = 0;
            end
            

            if obj.position(2) - obj.playerradius < obj.boardSize(3)
                obj.position(2) = obj.boardSize(3) + obj.playerradius;
                obj.velocity(2) = 0;
            elseif obj.position(2) + obj.playerradius > obj.boardSize(4)
                obj.position(2) = obj.boardSize(4) - obj.playerradius;
                obj.velocity(2) = 0;
            end
            
            if obj.position(2) <= obj.ground + obj.playerradius
                obj.position(2) = obj.ground + obj.playerradius;
                obj.velocity(2) = 0; 
                obj.isJumping = false;  
            end
            
            %reset acceleration
            obj.acceleration(2) = 0;
            obj.acceleration(1) = 0;
        end

        function visualizeData(obj)
            % Clear the previous plot
            cla;
            hold on;
            % Plot the player
            theta = linspace(0, 2*pi, 100);
            x = obj.playerradius * cos(theta) + obj.position(1);
            y = obj.playerradius * sin(theta) + obj.position(2);
            fill(x, y, 'b');
            
            % Plot the ground
            plot([obj.boardSize(1), obj.boardSize(2)], [obj.ground, obj.ground], 'k-', 'LineWidth', 2);
           
            hold off;
            
            % Set the limits
            axis(obj.boardSize);
            axis equal;
            drawnow;
        end
    end
end

