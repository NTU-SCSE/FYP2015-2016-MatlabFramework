% Final Year Project CE
% Author:           Nonny Florentine (U1320766B)
% Sub-GUI
% Z Transform
% Created:          18 January 2016
% Updated:          22 January 2016

function varargout = ztransform(varargin)
% ZTRANSFORM MATLAB code for ztransform.fig
%      ZTRANSFORM, by itself, creates a new ZTRANSFORM or raises the existing
%      singleton*.
%
%      H = ZTRANSFORM returns the handle to a new ZTRANSFORM or the handle to
%      the existing singleton*.
%
%      ZTRANSFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZTRANSFORM.M with the given input arguments.
%
%      ZTRANSFORM('Property','Value',...) creates a new ZTRANSFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ztransform_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ztransform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ztransform

% Last Modified by GUIDE v2.5 22-Jan-2016 03:26:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ztransform_OpeningFcn, ...
                   'gui_OutputFcn',  @ztransform_OutputFcn, ...
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


% --- Executes just before ztransform is made visible.
function ztransform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ztransform (see VARARGIN)

% Choose default command line output for ztransform
handles.output = hObject;
set(hObject,'toolbar','figure');
errCmd = 'errordlg(lasterr,''Error Initializing Figure''); error(lasterr);';
cmdCheck1 = 'installcheck;';
cmdCheck2 = 'h.MATLABVER = versioncheck(5.2);';
cmdCheck3 = 'screensizecheck([800 600]);';
cmdCheck4 = ['adjustpath(''' mfilename ''');'];
eval(cmdCheck1,errCmd);       % Simple installation check
eval(cmdCheck2,errCmd);       % Check Matlab Version
eval(cmdCheck3,errCmd);       % Check Screen Size
eval(cmdCheck4,errCmd);       % Adjust path if necessary


% Update handles structure
cla(handles.magnitudeGraph,'reset')
cla(handles.magnitudeGraph1,'reset')
cla(handles.frequencyGraph,'reset')
cla(handles.frequencyGraph1,'reset')
cla(handles.zeroPoleGraph,'reset')
impulseResponseGraph(handles)
plotZeroPoleGraph(handles)
guidata(hObject, handles);

% UIWAIT makes ztransform wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ztransform_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function poleValue_Callback(hObject, eventdata, handles)
% hObject    handle to poleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
poleInput = eval(get(hObject,'String'));

if(isempty(poleInput))
    eval(set(hObject,'Value','[0.5;-0.5+0.8i;-0.5-0.8i]'))
else
    plotZeroPoleGraph(handles);
    impulseResponseGraph(handles);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of poleValue as text
%        str2double(get(hObject,'String')) returns contents of poleValue as a double


% --- Executes during object creation, after setting all properties.
function poleValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poleValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zeroValue_Callback(hObject, eventdata, handles)
% hObject    handle to zeroValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zeroInput = eval(get(hObject,'String'));

if(isempty(zeroInput))
    eval(set(hObject,'Value','[0.5+0.8i;0.5-0.8i]'))
else
    plotZeroPoleGraph(handles);
    impulseResponseGraph(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of zeroValue as text
%        str2double(get(hObject,'String')) returns contents of zeroValue as a double


% --- Executes during object creation, after setting all properties.
function zeroValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zeroValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plotZeroPoleGraph(handles)

zeroValue = eval(get(handles.zeroValue,'String'));
poleValue = eval(get(handles.poleValue,'String'));

zeroInput = poly(zeroValue);
poleInput = poly(poleValue);

axes(handles.zeroPoleGraph)
zplane(roots(zeroInput),roots(poleInput));
title('Pole-Zero Map');





function impulseResponseGraph(handles)
zeroValue = eval(get(handles.zeroValue,'String'));
poleValue = eval(get(handles.poleValue,'String'));
w = 0:0.01:pi;

zeroInput = poly(zeroValue);
poleInput = poly(poleValue);

[H,w] = freqz(zeroInput,poleInput,w);
[G,w] = grpdelay(zeroInput,poleInput,w);

axes(handles.impulseResponseGraph)
n = 0:75;
x = [1;zeros(max(n),1)];
y = filter(zeroInput,poleInput,x);

plot([min(n) max(n)],[0 0],'k: ');
hold on;
h = stem(n,y,'b');
set(h(1),'MarkerFaceColor','b');
set(h(1),'MarkerSize',4);
hold off;
ylabel('h(n)');
xlabel('Time');
title('Impulse Response');
xlim([min(n) max(n)]);

axes(handles.frequencyGraph)
h = plot(w,real(H),'b','Linewidth',1.5);
ylabel('Real H(e^{j\omega})');
xlim([0 pi]);
title('Frequency Response');


axes(handles.frequencyGraph1)
h = plot(w,imag(H),'b','Linewidth',1.5);
ylabel('Imaginary H(e^{j\omega})');
xlabel('Frequency (rad/sample)');
xlim([0 pi]);


axes(handles.magnitudeGraph)
h = plot(w,abs(H),'b','Linewidth',1.5);
ylabel('Real |H(e^{j\omega})|');
xlim([0 pi]);
ylim([0 1.1*max(abs(H))]);
title('Magnitude Response');

axes(handles.magnitudeGraph1)
h = loglog(w,abs(H),'b','Linewidth',1.5);
ylabel('Real |H(e^{j\omega})| dB');
xlabel('Frequency (rad/sample)');
ylim([0.9*min(abs(H)) 1.1*max(abs(H))]);
xlim([0.01 pi]);
