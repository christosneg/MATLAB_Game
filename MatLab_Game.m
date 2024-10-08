clear; clc; close all;
game = Game();
game = game.init();

hFig = figure('KeyPressFcn', @(src, event) keyPressHandler(event, game), ...
    "KeyReleaseFcn",  @(src, event) keyReleaseHandler(event, game),'WindowState', 'fullscreen');

% Start the game loop
clock_init = posixtime(datetime('now'));
clock = posixtime(datetime('now'));
hold on;

while clock - clock_init < 60.0
    clock = posixtime(datetime('now'));
    game.updateData();
    game.visualizeData();
    pause(0.02); 
end
close all;
figure("WindowState","fullscreen");
xLimits = xlim;
yLimits = ylim;

xCenter = (xLimits(1) + xLimits(2)) / 2;
yCenter = (yLimits(1) + yLimits(2)) / 2;

fontSize = 30;
text(xCenter, yCenter, 'You win', 'FontSize', fontSize, 'Color', 'g', ...
             'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
pause(10);

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



