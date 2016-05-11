% Final Year Project CE
% Author            : Nonny Florentine (U1320766B)
% Sub-GUI
% Continuous-time signal to Discrete-time signal wave
% Created:          6 september 2015
% Latest Update:    1. 13 September 2015
%                   2. 23 september 2015
%                       - Graph auto update once User change input
%                           parameters
%                       - To include show x(nT) using Check box
%                       - Change UI design
%                       - Plot Harmonic 
%                   3. 25 september 2015
%                       - auto update input 
%                       - x(nT) Check Box
%                   4. 30 september 2015
%                       - Harmonic in x(t)
%                       - Phase 
%             
%

function varargout = continuousTimeToDiscreteTimeSineSignal(varargin)
% continuousTimeToDiscreteTimeSineSignal MATLAB code for continuousTimeToDiscreteTimeSineSignal.fig
%      continuousTimeToDiscreteTimeSineSignal, by itself, creates a new continuousTimeToDiscreteTimeSineSignal or raises the existing
%      singleton*.
%
%      H = continuousTimeToDiscreteTimeSineSignal returns the handle to a new continuousTimeToDiscreteTimeSineSignal or the handle to
%      the existing singleton*.
%
%      CotToDiscrete('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in continuousTimeToDiscreteTimeSineSignal.M with the given input arguments.
%
%      continuousTimeToDiscreteTimeSineSignal('Property','Value',...) creates a new continuousTimeToDiscreteTimeSineSignal or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before continuousTimeToDiscreteTimeSineSignal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to continuousTimeToDiscreteTimeSineSignal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help continuousTimeToDiscreteTimeSineSignal

% Last Modified by GUIDE v2.5 05-Oct-2015 14:51:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @continuousTimeToDiscreteTimeSineSignal_OpeningFcn, ...
                   'gui_OutputFcn',  @continuousTimeToDiscreteTimeSineSignal_OutputFcn, ...
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


% --- Executes just before continuousTimeToDiscreteTimeSineSignal is made visible.
function continuousTimeToDiscreteTimeSineSignal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to continuousTimeToDiscreteTimeSineSignal (see VARARGIN)

% Choose default command line output for continuousTimeToDiscreteTimeSineSignal

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

set(hObject,'toolbar','figure');

axes(handles.ctEquation)
imshow('Sine.png')
plot_signal(handles,0);
%axes(handles.dtEquation)
%imshow('/Users/admin/Documents/MATLAB/FYP/Chapter1/Screenshot 2015-09-30 00.16.46.png')


% Update handles structure

guidata(hObject, handles);

% UIWAIT makes continuousTimeToDiscreteTimeSineSignal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = continuousTimeToDiscreteTimeSineSignal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Amplitude User Input
function amplitudeText_Callback(hObject, eventdata, handles)
% hObject    handle to amplitudeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));
if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)
    
    plot_signal(handles,0);   
   
    guidata(hObject,handles);
end


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


% Frequency User Input
function frequencyText_Callback(hObject, eventdata, handles)
% hObject    handle to frequencyText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)
    plot_signal(handles,0);   
    guidata(hObject,handles);
    
end

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


% Start Time User Input
function startTimeText_Callback(hObject, eventdata, handles)
% hObject    handle to startTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

plot_signal(handles,0);
    
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


% End Time User Input
function endTimeText_Callback(hObject, eventdata, handles)
% hObject    handle to endTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input==input)
    plot_signal(handles,0);
 
    guidata(hObject,handles);
end
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


% Phase User Input
function phaseText_Callback(hObject, eventdata, handles)
% hObject    handle to phaseText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input==input)
    plot_signal(handles,0);
    
    guidata(hObject,handles);
end
% Hints: get(hObject,'String') returns contents of phaseText as text
%        str2double(get(hObject,'String')) returns contents of phaseText as a double


% --- Executes during object creation, after setting all properties.
function phaseText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phaseText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Sampling Frequency User Input
function samplingFrequencyText_Callback(hObject, eventdata, handles)
% hObject    handle to samplingFrequencyText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)
    plot_signal(handles,0);
    
    guidata(hObject,handles);
end
% Hints: get(hObject,'String') returns contents of samplingFrequencyText as text
%        str2double(get(hObject,'String')) returns contents of samplingFrequencyText as a double


% --- Executes during object creation, after setting all properties.
function samplingFrequencyText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplingFrequencyText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% plot signal
function plot_signal(handles, isComputeN)

