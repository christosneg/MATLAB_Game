classdef Player < handle
    properties
        radius = 10;
        acceleration = [0 0]; 
        velocity = [0 0];   
        position = [0 150];  
        speed = 10;
        jumpVelocity = 100;  
        isJumping = false;
        gravity = 0.5; 
        friction = 10;   
        maxVelocity = 100;  
        accelMultiplier = 10; 
    end
    
    methods
        function obj = init(obj)
            obj.isJumping = false;
            obj.acceleration = [0 0]; 
            obj.velocity = [0 0]; 
        end

        function obj = setAcceleration(obj, dir)
            switch dir
                case "R"
                    obj.acceleration(1) = obj.speed * obj.accelMultiplier;
                case "L"
                    obj.acceleration(1) = -obj.speed * obj.accelMultiplier;
                case "U"
                    if ~obj.isJumping
                        obj.velocity(2) = obj.jumpVelocity;
                        obj.isJumping = true;
                    end
                case "D"
                    obj.acceleration(2) = -obj.speed; 
            end
        end
        
        function obj = updatePlayerData(obj, dt, ground)
            
            obj.velocity(1) = obj.velocity(1) + dt * obj.acceleration(1);

            % Apply friction if no horizontal acceleration
            if obj.acceleration(1) == 0
                obj.velocity(1) = obj.velocity(1) - sign(obj.velocity(1)) * obj.friction * dt;
                if abs(obj.velocity(1)) < 0.1  
                    obj.velocity(1) = 0;
                end
            end

            % Apply gravity if the player is in the air
            if obj.position(2) > ground + obj.radius
                obj.velocity(2) = obj.velocity(2) - obj.gravity * dt; 
                obj.isJumping = true; 
            else
                obj.position(2) = ground + obj.radius;  
                obj.velocity(2) = 0;           
                obj.isJumping = false;         
            end

            obj.velocity = min(max(obj.velocity, -obj.maxVelocity), obj.maxVelocity);


            obj.position = obj.position + dt * obj.velocity;

            obj.acceleration = [0 0];
        end

        function visualizePlayer(obj)
            theta = linspace(0, 2*pi, 100);
            x = obj.radius * cos(theta) + obj.position(1);
            y = obj.radius * sin(theta) + obj.position(2);
            fill(x, y, 'r');  % Blue circle for the player
        end
    end
end


