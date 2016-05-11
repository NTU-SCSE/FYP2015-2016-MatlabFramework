% animation params
periods = 2;                % how many full-period rotations to do
num_steps = 100 * periods;  % number of animation steps per period

% circles
freq = [1 3 5 7];           % frequency of each sine function (rotation speed)
r = 4./(freq*pi);           % radii of circles (amplitude of sines)
K = numel(freq);            % number of circles
R = max(r);                 % maximum radius
bounds = ceil(R);           % offset the circles to left of origin

% circles points (co-centric)
t = linspace(0, 2*pi, 50).';
x = bsxfun(@times, r, cos(t)) - bounds;  % shifted with offset
y = bsxfun(@times, r, sin(t));

% PLOT: open wide figure
pos = get(groot, 'DefaultFigurePosition');
hFig = figure('Position',pos .* [1 1 1.5 0.9]);
movegui(hFig, 'center')

% PLOT: circles
hCircles = line(x, y, 'LineWidth',2);       % plot circles
line([0 0], [-bounds bounds], 'Color','k')  % plot y=0 axis
grid on, box on
axis equal
axis([-2*bounds ceil(2*pi*periods) -bounds bounds])
xlabel('Angle \theta')
title('Sine Functions')
ax = gca;
ax.XTick = ax.XTick(ax.XTick >= 0);         % start x-ticks at zero

% PLOT: prepare animated graphics objects
hRadii = line(nan(2,K), nan(2,K), 'LineWidth',1);
hLines = line(nan(2,K), nan(2,K), 'LineWidth',1, ...
    'LineStyle','--', 'Marker','.', 'MarkerSize',15);

% PLOT: sine functions curves
xx = linspace(0, 2*pi*periods, num_steps);  % X-periods in N-steps
hCurves = gobjects(K,1);
for k=1:K
    hCurves(k) = animatedline('Color',hRadii(k).Color, 'LineWidth',2);
end
legend(hCurves, ...
    strcat('4sin(', num2str(freq(:)), '\theta)/', num2str(freq(:)), '\pi'), ...
    'Orientation','Horizontal', 'Location','SouthOutside')

% GIF
%{
% gifsicle --colors 256 --careful --delay=5 --optimize --crop 90,45+675x260 -o out1_.gif out1.gif
[im,map] = rgb2ind(frame2im(getframe(hFig)), 256);
imwrite(im, map, 'out1.gif', 'gif', 'DelayTime',0.1, 'LoopCount',Inf);
%}

% animation
theta = zeros(1,K);            % current rotation angles for each circle (in radians)
step = (xx(2)-xx(1)) .* freq;  % step sizes for each circle (arclen = angle / radius)
for i=1:num_steps
    % break if figure is closed
    if ~isgraphics(hFig), break; end
    
    % for each circle
    for k=1:K
        % rotating point on k-th circle
        x = r(k) * cos(theta(k));
        y = r(k) * sin(theta(k));

        % update graphics
        set(hLines(k), 'XData',[x-bounds; xx(i)], 'YData',[y; y])
        set(hRadii(k), 'XData',[0; x]-bounds, 'YData',[0; y])
        addpoints(hCurves(k), xx(i), y)
    end

    % refresh plot
    pause(0.02)    % drawnow
    
    % GIF
    %{
    [im,map] = rgb2ind(frame2im(getframe(hFig)), 256);
    imwrite(im, map, 'out1.gif', 'gif', 'DelayTime',0.1, 'WriteMode','append');
    %}

    % increment angles
    theta = theta + step;
end