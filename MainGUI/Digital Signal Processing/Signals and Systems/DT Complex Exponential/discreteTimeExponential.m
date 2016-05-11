% Final Year Project CE
% Author:           Nonny Florentine (U1320766B)
% Sub-GUI
% Discrete-Time Complex Exponential
% Created:          10 January 2016
% Updated:          18 February 2016


function varargout = discreteTimeExponential(varargin)
% DISCRETETIMEEXPONENTIAL MATLAB code for discreteTimeExponential.fig
%      DISCRETETIMEEXPONENTIAL, by itself, creates a new DISCRETETIMEEXPONENTIAL or raises the existing
%      singleton*.
%
%      H = DISCRETETIMEEXPONENTIAL returns the handle to a new DISCRETETIMEEXPONENTIAL or the handle to
%      the existing singleton*.
%
%      DISCRETETIMEEXPONENTIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISCRETETIMEEXPONENTIAL.M with the given input arguments.
%
%      DISCRETETIMEEXPONENTIAL('Property','Value',...) creates a new DISCRETETIMEEXPONENTIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before discreteTimeExponential_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to discreteTimeExponential_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help discreteTimeExponential

% Last Modified by GUIDE v2.5 21-Feb-2016 16:18:06

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @discreteTimeExponential_OpeningFcn, ...
                   'gui_OutputFcn',  @discreteTimeExponential_OutputFcn, ...
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


% --- Executes just before discreteTimeExponential is made visible.
function discreteTimeExponential_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to discreteTimeExponential (see VARARGIN)

% Choose default command line output for discreteTimeExponential
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
plot_realPartGraph(handles);
plot_imaginaryPartGraph(handles);
plot_realPartGraph1(handles);
plot_imaginaryPartGraph1(handles);
plot_combineGraph(handles);
plot_combineGraph1(handles);

textVisibilityOff(handles);

cla(handles.realPartGraph,'reset');
cla(handles.realPartGraph1,'reset');
cla(handles.imaginaryPartGraph,'reset');
cla(handles.imaginaryPartGraph1,'reset');
cla(handles.combineGraph,'reset');
cla(handles.combineGraph1,'reset');
guidata(hObject, handles);

% UIWAIT makes discreteTimeExponential wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = discreteTimeExponential_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function startTimeText_Callback(hObject, eventdata, handles)
% hObject    handle to startTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

startTime = str2double(get(hObject,'String'));

if(isempty(startTime))
    set(hObject,'String','0')
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of startTimeText as text
%        str2double(get(hObject,'String')) returns contents of startTimeText as a double




% --- Executes during object creation, after setting all properties.
function startTimeText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endTimeText_Callback(hObject, eventdata, handles)
% hObject    handle to endTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
endTime = str2double(get(hObject,'String'));

if(isempty(endTime))
    set(hObject,'String','10')
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of endTimeText as text
%        str2double(get(hObject,'String')) returns contents of endTimeText as a double


% --- Executes during object creation, after setting all properties.
function endTimeText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endTimeText (see GCBO)
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
amplitude = str2double(get(hObject,'String'));

if(isempty(amplitude))
    set(hObject,'String','1')
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



function wText_Callback(hObject, eventdata, handles)
% hObject    handle to wText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w = str2double(get(hObject,'String'));

if(isempty(w))
    set(hObject,'String','0.2')
elseif(w>0)
    plot_realPartGraph(handles);
    plot_imaginaryPartGraph(handles);
    plot_combineGraph(handles);
    plot_combineGraph1(handles);
    plot_realPartGraph1(handles);
    plot_imaginaryPartGraph1(handles);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of wText as text
%        str2double(get(hObject,'String')) returns contents of wText as a double


% --- Executes during object creation, after setting all properties.
function wText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ----------------------------------
% Plot real part graph
% ----------------------------------
function plot_realPartGraph(handles)