%waveType = get(handles.wavePopup,'String');
waveIndex = get(handles.wavePopup,'Value');
harmony = get(handles.harmonyPopup,'Value');
isPlotHarmony = get(handles.harmonyCheck,'Value');
isPlotXnt = get(handles.showXntCheck,'Value');
a = get(handles.amplitudeText,'String'); % Amplitude
f = get(handles.frequencyText,'String'); % Frequency
st = get(handles.startTimeText,'String'); % Start time
et = get(handles.endTimeText,'String'); % End time
phase = get(handles.phaseText,'String'); % Phase
fs = get(handles.samplingFrequencyText,'String'); % Sampling Frequency

aInput = str2double(a); % Amplitude
fInput = str2double(f); % Frequency
stInput = str2double(st); % Start time
etInput = str2double(et); % End time
phaseInput = str2double(phase)*pi/180; % Phase in degree
fsInput = str2double(fs); % Sampling Frequency


% continuous Graph
axes(handles.continuousGraph)
t = stInput:0.00005:etInput; % Time Interval
switch waveIndex
    case 1 %'Sine'
        xt = aInput*sin(2*pi*fInput*t+phaseInput); % x(t)=A*cos(2*pi*f*t+phase)
    case 2 %'Square'
        %fundamental
        harmonic = zeros(length(t),harmony);
        for har=0:harmony-1
            harmo = 2*har+1;
            harmonic(:,har+1) = (4/pi)*aInput*(1/harmo)*sin(2*pi*harmo*fInput*t);
            
        end
        xt = sum(harmonic,2);
        if isPlotHarmony
            plot(t,harmonic);
            hold on;
        end
   case 3 %'Sawtooth'
        %fundamental 
        harmonic = zeros(length(t),harmony);
        for har=0:harmony-1
            harmo = 1+har;
            harmonic(:,har+1) = (1/pi)*aInput*(1/harmo)*sin(2*pi*harmo*fInput*t);
        end
        xt = 1/2 - sum(harmonic,2);
        if isPlotHarmony
            plot(t,harmonic);
            hold on;
        end
   case 4 %'Triangle'
        %fundamental 
        harmonic = zeros(length(t),harmony);
        for har=0:harmony-1
            harmo = 1+2*har;
            harmonic(:,har+1) = (8/pi^2)*(((-1)^((harmo-1)/2))/(harmo^2))*aInput*(1/harmo)*sin(2*pi*harmo*fInput*t);
        end  
        xt = sum(harmonic,2);
        if isPlotHarmony
            plot(t,harmonic);
            hold on;
        end
end

plot(t,xt,'black'); % plot x(t)
axis([t(1) t(end) min(xt) max(xt)]);
hold off;

%title('Continuous-time signal x(t)');
xlabel('Time, s');
ylabel('Amplitude');
%guidata(hObject,handles);

% Discrete Graph
axes(handles.discreteGraph)
tn = stInput:1/fsInput:etInput; % Time Interval for x[n]
n = tn*fsInput; % n= t*Fs
if isComputeN
    nStr = get(handles.nText,'String');
    if isempty(n)
        isComputeN = 0;
    else
        nInput = str2double(nStr); % get sample to be displayed
        nIndex = nInput - n(1) + 1;
    end
end

switch waveIndex
    case 1 %'Sine'
        xn = aInput*sin((2*pi*(fInput/fsInput)*n+phaseInput)); % x[n]=A*cos(2*pi*(f/Fs)*n + phase)
    case 2 %'Square'
        xn = (4/pi)*aInput*sin(2*pi*(fInput/fsInput)*n);
        for har=1:harmony-1
            harmo = 2*har+1;
            xn = xn + (4/pi)*(1/harmo)*aInput*sin(2*pi*harmo*(fInput/fsInput)*n);
        end
    case 3 %'Sawtooth'
        xn = 1/2 - (1/pi)*aInput*sin(2*pi*(fInput/fsInput)*n);
        for har=1:harmony-1
            harmo = har+1;
            xn = xn - (1/pi)*(1/harmo)*aInput*sin(2*pi*harmo*(fInput/fsInput)*n );
        end
    case 4  
        %'Triangle'
        xn = (8/pi^2)*aInput*sin(2*pi*(fInput/fsInput)*n);
        for har=1:harmony-1
            harmo = 1+2*har;
            xn = xn + (8/pi^2)*(((-1)^((harmo-1)/2))/(harmo^2))*aInput*(1/harmo)*sin(2*pi*harmo*(fInput/fsInput)*n);
        end
end

% correct pi error
xn(find(and((xn < 1e-10),(xn > -1e-10)))) = 0;


stem(n,xn,'r'); % plot x[n]
if isComputeN %compute value of specific sample
    hold on;
    stem(nInput,xn(nIndex),'g');
    set(handles.nValue,'String', num2str(xn(nIndex)));
end
if isPlotXnt % if plot xnt
    hold on;
    plot(n,xn,'b');
