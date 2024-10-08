classdef Game < handle
    properties  
        ground = [];        
        boardSize = [];
        time_previous = [];
        player = []; 
        enemy = [];
    end
    
    methods
        function obj = init(obj) 
            obj.ground = @(x) 20*sin(x/100);
            obj.boardSize = [-500 500 -50 500];
            obj.time_previous = posixtime(datetime('now'));
            obj.player = Player(); 
            obj.player = obj.player.init(); 
            obj.enemy = Enemy();
            obj.enemy = obj.enemy.init(obj.ground); 
        end
        
        function obj = updateData(obj)
            % Calculate dt
            current_time = posixtime(datetime('now'));
            dt = (current_time - obj.time_previous);
            obj.time_previous = current_time;

            % Update player and enemy data
            obj.player.updatePlayerData(dt, obj.ground); 
            obj.enemy.updateEnemyData(obj.player, dt, obj.ground);

            % loose condition
            loseConditionx = ~( (obj.player.position(1) + obj.player.radius < obj.enemy.position(1) - obj.enemy.length / 2) || ...
                    (obj.player.position(1) - obj.player.radius > obj.enemy.position(1) + obj.enemy.length / 2) );
            loseConditiony = ~( (obj.player.position(2) + obj.player.radius < obj.enemy.position(2) - obj.enemy.length / 2) || ...
                    (obj.player.position(2) - obj.player.radius > obj.enemy.position(2) + obj.enemy.length / 2) );
            if loseConditionx && loseConditiony
                cla;
                obj.displayEndScreen();
                return;
            end
        end

        function visualizeData(obj)
            cla; 
            
            obj.player.visualizePlayer();   % Plot player
            obj.enemy.visualizeEnemy();     % Plot enemy
            fplot(obj.ground, "LineStyle", "-");

            axis(obj.boardSize);
            axis equal;
            drawnow;
        end

        function displayEndScreen(obj)

    xLimits = xlim;
    yLimits = ylim;

    xCenter = (xLimits(1) + xLimits(2)) / 2;
    yCenter = (yLimits(1) + yLimits(2)) / 2;

    fontSize = 30;
        text(xCenter, yCenter, 'Game Over', 'FontSize', fontSize, 'Color', 'r', ...
             'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        pause(10);
        close(gcf);
end

    end
end

