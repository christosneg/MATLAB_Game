classdef Player < handle
    properties
        direction = [false false false false]; % [ UP, DOWN, LEFT, RIGHT ]
        radius = 10;
        acceleration = [0 0]; 
        velocity = [0 0];   
        position = [0 150];  
        speed = 10;
        jump = 1;
        isJumping = false;   
        gravity = 50;
    end
    
    methods
        function obj = init(obj)
            obj.isJumping = false;
            obj.position = [0 150]; 
            obj.acceleration = [0 0]; 
            obj.velocity = [0 0]; 
        end

        function obj = button(obj, dir, action)
            if action == "Pressed"
                logic_var = true;
            elseif action == "Released"
                logic_var = false;
            end
            switch dir
                case "R"
                    obj.direction(4) = logic_var;
                case "L"
                    obj.direction(3) = logic_var;
                case "U"
                    obj.direction(1) = logic_var;
                case "D"
                    obj.direction(2) = logic_var;
            end
        end
        
        function obj = updatePlayerData(obj, dt, ground)

            %set speed based on keyboard input
            obj.velocity(1) = 0;
            if obj.direction(1)
                if ~obj.isJumping
                    obj.velocity(2) = obj.jump;
                    obj.isJumping = true;
                end
            elseif obj.direction(2)
            obj.velocity(2) = -obj.speed;
            elseif obj.direction(3)
            obj.velocity(1) = -obj.speed;
            elseif obj.direction(4)
            obj.velocity(1) = obj.speed;
            end

            obj.acceleration = obj.acceleration + [0 -obj.gravity];

            obj.velocity = obj.velocity + dt * obj.acceleration;
            obj.position = obj.position + dt * obj.velocity;

            %ground collision
            if(obj.position(2) < ground(obj.position(1)) + obj.radius)
                obj.position(2) = ground(obj.position(1)) + obj.radius;
                obj.isJumping = false;
            end
            obj.acceleration = [0 0];
        end

        function visualizePlayer(obj)
            theta = linspace(0, 2*pi, 100);
            x = obj.radius * cos(theta) + obj.position(1);
            y = obj.radius * sin(theta) + obj.position(2);
            fill(x, y, 'b');
        end
    end
end


