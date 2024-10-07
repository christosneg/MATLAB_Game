classdef Game < handle
    properties  
        ground = 0;        
        boardSize = [-1000 1000 -50 1000];
        time_previous = posixtime(datetime('now'));
        player = Player();  
        min_dt = 0.01; 
    end
    
    methods
        function obj = init(obj)
            obj.player = obj.player.init(); 
        end
        
        function obj = updateData(obj)

            current_time = posixtime(datetime('now'));
            dt = (current_time - obj.time_previous);
            obj.time_previous = current_time;
            
            dt = max(dt, obj.min_dt);

            obj.player.updatePlayerData(dt, obj.ground); 
        end

        function visualizeData(obj)
            cla;
            hold on;
            
            obj.player.visualizePlayer();
            

            plot([obj.boardSize(1), obj.boardSize(2)], [obj.ground, obj.ground], 'k-', 'LineWidth', 2);
           
            hold off;
            axis(obj.boardSize);
            axis equal;
            drawnow;
        end
    end
end

