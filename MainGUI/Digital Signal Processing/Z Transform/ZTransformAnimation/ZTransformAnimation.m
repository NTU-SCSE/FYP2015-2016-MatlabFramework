function varargout = ZTransformAnimation(varargin)
% ZTRANSFORMANIMATION MATLAB code for ZTransformAnimation.fig
%      ZTRANSFORMANIMATION, by itself, creates a new ZTRANSFORMANIMATION or raises the existing
%      singleton*.
%
%      H = ZTRANSFORMANIMATION returns the handle to a new ZTRANSFORMANIMATION or the handle to
%      the existing singleton*.
%
%      ZTRANSFORMANIMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZTRANSFORMANIMATION.M with the given input arguments.
%
%      ZTRANSFORMANIMATION('Property','Value',...) creates a new ZTRANSFORMANIMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ZTransformAnimation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ZTransformAnimation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ZTransformAnimation

% Last Modified by GUIDE v2.5 02-Feb-2016 03:22:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ZTransformAnimation_OpeningFcn, ...
                   'gui_OutputFcn',  @ZTransformAnimation_OutputFcn, ...
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


% --- Executes just before ZTransformAnimation is made visible.
function ZTransformAnimation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ZTransformAnimation (see VARARGIN)

% Choose default command line output for ZTransformAnimation
handles.output = hObject;

plotGraph(handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ZTransformAnimation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ZTransformAnimation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function plotGraph(handles)
makemovie = 0;
% Two-pole, two-zero example

zeroValue = eval(get(handles.zeroText,'String'));
poleValue = eval(get(handles.poleText,'String'));

zeroInput = poly(zeroValue);
poleInput = poly(poleValue);

%zz = [0.8*exp(j*pi*0.3) 0.8*exp(j*pi*-0.3)].';
%pp = [0.9*exp(j*pi*0.3) 0.9*exp(j*pi*-0.3)].';

zz= zeroInput.';
pp= poleInput.';

moviename = '2p2z.mov';
ymax = 2;

% zp2tf doesn't work for complex systems??
[bb,aa] = zp2tf(zz,pp,1);
%bb = poly(zz);
%aa = poly(pp);

% Steps around the top half of the unit circle
ww = [0:200]/200*pi;

% Initialize the movie
if makemovie
    eval(['MakeQTMovie start ', moviename]);
end

% Lay out the display
axes(handles.zeroPoleGraph);
zplane(pp,zz);

% fixed axes for frq plot
axes(handles.magnitudeGraph);
fax = [0 1 0 ymax];
axis(fax)
grid

% fixed axes for phs plot (pi-normalized)
axes(handles.phaseGraph);
pax = [0 1 -1 1];
axis(pax);
grid


%HH = NaN*ww;
%PP = HH;
% Preset the plots to have the whole lines, 
% not just points so far 
GG = polyval(bb,exp(j*ww))./polyval(aa,exp(j*ww));
HH = abs(GG);
PP = angle(GG);

% plot the frames
for i = 1:length(ww);

  w = ww(i);
  z = exp(j*w);

  % Evaluate the z transform at this point
  Gz = polyval(bb,z)./polyval(aa,z);
  
  HH(i) = abs(Gz);
  PP(i) = angle(Gz);
  
  % Make the plots
  axes(handles.zeroPoleGraph);
  zplane([0],[]);
  hold on
  plot(real(z),imag(z),'sg');
  
  % Add omega parameters
  for www = -0.8:0.2:0.8
    ejw = exp(j*www*pi);
    ll = sprintf('%.1f\\pi',www);
    text(real(ejw), imag(ejw), ll);
  end
  
  % Plot and connect to all the poles and zeros
  for r = pp.'
	plot(real(r),imag(r), 'xr');
	plot([real(r), real(z)], [imag(r), imag(z)], '-r');
  end
  for r = zz.'
	plot(real(r),imag(r), 'ob');
	plot([real(r), real(z)], [imag(r), imag(z)], '-g');
  end
  hold off
  
  axes(handles.magnitudeGraph);
  plot(ww/pi, HH, w/pi, HH(i), 'sg',[w/pi w/pi], [0 HH(i)], '-g');
  axis(fax)
  grid
  title('magnitude');

  axes(handles.phaseGraph);
  plot(ww/pi, PP/pi, w/pi, PP(i)/pi, 'sg');
  axis(pax)
  grid
  title('phase');
  xlabel('\omega / \pi');
  set(gca, 'YTick', [-1 -0.5 0 0.5 1])
  set(gca, 'YTickLabel', [' -pi ';'-pi/2';'  0  ';' pi/2'; '  pi '])

  % Save this image
  if makemovie
    MakeQTMovie addfigure
  else
    drawnow
  end

%  if (w > 0.28*pi)
%    break
%  end

end

if makemovie
  MakeQTMovie finish
end



function zeroText_Callback(hObject, eventdata, handles)
% hObject    handle to zeroText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zeroInput = eval(get(hObject,'String'));

if(isempty(zeroInput))
    eval(set(hObject,'Value','[0.8*exp(j*pi*0.3) 0.8*exp(j*pi*-0.3)]'))
else
    cla(handles.zeroPoleGraph,'reset');
    plotGraph(handles);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of zeroText as text
%        str2double(get(hObject,'String')) returns contents of zeroText as a double


% --- Executes during object creation, after setting all properties.
function zeroText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zeroText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poleText_Callback(hObject, eventdata, handles)
% hObject    handle to poleText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
poleInput = eval(get(hObject,'String'));

if(isempty(poleInput))
    eval(set(hObject,'Value','[0.9*exp(j*pi*0.3) 0.9*exp(j*pi*-0.3)]'))
else
    cla(handles.zeroPoleGraph,'reset');
    plotGraph(handles);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of poleText as text
%        str2double(get(hObject,'String')) returns contents of poleText as a double


% --- Executes during object creation, after setting all properties.
function poleText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poleText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
