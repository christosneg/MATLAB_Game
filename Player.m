classdef Player < handle
    properties
        direction = [];
        radius = [];
        acceleration = []; 
        velocity = [];   
        position = [];  
        speed = [];
        jump = [];
        isJumping = [];   
        gravity = [];
    end
    
    methods
        function obj = init(obj)
            obj.direction = [false false false false]; % [ UP, DOWN, LEFT, RIGHT ]
            obj.radius = 10;
            obj.isJumping = false;
            obj.position = [0 150]; 
            obj.acceleration = [0 0]; 
            obj.velocity = [0 0]; 
            obj.jump = 120.0;
            obj.speed = 80.0;
            obj.gravity = 100.0;
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

    % Set speed based on keyboard input
    obj.velocity(1) = 0;
    if obj.direction(1) && ~obj.isJumping
        obj.velocity(2) = obj.jump;
        obj.isJumping = true;
    end
    if obj.direction(3)
        obj.velocity(1) = -obj.speed;
    elseif obj.direction(4)
        obj.velocity(1) = obj.speed;
    end

    % Apply gravity
    if obj.isJumping
        obj.acceleration = [0, -obj.gravity];
        obj.velocity = obj.velocity + dt * obj.acceleration;
    end

    obj.position = obj.position + dt * obj.velocity;

    % Ground collision detection
    if obj.position(2) <= ground(obj.position(1)) + obj.radius
        obj.position(2) = ground(obj.position(1)) + obj.radius; 
        obj.isJumping = false;
        obj.velocity(2) = 0;
    else
        obj.isJumping = true;
    end

    obj.acceleration = [0, 0];
end

        function visualizePlayer(obj)
            theta = linspace(0, 2*pi, 100);
            x = obj.radius * cos(theta) + obj.position(1);
            y = obj.radius * sin(theta) + obj.position(2);
            fill(x, y, 'b');
        end
    end
end


