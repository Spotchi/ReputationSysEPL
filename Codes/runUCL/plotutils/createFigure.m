function fig = createFigure(titre, axeX, axeY)

if nargin < 1
    titre = [];
end

if nargin < 2
    axeX = [];
end

if nargin < 3
    axeY = [];
end

fig = figure('Color',[1 1 1], 'Units', 'Normalized' ,'Position', [0 0 1 1]);

%set(fig, );
%set(fig, );

axes1 = axes('Parent', fig, 'FontWeight', 'bold', 'FontSize', 24);
box(axes1, 'on');
grid(axes1, 'on');
hold(axes1, 'all');

xlabel(axeX, 'Interpreter', 'latex', 'FontWeight', 'bold', 'FontSize', 30);
ylabel(axeY, 'Interpreter', 'latex', 'FontWeight', 'bold', 'FontSize', 30);
title(titre, 'Interpreter', 'latex', 'FontSize', 30, 'FontWeight', 'bold');

hold all;

end