st = get(handles.startTimeText,'String');
et = get(handles.endTimeText,'String');
a = get(handles.amplitudeText,'String');
w = get(handles.wText,'String');
as = get(handles.amplitudeSignPopUpMenu,'Value');
nText = get(handles.nInputText,'String');

stInput = str2double(st);
etInput = str2double(et);
aInput = str2double(a);
wInput = str2double(w);
aSignInput = as;
axes(handles.realPartGraph)
n = stInput:etInput;
t = min(n):0.1:max(n);
N = length(n);
nInput =  str2double(nText);

if(aSignInput == 1)
    disp('aInput >0');
    ev = real(aInput.^(-t)); % OK
    y = aInput.^(-n).*exp(1i*wInput*n); % OK
elseif(aSignInput == 2)
    ev = real(aInput.^(-t)); % OK
    y = (-1*aInput).^(-n).*exp(1i*wInput*n); % OK
end

h = plot(t,real(-ev),'r',t,real(ev),'r');
hold on;
h = stem(n,real(y),'b');
set(h(1),'Marker','.');
hold off;
box on;
grid on;
ylabel('Real Part');
title('Growing Exponential');

if(nInput > stInput && nInput < etInput)
    axes(handles.realPartGraph)
    disp('real part graph');
    y  = real(y);
    yy = y(nInput+(-1*min(n))+1);
    hold on; 
    stem(nInput,yy,'LineStyle','-.',...
     'MarkerFaceColor','red',...
     'MarkerEdgeColor','green');
    hold off; 
    textVisibilityOn(handles);
    set(handles.t1,'String','y[');
    set(handles.t2,'String',nInput);
    set(handles.t3,'String','] = ');
    set(handles.text11,'String',yy);
end

% ----------------------------------


% ----------------------------------
% Plot real part graph1
% ----------------------------------
function plot_realPartGraph1(handles)
st = get(handles.startTimeText,'String');
et = get(handles.endTimeText,'String');
a = get(handles.amplitudeText,'String');
w = get(handles.wText,'String');
as = get(handles.amplitudeSignPopUpMenu,'Value');
nText = get(handles.nInputText,'String');

stInput = str2double(st);
etInput = str2double(et);
aInput = str2double(a);
wInput = str2double(w);
aSignInput = as;
axes(handles.realPartGraph1)
n = stInput:etInput;
t = min(n):0.1:max(n);
N = length(n);
nInput =  str2double(nText);

if(aSignInput == 1)
    disp('aInput >0');
    ev = real(aInput.^(t)); % OK
    y = aInput.^(n).*exp(1i*wInput*n); % OK
elseif(aSignInput == 2)
    disp('aInput <0');
    ev = real(aInput.^(t)); % OK
    y = (-1*aInput).^(n).*exp(1i*wInput*n); % OK
end

h = plot(t,-ev,'r',t,ev,'r');
hold on;
h = stem(n,real(y),'b');
set(h(1),'Marker','.');
hold off;
box on;
grid on;
title('Decaying Exponential');

if(nInput > stInput && nInput < etInput)
    axes(handles.realPartGraph1)
    disp('real part graph1');
    y  = real(y);
    yy = y(nInput+(-1*min(n))+1);
    hold on; 
    stem(nInput,yy,'LineStyle','-.',...
     'MarkerFaceColor','red',...
     'MarkerEdgeColor','green');
    hold off;
    textVisibilityOn(handles);
    set(handles.t11,'String','y[');
    set(handles.t22,'String',nInput);
    set(handles.t33,'String','] = ');
    set(handles.text12,'String',yy);
end
% ----------------------------------



% ----------------------------------
% Plot imaginary part graph
% ----------------------------------
function plot_imaginaryPartGraph(handles)
st = get(handles.startTimeText,'String');
et = get(handles.endTimeText,'String');
a = get(handles.amplitudeText,'String');
w = get(handles.wText,'String');
as = get(handles.amplitudeSignPopUpMenu,'Value');
nText = get(handles.nInputText,'String');


