clear; clc; close all;

game = Game();
game = game.init();

hFig = figure('KeyPressFcn', @(src, event) assignin('base', 'game', keyPressHandler(event, game)), ...
              'KeyReleaseFcn', @(src, event) assignin('base', 'game', keyReleaseHandler(event, game)), ...
              'WindowState', 'maximized');

% Start the game loop
while ishandle(hFig)
    game = game.updateData();
    game.visualizeData();
    
    disp(['Velocity: ', num2str(game.velocity)]);
    
    pause(0.02); 
end


function game = keyPressHandler(event, game)
    persistent keyStatus; 
    
    if isempty(keyStatus)
        keyStatus = containers.Map({'uparrow', 'downarrow', 'rightarrow', 'leftarrow'}, {false, false, false, false});
    end

    if isKey(keyStatus, event.Key)
        keyStatus(event.Key) = true;
    end
    
    game = updateAcceleration(keyStatus, game);
end

function game = keyReleaseHandler(event, game)
    persistent keyStatus;  
    
    if isempty(keyStatus)
        keyStatus = containers.Map({'uparrow', 'downarrow', 'rightarrow', 'leftarrow'}, {false, false, false, false});
    end
    
    if isKey(keyStatus, event.Key)
        keyStatus(event.Key) = false;
    end
    
    game = updateAcceleration(keyStatus, game);
end

function game = updateAcceleration(keyStatus, game)
    
    if keyStatus('rightarrow')
        game.acceleration(1) = game.step;   
    elseif keyStatus('leftarrow')
        game.acceleration(1) = -game.step;  
    else
        game.acceleration(1) = 0;           
    end

    if keyStatus('uparrow')
        if ~game.isJumping
            game.acceleration(2) = -game.gravity; 
            game.isJumping = true;
        end
    elseif keyStatus('downarrow')
        game.acceleration(2) = game.step; 
    else
        game.acceleration(2) = 0;
    end
end

