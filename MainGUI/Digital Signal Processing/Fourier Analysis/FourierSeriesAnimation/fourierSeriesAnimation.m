% Final Year Project CE
% Author:           Nonny Florentine (U1320766B)
% Sub-GUI
% Fourier Series Animation
% Created:          24 January 2016
% Latest Update:    21 February 2016
%                   Animation is working
%                   

function varargout = fourierSeriesAnimation(varargin)
% FOURIERSERIESANIMATION MATLAB code for fourierSeriesAnimation.fig
%      FOURIERSERIESANIMATION, by itself, creates a new FOURIERSERIESANIMATION or raises the existing
%      singleton*.
%
%      H = FOURIERSERIESANIMATION returns the handle to a new FOURIERSERIESANIMATION or the handle to
%      the existing singleton*.
%
%      FOURIERSERIESANIMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIERSERIESANIMATION.M with the given input arguments.
%
%      FOURIERSERIESANIMATION('Property','Value',...) creates a new FOURIERSERIESANIMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fourierSeriesAnimation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fourierSeriesAnimation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fourierSeriesAnimation

% Last Modified by GUIDE v2.5 28-Jan-2016 13:52:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fourierSeriesAnimation_OpeningFcn, ...
                   'gui_OutputFcn',  @fourierSeriesAnimation_OutputFcn, ...
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


% --- Executes just before fourierSeriesAnimation is made visible.
function fourierSeriesAnimation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fourierSeriesAnimation (see VARARGIN)

% Choose default command line output for fourierSeriesAnimation
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

% UIWAIT makes fourierSeriesAnimation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fourierSeriesAnimation_OutputFcn(hObject, eventdata, handles) 
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
num_steps = 100 * periods;  % number of animation steps per period

% circles
fInput = fInputUser;           % frequency of each sine function (rotation speed)
r = aInput./(fInput*pi);           % radii of circles (amplitude of sines)
K = numel(fInput);                % number of circles
R = max(r);                 % maximum radius
bounds = ceil(R);           % offset the circles to left of origin

% circles points (co-centric)
t = linspace(0, 2*pi, 50).';
x = bsxfun(@times, r, cos(t)) - bounds;  % shifted with offset
y = bsxfun(@times, r, sin(t));

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
    strcat(num2str(aInput(:)),'sin(', num2str(fInput(:)), '\theta)/', num2str(fInput(:)), '\pi'), ...
    'Orientation','Horizontal', 'Location','SouthOutside')

% GIF
%{
% gifsicle --colors 256 --careful --delay=5 --optimize --crop 90,45+675x260 -o out1_.gif out1.gif
[im,map] = rgb2ind(frame2im(getframe(hFig)), 256);
imwrite(im, map, 'out1.gif', 'gif', 'DelayTime',0.1, 'LoopCount',Inf);
%}

% animation
theta = zeros(1,K);            % current rotation angles for each circle (in radians)
step = (xx(2)-xx(1)) .* fInput;  % step sizes for each circle (arclen = angle / radius)
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