stInput = str2double(st);
etInput = str2double(et);
aInput = str2double(a);
wInput = str2double(w);
aSignInput = as;
axes(handles.imaginaryPartGraph)
n = stInput:etInput;
t = min(n):0.1:max(n);
N = length(n);
nInput =  str2double(nText);


if(aSignInput == 1)
    disp('aInput >0');
    ev = real(aInput.^(-t)); % OK
    y = aInput.^(-n).*exp(1i*wInput*n); % OK
elseif(aSignInput == 2) % amplitude negative
    ev = real(aInput.^(-t)); % OK
    y = (-1*aInput).^(-n).*exp(1i*wInput*n); % OK
end

h = plot(t,-ev,'r',t,ev,'r');
hold on;
h = stem(n,imag(y),'b');
set(h(1),'Marker','.');
hold off;
box on;
grid on;
xlabel('Time(n)');
ylabel('Imaginary Part');
if(nInput > stInput && nInput < etInput)
    axes(handles.imaginaryPartGraph)
    disp('imaginary part graph');
    y  = imag(y);
    yy = y(nInput+(-1*min(n))+1);
    hold on; 
    stem(nInput,yy,'LineStyle','-.',...
     'MarkerFaceColor','red',...
     'MarkerEdgeColor','green');
    hold off;
    textVisibilityOn(handles);
    set(handles.t111,'String','y[');
    set(handles.t222,'String',nInput);
    set(handles.t333,'String','] = ');
    set(handles.text13,'String',yy);
end

% ----------------------------------

% ----------------------------------
% Plot imaginary part graph1
% ----------------------------------
function plot_imaginaryPartGraph1(handles)
st = get(handles.startTimeText,'String');
et = get(handles.endTimeText,'String');
a = get(handles.amplitudeText,'String');
w = get(handles.wText,'String');
as = get(handles.amplitudeSignPopUpMenu,'Value');
nText = get(handles.nInputText,'String');


stInput = str2double(st);
etInput = str2double(et);
aInput = str2double(a);
wInput = str2double(w);
aSignInput = as;

axes(handles.imaginaryPartGraph1)
n = stInput:etInput;
t = min(n):0.1:max(n);
N = length(n);
nInput =  str2double(nText);

if(aSignInput == 1)
    disp('aInput >0');
    ev = real(aInput.^(t)); % OK
    y = aInput.^(n).*exp(1i*wInput*n); % OK
elseif(aSignInput == 2)
    disp('aInput <0');
    ev = real(aInput.^(t)); % OK
    y = (-1*aInput).^(n).*exp(1i*wInput*n); % OK
end

h = plot(t,-ev,'r',t,ev,'r');
hold on;
h = stem(n,imag(y),'b');
set(h(1),'Marker','.');
hold off;
box on;
grid on;
xlabel('Time(n)');

if(nInput > stInput && nInput < etInput)
    axes(handles.imaginaryPartGraph1)
    disp('imaginary part graph1');
    y  = imag(y);
    yy = y(nInput+(-1*min(n))+1);
    hold on; 
    stem(nInput,yy,'LineStyle','-.',...
     'MarkerFaceColor','red',...
     'MarkerEdgeColor','green');
    hold off;
    textVisibilityOn(handles);
    set(handles.t1111,'String','y[');
    set(handles.t2222,'String',nInput);
    set(handles.t3333,'String','] = ');
    set(handles.text14,'String',yy);
end


% ----------------------------------

% ----------------------------------
% Plot combine graph
% ----------------------------------
function plot_combineGraph(handles)

st = get(handles.startTimeText,'String');
et = get(handles.endTimeText,'String');
a = get(handles.amplitudeText,'String');
w = get(handles.wText,'String');
as = get(handles.amplitudeSignPopUpMenu,'Value');
nText = get(handles.nInputText,'String');