end
axis([n(1) n(end) min(xt) max(xt)]);
%title('Discrete-time signal x[n]');
xlabel('Time index n'); 
ylabel('Amplitude');
hold off;





% --- Executes during object creation, after setting all properties.
function continuousGraph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to continuousGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate continuousGraph


% --- Executes during object creation, after setting all properties.
function discreteGraph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to discreteGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate discreteGraph


% --- Executes during object creation, after setting all properties.
    
    
% n User Input
function nText_Callback(hObject, eventdata, handles)
% hObject    handle to nText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));
b=int32(input); %%%%%%%%%%%%%%%
if isnumeric(b)
  display(b);
else 
  errordlg('You must enter a integer value','Invalid Input','modal')
  uicontrol(hObject)
  
end
% Hints: get(hObject,'String') returns contents of nText as text
%        str2double(get(hObject,'String')) returns contents of nText as a double


% --- Executes during object creation, after setting all properties.
function nText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% To show the x[n] value after entering input n 
% --- Executes during object creation, after setting all properties.
function nValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% To get the value of x[n] and show on the graph
% --- Executes on button press in calculateXnButton.
function calculateXnButton_Callback(hObject, eventdata, handles)
% hObject    handle to calculateXnButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Input Parameters
st = get(handles.startTimeText,'String'); % Start time
et = get(handles.endTimeText,'String'); % End time
fs = get(handles.samplingFrequencyText,'String'); % Sampling Frequency
n = get(handles.nText,'String');

if isempty(n)
    msgbox('Invalid input n','Error');
    return
end

stInput = str2double(st); % Start time
etInput = str2double(et); % End time
fsInput = str2double(fs); % Sampling Frequency
nUserInput = str2double(n); % n User Input

newStartTime = floor(nUserInput/fsInput);
newEndTime = newStartTime + etInput - stInput;

set(handles.startTimeText,'String',num2str(newStartTime));
set(handles.endTimeText,'String',num2str(newEndTime));

plot_signal(handles,1);
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function xnText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xnText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in showXntCheck.
function showXntCheck_Callback(hObject, eventdata, handles)
% hObject    handle to showXntCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showXntCheck

plot_signal(handles,1);

function leftContGraphSlider_Callback(hObject, eventdata, handles)
% hObject    handle to leftContGraphSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of leftContGraphSlider as text
%        str2double(get(hObject,'String')) returns contents of leftContGraphSlider as a double


% --- Executes during object creation, after setting all properties.
function leftContGraphSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftContGraphSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rightContGraphSlider_Callback(hObject, eventdata, handles)
% hObject    handle to rightContGraphSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rightContGraphSlider as text
%        str2double(get(hObject,'String')) returns contents of rightContGraphSlider as a double


% --- Executes during object creation, after setting all properties.
function rightContGraphSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightContGraphSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function discreteTimeSlider_Callback(hObject, eventdata, handles)
% hObject    handle to discreteTimeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function discreteTimeSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to discreteTimeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function contTimeGraphSlider_Callback(hObject, eventdata, handles)
% hObject    handle to contTimeGraphSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function contTimeGraphSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contTimeGraphSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function ctEquation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ctEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate ctEquation


% --- Executes during object creation, after setting all properties.
function dtEquation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dtEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate dtEquation


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in wavePopup.
function wavePopup_Callback(hObject, eventdata, handles)
% hObject    handle to wavePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns wavePopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wavePopup
waveType = get(hObject,'Value');
switch waveType
    case 1
        axes(handles.ctEquation);
        imshow('Sine.png');
    case 2
        axes(handles.ctEquation);
        imshow('Square.png');
    case 3
        axes(handles.ctEquation);
        imshow('Sawtooth.png');
    case 4
        axes(handles.ctEquation);
        imshow('Triangle.png');
end
plot_signal(handles,0);

% --- Executes during object creation, after setting all properties.
function wavePopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wavePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function harmonyText_Callback(hObject, eventdata, handles)
% hObject    handle to harmonyText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of harmonyText as text
%        str2double(get(hObject,'String')) returns contents of harmonyText as a double


% --- Executes during object creation, after setting all properties.
function harmonyText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to harmonyText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in harmonyPopup.
function harmonyPopup_Callback(hObject, eventdata, handles)
% hObject    handle to harmonyPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns harmonyPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from harmonyPopup
plot_signal(handles,0);

% --- Executes during object creation, after setting all properties.
function harmonyPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to harmonyPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in harmonyCheck.
function harmonyCheck_Callback(hObject, eventdata, handles)
% hObject    handle to harmonyCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of harmonyCheck
plot_signal(handles,0);
