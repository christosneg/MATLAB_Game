clear; clc; close all;
gridIsON = false;
game = Game();
game = game.init();

hFig = figure('KeyPressFcn', @(src, event) keyPressHandler(event, game), ...
    "KeyReleaseFcn",  @(src, event) keyReleaseHandler(event, game),'WindowState', 'fullscreen');


% Start the game loop
while ishandle(hFig)
    game.updateData();
    game.visualizeData(); 
    disp(game.player.velocity)
    pause(0.02); 
end

function keyPressHandler(event, game)
    switch event.Key
        case 'rightarrow'
            game.player.button("R", "Pressed");
        case 'leftarrow'
            game.player.button("L", "Pressed");
        case 'uparrow'
            game.player.button("U", "Pressed");
        case 'downarrow'
            game.player.button("D", "Pressed");
    end
end

function keyReleaseHandler(event, game)
    switch event.Key
        case 'rightarrow'
            game.player.button("R", "Released");
        case 'leftarrow'
            game.player.button("L", "Released");
        case 'uparrow'
            game.player.button("U", "Released");
        case 'downarrow'
            game.player.button("D", "Released");
        
    end
end