stInput = str2double(st);
etInput = str2double(et);
aInput = str2double(a);
wInput = str2double(w);
aSignInput = as;

n = stInput:etInput;
t = min(n):0.1:max(n);
N = length(n);
nInput =  str2double(nText);

if(aSignInput == 2)
    aInput = -1*aInput;
end
axes(handles.combineGraph)

xd = aInput.^(-n).*exp(1i*wInput*n); % discrete time
xc = aInput.^(-t).*exp(1i*wInput*t); % continuous time
h = plot3(t,real(xc),imag(xc),'r');

hold on;
    for c1 = 1:length(n)
        h = plot3([n(c1) n(c1)],[0 real(xd(c1))],[0 imag(xd(c1))],'b');
    end
hold off;
box off;
grid on;
xlabel('Time (Samples)');
ylabel('Real Part');
zlabel('Imaginary Part');
view(27.5,22);
  

mytitle=sprintf('y[n] = %.2f^ne^{jwn}, where \\omega = %.2f',aInput, wInput);
title(mytitle)

%title('y[n] =A^ne^{jwn}');


if(nInput > stInput && nInput < etInput)
    axes(handles.combineGraph)
    disp('imaginary part graph1');
    xdReal = real(xd);
    xdImag = imag(xd);
    hold on;
    stem3(nInput,xdReal(nInput-min(n)+1),xdImag(nInput-min(n)+1),'g');
    hold off;
end
% ----------------------------------



% ----------------------------------
% Plot combine graph1
% ----------------------------------

function plot_combineGraph1(handles)

st = get(handles.startTimeText,'String');
et = get(handles.endTimeText,'String');
a = get(handles.amplitudeText,'String');
w = get(handles.wText,'String');
as = get(handles.amplitudeSignPopUpMenu,'Value');
nText = get(handles.nInputText,'String');


stInput = str2double(st);
etInput = str2double(et);
aInput = str2double(a);
wInput = str2double(w);
aSignInput = as;

n = stInput:etInput;
t = min(n):0.1:max(n);
N = length(n);
nInput =  str2double(nText);

if(aSignInput == 2)
    aInput = -1*aInput;
end
axes(handles.combineGraph1)

xd = aInput.^(n).*exp(1i*wInput*n); % discrete time
xc = aInput.^(t).*exp(1i*wInput*t); % continuous time
h = plot3(t,real(xc),imag(xc),'r');

hold on;
    for c1 = 1:length(n)
        h = plot3([n(c1) n(c1)],[0 real(xd(c1))],[0 imag(xd(c1))],'b');
    end
hold off;
box off;
grid on;
xlabel('Time (Samples)');
ylabel('Real Part');
zlabel('Imaginary Part');
view(27.5,22);

if(nInput > stInput && nInput < etInput)
    axes(handles.combineGraph1)
    disp('imaginary part graph1');
    xdReal = real(xd);
    xdImag = imag(xd);
    hold on;
    stem3(nInput,xdReal(nInput-min(n)+1),xdImag(nInput-min(n)+1),'g');
    hold off;
end
% ----------------------------------


function textVisibilityOff(handles)

set(handles.t1,'visible','off');
set(handles.t2,'visible','off');
set(handles.t3,'visible','off');
set(handles.t11,'visible','off');
set(handles.t22,'visible','off');
set(handles.t33,'visible','off');
set(handles.t111,'visible','off');
set(handles.t222,'visible','off');
set(handles.t333,'visible','off');
set(handles.t1111,'visible','off');
set(handles.t2222,'visible','off');
set(handles.t3333,'visible','off');
set(handles.text11,'visible','off');
set(handles.text12,'visible','off');
set(handles.text13,'visible','off');
set(handles.text14,'visible','off');

function textVisibilityOn(handles)

