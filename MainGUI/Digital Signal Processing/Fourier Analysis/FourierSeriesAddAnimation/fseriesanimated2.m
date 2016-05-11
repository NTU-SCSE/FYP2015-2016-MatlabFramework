% animation params
periods = 2;                % how many full-period rotations to do
num_steps = 150 * periods;  % number of animation steps per period

% circles
freq = [1 3 5 7];           % frequency of each sine function (rotation speed)
r = 4./(freq*pi);           % radii of circles (amplitude of sines)
K = numel(freq);            % number of circles
R = max(r);                 % maximum radius
bounds = ceil(sum(r));      % offset the circles to left of origin

% circles points (co-centric)
t = linspace(0, 2*pi, 50).';  % NPTS=50
x = bsxfun(@times, r, cos(t));
y = bsxfun(@times, r, sin(t));

% add center (so that the radius line is drawn)
x = x([1 1:end],:); x(1,:) = 0;
y = y([1 1:end],:); y(1,:) = 0;

% circle points in homogeneous form (one slice per circle)
% (size = 4 x NUMPTS x K)
pts = cat(2, reshape(x,[],1,K), reshape(y,[],1,K));
pts(:,3,:) = 0;               % z=0
pts(:,4,:) = 1;               % w=1
pts = permute(pts, [2 1 3]);  % transpose

% hFig = axes(handles.combinedAnimatedGraph)
%%%%%%%
% PLOT: open wide figure
pos = get(groot, 'DefaultFigurePosition');
hFig = figure('Position',pos .* [1 1 1.5 0.9]);
movegui(hFig, 'center')
%%%%%%%


% PLOT: circles with radius lines (initially untransformed and all centered
% on origin), then translate circles to the left
hCircles = line(x, y, 'LineWidth',2);
hTr = hgtransform('Matrix',makehgtform('translate',[-bounds 0 0]));
set(hCircles, 'Parent',hTr)
line([0 0], [-bounds bounds], 'Color','k')  % plot y=0 axis
grid on, box on
axis equal
axis([-2*bounds ceil(2*pi*periods) -bounds bounds])
xlabel('Angle \theta')
ax = gca;
ax.XTick = ax.XTick(ax.XTick >= 0);         % start x-ticks at zero

% PLOT: trace path from smallest circle
hPath = animatedline('Color',hCircles(end).Color, 'LineStyle','-', ...
    'MaximumNumPoints',ceil(num_steps/periods)+1, 'Parent',hTr);

% PLOT: connecting line between trace and curve
hLine = line(nan, nan, 'Color',[0.5 0.5 0.5], ...
     'LineStyle','-', 'Marker','.', 'MarkerSize',10);

% PLOT: resulting Fourier series (sum of harmonics)
xx = linspace(0, 2*pi*periods, num_steps);  % X-periods in N-steps
yy = nan(size(xx));
hCurve = line(xx, yy, 'Color','m');
labels = cellstr(strcat('4sin(', num2str(freq(:)), '\theta)/', num2str(freq(:)), '\pi'));
legend(hCurve, strjoin(labels,' + '), ...
    'Orientation','Horizontal', 'Location','SouthOutside')

% GIF
%{
% gifsicle --colors 256 --careful --delay=5 --optimize --crop 90,30+675x300 -o out2_.gif out2.gif
[im,map] = rgb2ind(frame2im(getframe(hFig)), 256);
imwrite(im, map, 'out2.gif', 'gif', 'DelayTime',0.1, 'LoopCount',Inf);
%}

% animation
theta = zeros(1,K);                     % current rotation angles for each circle (in radians)
step = (2*pi*periods).*freq/num_steps;  % step sizes for each circle
for i=1:num_steps+1
    % break if figure is closed
    if ~isgraphics(hFig), break; end

    % compute and store transformation matrices (translations and rotations)
    tt = [theta(1) diff(theta)];
    Tx = cell(1,K);
    Rz = cell(1,K);
    for k=1:K
        Tx{k} = makehgtform('translate',[r(k) 0 0]);
        Rz{k} = makehgtform('zrotate',tt(k));
    end

    % for each circle
    for k=1:K
        % chain of transformations
        T = Rz{1};
        for j=1:k-1
            T = T * Tx{j} * Rz{j+1};
        end

        % apply combined transform on k-th circle
        pt = T * pts(:,:,k);
        pt = pt(1:2,:);  % extract x/y coords from homogeneous form

        % update k-th circle
        set(hCircles(k), 'XData',pt(1,:), 'YData',pt(2,:))
    end

    % update trace line
    pt = pt(:,2);  % take first point from last circle (skipping the center)
    addpoints(hPath, pt(1), pt(2))

    % update curve line
    yy = [pt(2) yy(1:end-1)];  % prepend point, and rollover
    set(hCurve, 'YData',yy)    % or fliplr(yy)

    % update connecting horizontal line
    set(hLine, 'XData',[pt(1)-bounds; 0], 'YData',[pt(2); pt(2)])

    % refresh plot
    pause(0.02)    % drawnow

    % GIF
    %{
    [im,map] = rgb2ind(frame2im(getframe(hFig)), 256);
    imwrite(im, map, 'out2.gif', 'gif', 'DelayTime',0.1, 'WriteMode','append');
    %}

    % increment angles
    theta = theta + step;
end