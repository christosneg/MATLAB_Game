classdef Game < handle
    properties  
        ground = @(x) 0 * x;        
        boardSize = [-1000 1000 -50 1000];
        time_previous = posixtime(datetime('now'));
        player = Player(); 
    end
    
    methods
        function obj = init(obj)
            obj.player = obj.player.init(); 
        end
        
        function obj = updateData(obj)

             %calculate dt
            current_time = posixtime(datetime('now'));
            dt = (current_time - obj.time_previous);
            obj.time_previous = current_time;

            obj.player.updatePlayerData(dt, obj.ground); 
        end

        function visualizeData(obj)
            cla;
            hold on;  
            
            obj.player.visualizePlayer();   %plot player
            fplot(obj.ground,"LineStyle","-");
           
            hold off;
            axis(obj.boardSize);
            axis equal;
            drawnow;
        end
    end
end