set(handles.t1,'visible','on');
set(handles.t2,'visible','on');
set(handles.t3,'visible','on');
set(handles.t11,'visible','on');
set(handles.t22,'visible','on');
set(handles.t33,'visible','on');
set(handles.t111,'visible','on');
set(handles.t222,'visible','on');
set(handles.t333,'visible','on');
set(handles.t1111,'visible','on');
set(handles.t2222,'visible','on');
set(handles.t3333,'visible','on');
set(handles.text11,'visible','on');
set(handles.text12,'visible','on');
set(handles.text13,'visible','on');
set(handles.text14,'visible','on');



% --- Executes during object creation, after setting all properties.
function realPartGraph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to realPartGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate realPartGraph


% --- Executes during object creation, after setting all properties.
function realPartGraph1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to realPartGraph1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate realPartGraph1


% --- Executes during object creation, after setting all properties.
function imaginaryPartGraph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imaginaryPartGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate imaginaryPartGraph


% --- Executes during object creation, after setting all properties.
function imaginaryPartGraph1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imaginaryPartGraph1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate imaginaryPartGraph1


% --- Executes on selection change in amplitudeSignPopUpMenu.
function amplitudeSignPopUpMenu_Callback(hObject, eventdata, handles)
% hObject    handle to amplitudeSignPopUpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
aSign = get(hObject,'Value');

switch aSign
    case 1
        plot_realPartGraph(handles);
        plot_imaginaryPartGraph(handles);
        plot_combineGraph(handles);
        plot_combineGraph1(handles);
        plot_realPartGraph1(handles);
        plot_imaginaryPartGraph1(handles);
    case 2
        plot_realPartGraph(handles);
        plot_imaginaryPartGraph(handles);
        plot_combineGraph(handles);
        plot_combineGraph1(handles);
        plot_realPartGraph1(handles);
        plot_imaginaryPartGraph1(handles);
end

% Hints: contents = cellstr(get(hObject,'String')) returns amplitudeSignPopUpMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from amplitudeSignPopUpMenu

% --- Executes during object creation, after setting all properties.
function amplitudeSignPopUpMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitudeSignPopUpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nInputText_Callback(hObject, eventdata, handles)
% hObject    handle to nInputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue = str2double(get(hObject,'String'));

if(isempty(sliderValue) ||  sliderValue > 100 || sliderValue < -100)
    set(handles.nSlider,'Value',0);
    set(handles.nInputText,'String','0');
else
    set(handles.nSlider,'Value',sliderValue);
    plot_realPartGraph(handles);
    plot_realPartGraph1(handles);
    plot_imaginaryPartGraph(handles);
    plot_imaginaryPartGraph1(handles);
    plot_combineGraph(handles);
    plot_combineGraph1(handles);
end
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of nInputText as text
%        str2double(get(hObject,'String')) returns contents of nInputText as a double


% --- Executes during object creation, after setting all properties.
function nInputText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nInputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function nSlider_Callback(hObject, eventdata, handles)
% hObject    handle to nSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue = get(handles.nSlider,'Value');

if(isempty(sliderValue) || sliderValue > 100 || sliderValue < -100)
    set(handles.nSlider,'Value',0);
    set(handles.nInputText,'String','0'); 
else
    set(handles.nInputText,'String',num2str(sliderValue));
    plot_realPartGraph(handles);
    plot_realPartGraph1(handles);
    plot_imaginaryPartGraph(handles);
    plot_imaginaryPartGraph1(handles);
    plot_combineGraph(handles);
    plot_combineGraph1(handles);
end
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function nSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_realPartGraph(handles);
plot_realPartGraph1(handles);
plot_imaginaryPartGraph(handles);
plot_imaginaryPartGraph1(handles);
plot_combineGraph(handles);
plot_combineGraph1(handles);
set(handles.startText,'visible','off');


function startText_Callback(hObject, eventdata, handles)
% hObject    handle to startText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startText as text
%        str2double(get(hObject,'String')) returns contents of startText as a double


% --- Executes during object creation, after setting all properties.
function startText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
