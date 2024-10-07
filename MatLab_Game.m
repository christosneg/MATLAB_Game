clear; clc; close all;

game = Game();
game = game.init();

hFig = figure('KeyPressFcn', @(src, event) keyPressHandler(event, game), ...
             'WindowState', 'fullscreen');

% Start the game loop
while ishandle(hFig)
    game.updateData();
    game.visualizeData(); 
    disp(game.player.velocity(2))
    pause(0.02); 
end

function keyPressHandler(event, game)
    switch event.Key
        case 'rightarrow'
            game.player.setAcceleration("R");
        case 'leftarrow'
            game.player.setAcceleration("L");
        case 'uparrow'
            game.player.setAcceleration("U");
        case 'downarrow'
            game.player.setAcceleration("D");
    end
end

