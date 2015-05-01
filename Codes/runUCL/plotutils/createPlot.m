%
% Fonction originale Alexandre Laterre, modifiée par Malian De Ron
%
function [h, color] = createPlot(fig, X, Y, color, new)

persistent iColor;

if nargin < 5
    new = 0;
end

if new || isempty(iColor)
    iColor = 0;
end

% Colors
if nargin < 4 
    color = iColor + 1;
    iColor = color;
end

if length(color) < 2
    switch color
        case 1
            color = [0.847058832645416  0.160784319043159 0];
        case 2
            color = [0.0431372560560703 0.517647087574005 0.780392169952393];
        case 3
            color = [0.168627455830574  0.505882382392883 0.337254911661148];
        case 4
            color = [0.87058824300766   0.490196079015732 0];
        case 5
            color = [1 0.400000005960464 0.600000023841858];
        otherwise
            color = [0 0 0];
    end
end

% Create plot
figure(fig);
h = plot(X, Y, '-', 'Color', color, 'LineWidth', 3);
