% Final Year Project CE
% Author:           Nonny Florentine (U1320766B)
% Sub-GUI
% Fourier Series Add Animation
% Created:          25 January 2016
% Latest Update:    21 February 2016
%                  
%                   

function varargout = fourierSeriesAddAnimation(varargin)
% FOURIERSERIESADDANIMATION MATLAB code for fourierSeriesAddAnimation.fig
%      FOURIERSERIESADDANIMATION, by itself, creates a new FOURIERSERIESADDANIMATION or raises the existing
%      singleton*.
%
%      H = FOURIERSERIESADDANIMATION returns the handle to a new FOURIERSERIESADDANIMATION or the handle to
%      the existing singleton*.
%
%      FOURIERSERIESADDANIMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIERSERIESADDANIMATION.M with the given input arguments.
%
%      FOURIERSERIESADDANIMATION('Property','Value',...) creates a new FOURIERSERIESADDANIMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fourierSeriesAddAnimation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fourierSeriesAddAnimation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fourierSeriesAddAnimation

% Last Modified by GUIDE v2.5 28-Jan-2016 15:33:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fourierSeriesAddAnimation_OpeningFcn, ...
                   'gui_OutputFcn',  @fourierSeriesAddAnimation_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before fourierSeriesAddAnimation is made visible.
function fourierSeriesAddAnimation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fourierSeriesAddAnimation (see VARARGIN)

% Choose default command line output for fourierSeriesAddAnimation
handles.output = hObject;
errCmd = 'errordlg(lasterr,''Error Initializing Figure''); error(lasterr);';
cmdCheck1 = 'installcheck;';
cmdCheck2 = 'h.MATLABVER = versioncheck(5.2);';
cmdCheck3 = 'screensizecheck([800 600]);';
cmdCheck4 = ['adjustpath(''' mfilename ''');'];
eval(cmdCheck1,errCmd);       % Simple installation check
eval(cmdCheck2,errCmd);       % Check Matlab Version
eval(cmdCheck3,errCmd);       % Check Screen Size
eval(cmdCheck4,errCmd);       % Adjust path if necessary

plotAnimation(handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fourierSeriesAddAnimation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fourierSeriesAddAnimation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;




function plotAnimation(handles)
periodValue = get(handles.periodText,'String');
amplitudeValue = get(handles.amplitudeText,'String');
frequencyValue = eval(get(handles.frequencyText,'String'));
pInput = str2double(periodValue);
aInput = str2double(amplitudeValue);
fInputUser = (frequencyValue);

hFig = handles.animatedGraph;
% animation params
periods = pInput;                % how many full-period rotations to do
num_steps = 150 * periods;  % number of animation steps per period

% circles
freq = fInputUser;           % frequency of each sine function (rotation speed)
r = aInput./(freq*pi);           % radii of circles (amplitude of sines)
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
labels = cellstr(strcat(aInput,'sin(', num2str(freq(:)), '\theta)/', num2str(freq(:)), '\pi'));
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



% --- Executes on button press in playButton.
function playButton_Callback(hObject, eventdata, handles)
% hObject    handle to playButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.animatedGraph,'reset')
plotAnimation(handles)
guidata(hObject,handles);



function periodText_Callback(hObject, eventdata, handles)
% hObject    handle to periodText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of periodText as text
%        str2double(get(hObject,'String')) returns contents of periodText as a double


% --- Executes during object creation, after setting all properties.
function periodText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to periodText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amplitudeText_Callback(hObject, eventdata, handles)
% hObject    handle to amplitudeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of amplitudeText as text
%        str2double(get(hObject,'String')) returns contents of amplitudeText as a double


% --- Executes during object creation, after setting all properties.
function amplitudeText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitudeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequencyText_Callback(hObject, eventdata, handles)
% hObject    handle to frequencyText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = eval(get(hObject,'String'));

if(isempty(input))
    eval(set(hObject,'Value','[1 3 5 7]'))
end

guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of frequencyText as text
%        str2double(get(hObject,'String')) returns contents of frequencyText as a double


% --- Executes during object creation, after setting all properties.
function frequencyText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequencyText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
