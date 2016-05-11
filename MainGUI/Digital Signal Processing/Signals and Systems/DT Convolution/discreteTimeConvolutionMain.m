% Final Year Project CE
% Author:           Nonny Florentine (U1320766B)
% Sub-GUI
% Discrete-Time Convolution
% Created:          2 October 2015
% Latest Update:    1. 22-25 December 2015
%                       - User can input different type of signals x[n],
%                       h[n]
%                       - delay for "all input signal" is working
%                       - shifting n value for the signals graph is working
%                       - flip "exponential" is now working
%                       - causality radio button is working
%                   2. 2-6 January 2016
%                       - Sine, Cosine and exponential signal functionality
%                       checked
%                   3. 7/8 January 2016
%                       - All signals functionalities need to be checked
%                   4. 9/10 January 2016
%                       - to do the multiplication graph
%
%
%
%


function varargout = discreteTimeConvolutionMain(varargin)
% DISCRETETIMECONVOLUTIONMAIN MATLAB code for discreteTimeConvolutionMain.fig
%      DISCRETETIMECONVOLUTIONMAIN, by itself, creates a new DISCRETETIMECONVOLUTIONMAIN or raises the existing
%      singleton*.
%
%      H = DISCRETETIMECONVOLUTIONMAIN returns the handle to a new DISCRETETIMECONVOLUTIONMAIN or the handle to
%      the existing singleton*.
%
%      DISCRETETIMECONVOLUTIONMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISCRETETIMECONVOLUTIONMAIN.M with the given input arguments.
%
%      DISCRETETIMECONVOLUTIONMAIN('Property','Value',...) creates a new DISCRETETIMECONVOLUTIONMAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before discreteTimeConvolutionMain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to discreteTimeConvolutionMain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help discreteTimeConvolutionMain

% Last Modified by GUIDE v2.5 21-Feb-2016 15:20:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @discreteTimeConvolutionMain_OpeningFcn, ...
                   'gui_OutputFcn',  @discreteTimeConvolutionMain_OutputFcn, ...
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


% --- Executes just before discreteTimeConvolutionMain is made visible.
function discreteTimeConvolutionMain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to discreteTimeConvolutionMain (see VARARGIN)

% Choose default command line output for discreteTimeConvolutionMain
handles.output = hObject;
set(hObject,'toolbar','figure');
enableEditText_all(handles);
reset_all(handles);
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
cla(handles.graphConvolve,'reset')
cla(handles.graphMultiply,'reset')
plot_signal(handles);
plot_signal1(handles);
plot_signalCombine(handles);
plot_signalConvolve(handles);
cla(handles.graphConvolve,'reset')
cla(handles.graphMultiply,'reset')
guidata(hObject,handles);

% UIWAIT makes discreteTimeConvolutionMain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = discreteTimeConvolutionMain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in signalPopUpMenu.
% --- To change the user input parameters for specific signal
% for x[n]
function signalPopUpMenu_Callback(hObject, eventdata, handles)
% hObject    handle to signalPopUpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signalType = get(hObject,'Value');
switch signalType
    case 1
        reset_values(handles);
        enableEditText_all(handles);    
        
    case 2 % Sine 
        set(handles.startText,'visible','off');
        reset_values(handles);
        plot_signal(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText,'enable','on');
        set(handles.periodText,'enable','on');
        set(handles.lengthText,'enable','on');
        set(handles.delayText,'enable','on');
        set(handles.phaseText,'enable','on'); 
        set(handles.scalingFactorText,'enable','off');
        set(handles.expoConstantText,'enable','off');
        set(handles.userSignalText,'enable','off');
        set(handles.nonCausalRadioButton,'enable','off');
        set(handles.causalRadioButton,'enable','off');
          
    case 3 % Cosine
        set(handles.startText,'visible','off');
        reset_values(handles);
        plot_signal(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText,'enable','on');
        set(handles.periodText,'enable','on');
        set(handles.lengthText,'enable','on');
        set(handles.delayText,'enable','on');
        set(handles.phaseText,'enable','on');
        set(handles.scalingFactorText,'enable','off');
        set(handles.expoConstantText,'enable','off');
        set(handles.userSignalText,'enable','off');
        set(handles.nonCausalRadioButton,'enable','off');
        set(handles.causalRadioButton,'enable','off');
        
        
    case 4 % Exponential
        set(handles.startText,'visible','off');
        reset_values(handles);
        plot_signal(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText,'enable','off');
        set(handles.periodText,'enable','off');
        set(handles.lengthText,'enable','on');
        set(handles.delayText,'enable','on');
        set(handles.phaseText,'enable','off');
        set(handles.scalingFactorText,'enable','on');
        set(handles.expoConstantText,'enable','on');
        set(handles.userSignalText,'enable','off');
        set(handles.nonCausalRadioButton,'enable','on');
        set(handles.nonCausalRadioButton,'Value',1);
        set(handles.causalRadioButton,'enable','on');
        
    case 5 % Pulse
        set(handles.startText,'visible','off');
        reset_values(handles);
        plot_signal(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText,'enable','on');
        set(handles.lengthText,'enable','on');
        set(handles.delayText,'enable','on');
        set(handles.periodText,'enable','off');
        set(handles.phaseText,'enable','off');  
        set(handles.scalingFactorText,'enable','off');
        set(handles.expoConstantText,'enable','off');
        set(handles.userSignalText,'enable','off');
        set(handles.nonCausalRadioButton,'enable','off');
        set(handles.causalRadioButton,'enable','off');
        
        
    case 6 % Unit Sample
        set(handles.startText,'visible','off');
        reset_values(handles);
        plot_signal(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText,'enable','on');
        set(handles.delayText,'enable','on');
        set(handles.lengthText,'enable','off');
        set(handles.periodText,'enable','off');
        set(handles.phaseText,'enable','off');  
        set(handles.scalingFactorText,'enable','off');
        set(handles.expoConstantText,'enable','off');
        set(handles.userSignalText,'enable','off');
        set(handles.nonCausalRadioButton,'enable','off');
        set(handles.causalRadioButton,'enable','off');
       
        
    case 7 % User Signal
        set(handles.startText,'visible','off');
        reset_values(handles);
        plot_signal(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText,'enable','off');
        set(handles.periodText,'enable','off');
        set(handles.lengthText,'enable','off');
        set(handles.delayText,'enable','off');
        set(handles.phaseText,'enable','off');  
        set(handles.scalingFactorText,'enable','off');
        set(handles.expoConstantText,'enable','off');
        set(handles.userSignalText,'enable','on');
        set(handles.nonCausalRadioButton,'enable','off');
        set(handles.causalRadioButton,'enable','off');
        
end

% Hints: contents = cellstr(get(hObject,'String')) returns signalPopUpMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from signalPopUpMenu


% --- Executes during object creation, after setting all properties.
function signalPopUpMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signalPopUpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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
else
    plot_signal(handles); 
    plot_signalCombine(handles); 
    plot_signalConvolve(handles);
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



function periodText_Callback(hObject, eventdata, handles)
% hObject    handle to periodText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)   
    plot_signal(handles);  
    plot_signalCombine(handles);
    plot_signalConvolve(handles);
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



function lengthText_Callback(hObject, eventdata, handles)
% hObject    handle to lengthText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)
    plot_signal(handles); 
    plot_signalCombine(handles);
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of lengthText as text
%        str2double(get(hObject,'String')) returns contents of lengthText as a double


% --- Executes during object creation, after setting all properties.
function lengthText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lengthText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function phaseText_Callback(hObject, eventdata, handles)
% hObject    handle to phaseText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
else
    plot_signal(handles);  
    plot_signalCombine(handles); 
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

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



function delayText_Callback(hObject, eventdata, handles)
% hObject    handle to delayText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input==input)
    plot_signal(handles);  
    plot_signalCombine(handles);  
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of delayText as text
%        str2double(get(hObject,'String')) returns contents of delayText as a double


% --- Executes during object creation, after setting all properties.
function delayText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delayText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in okButton.
function okButton_Callback(hObject, eventdata, handles)
% hObject    handle to okButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cancelButton.
function cancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% -----------------------------
% reset all
% -----------------------------
function reset_all(handles)
cla(handles.graph,'reset')
cla(handles.graph1,'reset')
cla(handles.graph2,'reset')
cla(handles.graphConvolve,'reset')
cla(handles.graphMultiply,'reset')

set(handles.amplitudeText,'String','1');
set(handles.periodText,'String','10');
set(handles.phaseText,'String','0');
set(handles.lengthText,'String','10');
set(handles.delayText,'String','0');
set(handles.scalingFactorText,'String','1');
set(handles.expoConstantText,'String','0.5');
set(handles.userSignalText,'String','[1 1 1 1]');

set(handles.amplitudeText1,'String','1');
set(handles.periodText1,'String','10');
set(handles.phaseText1,'String','0');
set(handles.lengthText1,'String','10');
set(handles.delayText1,'String','0');
set(handles.scalingFactorText1,'String','1');
set(handles.expoConstantText1,'String','0.5');
set(handles.userSignalText1,'String','[1 1 1 1]');

set(handles.nSlider,'Value',-5);
set(handles.nText,'String','-5');

set(handles.fliphn,'Value',1);
set(handles.flipxn,'Value',0);

set(handles.t1,'visible','off');
set(handles.t2,'visible','off');
set(handles.t3,'visible','off');
set(handles.t4,'visible','off');

% -----------------------------

% -----------------------------
% reset values for x[n] input
% -----------------------------
function reset_values(handles)
set(handles.amplitudeText,'String','1');
set(handles.periodText,'String','10');
set(handles.phaseText,'String','0');
set(handles.lengthText,'String','10');
set(handles.delayText,'String','0');
set(handles.scalingFactorText,'String','1');
set(handles.expoConstantText,'String','0.5');
set(handles.userSignalText,'String','[1 1 1 1]');

set(handles.nSlider,'Value',-5);
set(handles.nText,'String','-5');

set(handles.fliphn,'Value',1);
set(handles.flipxn,'Value',0);
% -----------------------------

% -----------------------------
% reset values for h[n] input
% -----------------------------
function reset_values1(handles)
set(handles.amplitudeText1,'String','1');
set(handles.periodText1,'String','10');
set(handles.phaseText1,'String','0');
set(handles.lengthText1,'String','10');
set(handles.delayText1,'String','0');
set(handles.scalingFactorText1,'String','1');
set(handles.expoConstantText1,'String','0.5');
set(handles.userSignalText1,'String','[1 1 1 1]');

set(handles.nSlider,'Value',-5);
set(handles.nText,'String','-5');

set(handles.fliphn,'Value',1);
set(handles.flipxn,'Value',0);
% -----------------------------



% -----------------------------
% enable all the edit text
% -----------------------------
function enableEditText_all(handles)
set(handles.amplitudeText,'enable','off');
set(handles.periodText,'enable','off');
set(handles.lengthText,'enable','off');
set(handles.delayText,'enable','off');
set(handles.phaseText,'enable','off'); 
set(handles.scalingFactorText,'enable','off');
set(handles.expoConstantText,'enable','off');
set(handles.userSignalText,'enable','off');
set(handles.nonCausalRadioButton,'enable','off');
set(handles.causalRadioButton,'enable','off');
set(handles.amplitudeText1,'enable','off');
set(handles.periodText1,'enable','off');
set(handles.lengthText1,'enable','off');
set(handles.delayText1,'enable','off');
set(handles.phaseText1,'enable','off'); 
set(handles.scalingFactorText1,'enable','off');
set(handles.expoConstantText1,'enable','off');
set(handles.userSignalText1,'enable','off');
set(handles.nonCausalRadioButton1,'enable','off');
set(handles.causalRadioButton1,'enable','off');
% -----------------------------



% -----------------------------
% plot h[n]
% -----------------------------
function plot_signal1(handles)

signalIndex = get(handles.signalPopUpMenu1,'Value');
causalRB = get(handles.causalRadioButton1,'Value');
nonCausalRB = get(handles.nonCausalRadioButton1,'Value');

a = get(handles.amplitudeText1,'String');
p = get(handles.periodText1,'String');
phase = get(handles.phaseText1,'String');
l = get(handles.lengthText1,'String');
delay = get(handles.delayText1,'String');
sf = get(handles.scalingFactorText1,'String');
ec = get(handles.expoConstantText1,'String');
st = eval(get(handles.userSignalText1,'String'));

aInput = str2double(a);
periodInput = str2double(p);
phaseInput = str2double(phase);
lengthInput = str2double(l);
delayInput = str2double(delay);
scalingFactorInput = str2double(sf);
expoConstantInput = str2double(ec);
signalInput = (st);

% selects graph1 as the current axes
axes(handles.graph1)

switch signalIndex
    case 1
        reset_values(handles);
        enableEditText_all(handles);
        
    case 2  % Sine
        xData = delayInput : delayInput + lengthInput - 1;
        yData = aInput*sin(2*pi/periodInput*(0:lengthInput-1)+phaseInput);
        xData = xData';
        yData = yData';
        stem(xData,yData,'r');
        title('Impulse Response');

    case 3  % Cosine
        xData = delayInput:delayInput + lengthInput - 1;
        yData = aInput*cos(2*pi/periodInput*(0:lengthInput-1)+phaseInput);
        xData = xData';
        yData = yData';
        stem(xData,yData,'r');
        title('Impulse Response');
        
    case 4  % Exponential
        if causalRB == 1
            xData = delayInput : (delayInput + lengthInput - 1);
            yData = scalingFactorInput*(expoConstantInput).^(0:lengthInput-1);
        elseif nonCausalRB == 1
            xData = (delayInput - lengthInput + 1):delayInput;
            yData = scalingFactorInput*(expoConstantInput).^(lengthInput-1:-1:0);
        xData = xData';
        yData = yData';
        end
        stem(xData,yData,'r');
        title('Impulse Response');
        
    case 5  % Pulse
        xData = delayInput:delayInput + lengthInput - 1;
        yData = aInput*ones(lengthInput,1);
        xData = xData';
        stem(xData,yData,'r');
        title('Impulse Response');
        
    case 6  % Unit Sample
        xData = delayInput;
        yData = aInput;
        stem(xData,yData,'r');
        title('Impulse Response');

    case 7  % User Signal
        xData = 0:1:length(signalInput)-1;
        yData = signalInput;
        stem(xData,yData,'r');
        title('Impulse Response');
end 
% -----------------------------




% -----------------------------
% plot x[n]
% -----------------------------
function plot_signal(handles)

signalIndex = get(handles.signalPopUpMenu,'Value');
causalRB = get(handles.causalRadioButton,'Value');
nonCausalRB = get(handles.nonCausalRadioButton,'Value');

a = get(handles.amplitudeText,'String');        % amplitude
p = get(handles.periodText,'String');           % period
phase = get(handles.phaseText,'String');        % phase
l = get(handles.lengthText,'String');           % length
delay = get(handles.delayText,'String');        % delay
sf = get(handles.scalingFactorText,'String');   % scaling factor
ec = get(handles.expoConstantText,'String');    % exponential constant
st = eval(get(handles.userSignalText,'String'));% user signal, in vector (use 'eval' instead of 'get')

aInput = str2double(a);
periodInput = str2double(p);
phaseInput = str2double(phase);
lengthInput = str2double(l);
delayInput = str2double(delay);
scalingFactorInput = str2double(sf);
expoConstantInput = str2double(ec);
signalInput = (st);


axes(handles.graph)

switch signalIndex
    case 1
    case 2  % Sine
        xData = delayInput : delayInput + lengthInput - 1;
        yData = aInput*sin(2*pi/periodInput*(0:lengthInput-1)+phaseInput);
        xData = xData';
        yData = yData';
        stem(xData,yData,'b');
        title('Input');

    case 3  % Cosine
        xData = delayInput:delayInput + lengthInput - 1;
        yData = aInput*cos(2*pi/periodInput*(0:lengthInput-1)+phaseInput);
        xData = xData';
        yData = yData';
        stem(xData,yData,'b');
        title('Input');
        
    case 4  % Exponential
        if causalRB == 1
            xData = delayInput : (delayInput + lengthInput - 1);
            yData = scalingFactorInput*(expoConstantInput).^(0:lengthInput-1);
        elseif nonCausalRB == 1
            xData = (delayInput - lengthInput +1):delayInput;
            yData = scalingFactorInput*(expoConstantInput).^(lengthInput-1:-1:0);
        xData = xData';
        yData = yData';
        end
        stem(xData,yData,'b');
        title('Input');
        
    case 5  % Pulse
        xData = delayInput:delayInput + lengthInput - 1;
        yData = aInput*ones(lengthInput,1);
        xData = xData';
        stem(xData,yData,'b');
        title('Input');
        
    case 6  % Unit Sample
        xData = delayInput;
        yData = aInput;
        stem(xData,yData,'b');
        title('Input');

    case 7  % User Signal
        xData = 0:(length(signalInput)-1);
        yData = signalInput;
        stem(xData,yData,'b');
        title('Input');
end   
% -----------------------------

% -----------------------------
% plot combine signal
% -----------------------------
function plot_signalCombine(handles)

flipXn = get(handles.flipxn,'Value');
flipHn = get(handles.fliphn,'Value');

signalIndex = get(handles.signalPopUpMenu,'Value');
causalRB = get(handles.causalRadioButton,'Value');
nonCausalRB = get(handles.nonCausalRadioButton,'Value');

a = get(handles.amplitudeText,'String');
p = get(handles.periodText,'String');
phase = get(handles.phaseText,'String');
l = get(handles.lengthText,'String');
delay = get(handles.delayText,'String');
sf = get(handles.scalingFactorText,'String');
ec = get(handles.expoConstantText,'String');
st = eval(get(handles.userSignalText,'String'));
n = get(handles.nText,'String');

aInput = str2double(a);
periodInput = str2double(p);
phaseInput = str2double(phase);
lengthInput = str2double(l);
delayInput = str2double(delay);
scalingFactorInput = str2double(sf);
expoConstantInput = str2double(ec);
signalInput = (st);
nInput = str2double(n);

axes(handles.graph2)

switch signalIndex
    case 1
    case 2  % Sine
        hold off
        if flipHn == 1
            xData = delayInput : delayInput + lengthInput - 1;
            yData = aInput*sin(2*pi/periodInput*(0:lengthInput-1)+phaseInput);
        elseif flipXn == 1
            xData = (-delayInput+nInput - lengthInput + 1):-delayInput+nInput;
            yData = flip(aInput*sin(2*pi/periodInput*(0:lengthInput-1)+phaseInput));
        xData = xData';
        yData = yData';
        end
        stem(xData,yData,'b');
        legend('x[n]')
        hold on
        
    case 3  % Cosine
        hold off
        if flipHn == 1
            xData = delayInput:delayInput + lengthInput - 1;
            yData = aInput*cos(2*pi/periodInput*(0:lengthInput-1)+phaseInput);
        elseif flipXn == 1
            xData = (-delayInput+nInput - lengthInput + 1):-delayInput+nInput;
            yData = flip(aInput*cos(2*pi/periodInput*(0:lengthInput-1)+phaseInput));
        xData = xData';
        yData = yData';
        end
        stem(xData,yData,'b');
        legend('x[n]')
        hold on        
        
    case 4  % Exponential
        hold off
        if causalRB == 1
            if flipHn == 1
                xData = delayInput : (delayInput + lengthInput - 1);
                yData = scalingFactorInput*(expoConstantInput).^(0:lengthInput-1);
            elseif flipXn == 1
                xData = (-delayInput+nInput - lengthInput + 1):-delayInput+nInput;
                yData = scalingFactorInput*(expoConstantInput).^(lengthInput-1:-1:0);
            end   
        elseif nonCausalRB == 1
            if flipHn == 1
                xData = (delayInput - lengthInput + 1):delayInput;
                yData = scalingFactorInput*(expoConstantInput).^(lengthInput-1:-1:0);
            elseif flipXn == 1
                xData = -delayInput+nInput : (-delayInput + lengthInput - 1+nInput);
                yData = scalingFactorInput*(expoConstantInput).^(0:lengthInput-1);
            end
        xData = xData';
        yData = yData';
        end
        stem(xData,yData,'b');
        legend('x[n]')
        hold on      
        
    case 5  % Pulse
        hold off
        if flipHn == 1
            xData = delayInput:delayInput + lengthInput - 1;
            yData = aInput*ones(lengthInput,1);
        elseif flipXn == 1
            xData = (-delayInput+nInput - lengthInput + 1):-delayInput+nInput;
            yData = flip(aInput*ones(lengthInput,1));
        xData = xData';
        end
        stem(xData,yData,'b');
        legend('x[n]')
        hold on       
        
    case 6  % Unit Sample
        hold off
        if flipHn == 1
            xData = delayInput;
            yData = aInput;
        elseif flipXn == 1
            xData = -(delayInput)+nInput;
            yData = flip(aInput);
        end    
        stem(xData,yData,'b');
        legend('x[n]')
        hold on 
    
    case 7  % User Signal
        hold off
        if flipHn == 1
            xData = 0:(length(signalInput)-1);
            yData = signalInput;
        elseif flipXn == 1
            xData = 0+nInput:(length(signalInput)-1+nInput);
            yData = flip(signalInput);
        end
        stem(xData,yData,'b');
        legend('x[n]')
        hold on
end 


flipXn = get(handles.flipxn,'Value');
flipHn = get(handles.fliphn,'Value');
signalIndex1 = get(handles.signalPopUpMenu1,'Value');
causalRB1 = get(handles.causalRadioButton1,'Value');
nonCausalRB1 = get(handles.nonCausalRadioButton1,'Value');
a1 = get(handles.amplitudeText1,'String');
p1 = get(handles.periodText1,'String');
phase1 = get(handles.phaseText1,'String');
l1 = get(handles.lengthText1,'String');
delay1 = get(handles.delayText1,'String');
sf1 = get(handles.scalingFactorText1,'String');
ec1 = get(handles.expoConstantText1,'String');
st1 = eval(get(handles.userSignalText1,'String'));

aInput1 = str2double(a1);
periodInput1 = str2double(p1);
phaseInput1 = str2double(phase1);
lengthInput1 = str2double(l1);
delayInput1 = str2double(delay1);
scalingFactorInput1 = str2double(sf1);
expoConstantInput1 = str2double(ec1);
signalInput1 = (st1);

totalDelayAdd = delayInput + delayInput1;

axes(handles.graph2)

switch signalIndex1
    case 1
    case 2  % Sine
        if flipXn == 1
            xData1 = delayInput1 : delayInput1 + lengthInput1 - 1;
            yData1 = aInput1*sin(2*pi/periodInput1*(0:lengthInput1-1)+phaseInput1);
        elseif flipHn == 1
            xData1 = (-delayInput1 - lengthInput1 + 1)+nInput:-delayInput1+nInput;
            yData1 = flip(aInput1*sin(2*pi/periodInput1*(0:lengthInput1-1)+phaseInput1));
        xData1 = xData1';
        yData1 = yData1';
        end
        stem(xData1,yData1,'r');       
        
        if(flipXn == 1)
            legend('x[n-k]','h[n]')
            set(handles.saText1,'String','h[k]');
            set(handles.saText,'String','x[n-k]');         
        elseif(flipHn == 1)
            legend('x[n]','h[n-k]')
            set(handles.saText,'String','x[k]');
            set(handles.saText1,'String','h[n-k]');          
        end
        
      

    case 3  % Cosine
        if flipXn == 1
            xData1 = delayInput1:delayInput1 + lengthInput1 - 1;
            yData1 = aInput1*cos(2*pi/periodInput1*(0:lengthInput1-1)+phaseInput1);
        elseif flipHn == 1
            xData1 = (-delayInput1 - lengthInput1 + 1)+nInput:-delayInput1+nInput;
            yData1 = flip(aInput1*cos(2*pi/periodInput1*(0:lengthInput1-1)+phaseInput1));
        xData1 = xData1';
        yData1 = yData1';
        end
        stem(xData1,yData1,'r');
        legend('x[n]','h[n]')
        
        if(flipXn == 1)
            set(handles.saText1,'String','h[k]');
            set(handles.saText,'String','x[n-k]');
        elseif(flipHn == 1)
            set(handles.saText,'String','x[k]');
            set(handles.saText1,'String','h[n-k]');
        end
        
        
    case 4  % Exponential
         if causalRB1 == 1
            if flipXn == 1
                xData1 = delayInput1 : (delayInput1 + lengthInput1 - 1);
                yData1 = scalingFactorInput1*(expoConstantInput1).^(0:lengthInput1-1);
            elseif flipHn == 1
                xData1 = (-delayInput1+nInput - lengthInput1 + 1):-delayInput1+nInput;
                yData1 = scalingFactorInput1*(expoConstantInput1).^(lengthInput1-1:-1:0);
            end   
        elseif nonCausalRB1 == 1
            if flipXn == 1
                xData1 = (delayInput1 - lengthInput1 + 1):delayInput1;
                yData1 = scalingFactorInput1*(expoConstantInput1).^(lengthInput1-1:-1:0);
            elseif flipHn == 1
                xData1 = -delayInput1+nInput : (-delayInput1 + lengthInput1 - 1+nInput);
                yData1 = scalingFactorInput1*(expoConstantInput1).^(0:lengthInput1-1);
            end
        xData1 = xData1';
        yData1 = yData1';
        end
        stem(xData1,yData1,'r');
        legend('x[n]','h[n]')
        
        if(flipXn == 1)
            set(handles.saText1,'String','h[k]');
            set(handles.saText,'String','x[n-k]');
        elseif(flipHn == 1)
            set(handles.saText,'String','x[k]');
            set(handles.saText1,'String','h[n-k]');
        end
        
        
    case 5  % Pulse
        
        if flipXn == 1
            xData1 = delayInput1:delayInput1 + lengthInput1 - 1;
            yData1 = aInput1*ones(lengthInput1,1);
        elseif flipHn == 1
            xData1 = (-delayInput1 - lengthInput1 + 1)+nInput:-delayInput1+nInput;
            yData1 = flip(aInput1*ones(lengthInput1,1));
        xData1 = xData1';
        end
        stem(xData1,yData1,'r');
        legend('x[n]','h[n]')
        
        if(flipXn == 1)
            set(handles.saText1,'String','h[k]');
            set(handles.saText,'String','x[n-k]');
        elseif(flipHn == 1)
            set(handles.saText,'String','x[k]');
            set(handles.saText1,'String','h[n-k]');
        end
        
    case 6  % Unit Sample
        if flipXn == 1
            xData1 = delayInput1;
            yData1 = aInput1;
        elseif flipHn == 1
            xData1 = -(delayInput1)+nInput;
            yData1 = flip(aInput1);
        end 
        stem(xData1,yData1,'r');
        legend('x[n]','h[n]')
        
        if(flipXn == 1)
            set(handles.saText1,'String','h[k]');
            set(handles.saText,'String','x[n-k]');
        elseif(flipHn == 1)
            set(handles.saText,'String','x[k]');
            set(handles.saText1,'String','h[n-k]');
        end
        

    case 7  % User Signal 
        if flipXn == 1
        %signalInput = str(signalInput);
            xData1 = 0:(length(signalInput1)-1);
            yData1 = signalInput;
        elseif flipHn == 1
            xData1 = nInput-length(signalInput1)+1:nInput;
            yData1 = flip(signalInput1);
        end
        stem(xData1,yData1,'r');
        legend('x[n]','h[n]')
        
        if(flipXn == 1)
            set(handles.saText1,'String','h[k]');
            set(handles.saText,'String','x[n-k]');
        elseif(flipHn == 1)
            set(handles.saText,'String','x[k]');
            set(handles.saText1,'String','h[n-k]');
        end
        
end 
% -----------------------------

% -----------------------------
% plot convolution
% -----------------------------
function plot_signalConvolve(handles)
flipXn = get(handles.flipxn,'Value');
flipHn = get(handles.fliphn,'Value');

signalIndex = get(handles.signalPopUpMenu,'Value');
causalRB = get(handles.causalRadioButton,'Value');
nonCausalRB = get(handles.nonCausalRadioButton,'Value');

a = get(handles.amplitudeText,'String');
p = get(handles.periodText,'String');
phase = get(handles.phaseText,'String');
l = get(handles.lengthText,'String');
delay = get(handles.delayText,'String');
sf = get(handles.scalingFactorText,'String');
ec = get(handles.expoConstantText,'String');
st = eval(get(handles.userSignalText,'String'));
n = get(handles.nText,'String');

aInput = str2double(a);
periodInput = str2double(p);
phaseInput = str2double(phase);
lengthInput = str2double(l);
delayInput = str2double(delay);
scalingFactorInput = str2double(sf);
expoConstantInput = str2double(ec);
signalInput = (st);
nInput = str2double(n);

signalIndex1 = get(handles.signalPopUpMenu1,'Value');
causalRB1 = get(handles.causalRadioButton1,'Value');
nonCausalRB1 = get(handles.nonCausalRadioButton1,'Value');
causalRB = get(handles.causalRadioButton,'Value');
nonCausalRB = get(handles.nonCausalRadioButton,'Value');
a1 = get(handles.amplitudeText1,'String');
p1 = get(handles.periodText1,'String');
phase1 = get(handles.phaseText1,'String');
l1 = get(handles.lengthText1,'String');
delay1 = get(handles.delayText1,'String');
sf1 = get(handles.scalingFactorText1,'String');
ec1 = get(handles.expoConstantText1,'String');
st1 = eval(get(handles.userSignalText1,'String'));

aInput1 = str2double(a1);
periodInput1 = str2double(p1);
phaseInput1 = str2double(phase1);
lengthInput1 = str2double(l1);
delayInput1 = str2double(delay1);
scalingFactorInput1 = str2double(sf1);
expoConstantInput1 = str2double(ec1);
signalInput1 = (st1);
totalDelayAdd = delayInput + delayInput1;
% -----------------------------

% -----------------------------
% signal index for x[n]
% signalIndex
% -----------------------------
switch signalIndex
    case 1
    case 2  % Sine
        xData = delayInput : delayInput + lengthInput - 1;
        yData = aInput*sin(2*pi/periodInput*(0:lengthInput-1)+phaseInput);
        xData = xData';
        yData = yData';

    case 3  % Cosine
        xData = delayInput:delayInput + lengthInput - 1;
        yData = aInput*cos(2*pi/periodInput*(0:lengthInput-1)+phaseInput);
        xData = xData';
        yData = yData';
 
    case 4  % Exponential
        if causalRB == 1
            xData = delayInput : (delayInput + lengthInput - 1);
            yData = scalingFactorInput*(expoConstantInput).^(0:lengthInput-1);
            xData = xData';   
        elseif nonCausalRB == 1
            xData = (delayInput - lengthInput + 1):delayInput;
            yData = scalingFactorInput*(expoConstantInput).^(lengthInput-1:-1:0);
        xData = xData';
        yData = yData';
        end
        
    case 5  % Pulse
        xData = delayInput:delayInput + lengthInput - 1;
        yData = aInput*ones(lengthInput,1);
        xData = xData';
        
    case 6  % Unit Sample
        xData = delayInput;
        yData = aInput;

    case 7  % User Signal
        xData = 0:(length(signalInput)-1);
        yData = signalInput;
               
end 
% end of signalIndex switch case
% -----------------------------

% -----------------------------
% signal index for h[n]
% signalIndex1
% -----------------------------
switch signalIndex1
    case 1
    case 2  % h[n], Sine
        xData1 = delayInput1 : delayInput1 + lengthInput1 - 1;
        yData1 = aInput1*sin(2*pi/periodInput1*(0:lengthInput1-1)+phaseInput1);
        xData1 = xData1';
        yData1 = yData1';
        xnDataMin = min(xData);
        hnDataMin = min(xData1);
        minData = xnDataMin+hnDataMin;
        xnDataMax = max(xData);
        hnDataMax = max(xData1);
        maxData = xnDataMax+hnDataMax;
        xValue = conv(yData1,yData);
        convolutionLength = length(xValue)-1;
    
        if(signalIndex==4)      % if x[n] is an exponential graph
            if(causalRB)        % if x[n] is causal
                t = minData: maxData;
            elseif(nonCausalRB) % elseif x[n] is noncausal
                t = xData(1)+delayInput1:xData1(length(xData1))+delayInput;
            end
        else
            t= totalDelayAdd: convolutionLength+totalDelayAdd;
        end 
        axes(handles.graphConvolve)
        stem(t,xValue,'LineStyle','-',...
             'MarkerFaceColor','yellow',...
             'MarkerEdgeColor','black');
        hold on
        if (flipXn == 1)
            title('Linear Convolution y[n] = \Sigma h[k]x[n-k]');
        elseif(flipHn == 1)
            title('Linear Convolution y[n] = \Sigma x[k]h[n-k]');
        end          
        hold off
        
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        u = yData;
        v = yData1;
        k = nInput+1-totalDelayAdd;

        m = length(u);
        n = length(v);
        w = m+n-1;
        % -----------------------------
        
        % -----------------------------
        % to plot the stem on convolution graph
        % input value nInput shift to show the stem value in the convolution graph
        % -----------------------------
        convolutionData = xValue;
        xnTimeMin = min(xData);
        xnTimeMax = max(xData);
        lengthXn = length(xData);
        lengthHn = length(xData1);
            
        lengthMax = max(lengthXn,lengthHn);
        lengthMin = min(lengthXn,lengthHn);
        
        flipXnTimeMin = -(xnTimeMax);
        flipXnTimeMax = -(xnTimeMin);

        hnTimeMin = min(xData1);
        hnTimeMax = max(xData1);

        flipHnTimeMin = -(hnTimeMax);
        flipHnTimeMax = -(hnTimeMin);
        % -----------------------------
        
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        yMax = max(convolutionData);
        yMin = min(convolutionData);
        % -----------------------------
        
        if(flipHnTimeMax+nInput >= xnTimeMin && flipHnTimeMin+nInput <= xnTimeMax || flipXnTimeMax+nInput >= hnTimeMin && flipXnTimeMin+nInput <= hnTimeMax)
            % -----------------------------
            % last check on 7th January 2016
            % for x[n] = exponential
            %     h[n] = sine
            % ----------------------------- 
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            if(signalIndex==4)
                if(nonCausalRB) % convolution graph (OK), all functions (OK), flip x[n] and h[n] (OK), multiplication graph (OK)
                    disp('plotting the for x[n] exponential noncausal h[n] sine');
                    if(lengthXn>lengthHn)
                        %disp('1');
                        convolutionTime = t(nInput+lengthMax-totalDelayAdd);
                        lengthFinal = lengthMax;
                        k = nInput+lengthMax-totalDelayAdd; % for multiplication graph
                    elseif(lengthXn<lengthHn)
                        %disp('2');
                        convolutionTime = t(nInput+lengthMin-totalDelayAdd);
                        lengthFinal = lengthMin;
                        k = nInput+lengthMin-totalDelayAdd; % for multiplication graph
                    elseif(lengthXn==lengthHn)
                        %disp('3');
                        convolutionTime = t(nInput+lengthXn-totalDelayAdd);
                        lengthFinal = lengthXn;
                        k = nInput+lengthXn-totalDelayAdd; % for multiplication graph
                    end
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+lengthFinal-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+lengthFinal-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    lengthMin = min(length(xData),length(xData1));
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
            
                    axes(handles.graphMultiply) 
                    stem(j+totalDelayAdd-lengthMin,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph 
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                    
                elseif(causalRB) % convolution graph (OK), all functions (OK), flip x[n] and h[n] (OK), multiplication graph (OK)
                    disp('plotting the for x[n] exponential causal h[n] sine');
                    convolutionTime = t(nInput+1-totalDelayAdd);
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+1-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    u = yData';
                    v = yData1;
                    lengthMin = min(length(xData),length(xData1));
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    k = nInput+1-totalDelayAdd;
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
                    axes(handles.graphMultiply) 
                    stem(j-1+totalDelayAdd,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                end
                
            % -----------------------------    
            % last check on 7th January (OK) 
            % for x[n] = sine or cosine
            %     h[n] = sine
            % -----------------------------
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            elseif(signalIndex==2 || signalIndex ==3) % multiplication graph (OK)
                disp('plotting the for x[n] either sine/cosine h[n] sine');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
                
            % -----------------------------            
            % last check on 7th January 2016  
            % for x[n] = pulse
            %     h[n] = sine
            % -----------------------------   
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            elseif(signalIndex==5) % multiplication graph (OK)
                disp('plotting the stem for x[n] pulse, h[n] sine');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off 
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
                
            % ----------------------------- 
            % last check on 7th January 2016
            % for x[n] = unit sample
            %     h[n] = sine
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            elseif(signalIndex==6)
                disp('plotting the stem for x[n] unit sample, h[n] sine');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
                
            % -----------------------------
            % last check on 7th January 2016
            % for x[n] = user signal
            %     h[n] = sine
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            elseif(signalIndex==7)
                disp('plotting the stem for x[n] user signal, h[n] sine'); 
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5)
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                u = yData';
                v = yData1;
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
            end
 
        else
            cla(handles.graphMultiply,'reset')
            set(handles.t1,'visible','off');
            set(handles.t2,'visible','off');
            set(handles.t3,'visible','off');
            set(handles.t4,'visible','off');
            
            disp('empty');
        end
            
        
        
    case 3  %  h[n], Cosine
        xData1 = delayInput1:delayInput1 + lengthInput1 - 1;
        yData1 = aInput1*cos(2*pi/periodInput1*(0:lengthInput1-1)+phaseInput1);
        xData1 = xData1';
        yData1 = yData1';
        xnDataMin = min(xData);
        hnDataMin = min(xData1);
        minData = xnDataMin+hnDataMin;
  
        xnDataMax = max(xData);
        hnDataMax = max(xData1);
        maxData = xnDataMax+hnDataMax;
        xValue = conv(yData1,yData);
        convolutionLength = length(xValue)-1;

        if(signalIndex==4)      % if x[n] is an exponential graph
            if(causalRB)        % if x[n] is causal
                t = minData: maxData;
            elseif(nonCausalRB) % elseif x[n] is noncausal
                t = xData(1)+delayInput1:xData1(length(xData1))+delayInput;
            end
        else
            t= totalDelayAdd: convolutionLength+totalDelayAdd;
        end  
        axes(handles.graphConvolve)
        stem(t,xValue,'LineStyle','-',...              
            'MarkerFaceColor','yellow',...              
            'MarkerEdgeColor','black');
        hold on
        if (flipXn == 1)
            title('Linear Convolution y[n] = \Sigma h[k]x[n-k]');
        elseif(flipHn == 1)
            title('Linear Convolution y[n] = \Sigma x[k]h[n-k]');
        end 
        hold off
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        u = yData;
        v = yData1;
        k = nInput+1-totalDelayAdd;

        m = length(u);
        n = length(v);
        w = m+n-1;
        % -----------------------------
        
        % -----------------------------
        % to plot the stem on convolution graph
        % -----------------------------
        convolutionData = xValue;
        xnTimeMin = min(xData);
        xnTimeMax = max(xData);
        lengthXn = length(xData);
        lengthHn = length(xData1);
            
        lengthMax = max(lengthXn,lengthHn);
        lengthMin = min(lengthXn,lengthHn);

        flipXnTimeMin = -(xnTimeMax);
        flipXnTimeMax = -(xnTimeMin);

        hnTimeMin = min(xData1);
        hnTimeMax = max(xData1);

        flipHnTimeMin = -(hnTimeMax);
        flipHnTimeMax = -(hnTimeMin);
        % -----------------------------
        
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        yMax = max(convolutionData);
        yMin = min(convolutionData);
        % -----------------------------
 
        if(flipHnTimeMax+nInput >= xnTimeMin && flipHnTimeMin+nInput <= xnTimeMax || flipXnTimeMax+nInput >= hnTimeMin && flipXnTimeMin+nInput <= hnTimeMax)
            % -----------------------------
            % last check on 7th January 2016
            % for x[n] = exponential
            %     h[n] = cosine
            % ----------------------------- 
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            if(signalIndex==4)
                if(nonCausalRB) % convolution graph (OK), all functions (OK), flip x[n] and h[n] (OK)
                    disp('plotting the for x[n] exponential noncausal h[n] cosine');
                    if(lengthXn>lengthHn)
                        convolutionTime = t(nInput+lengthMax-totalDelayAdd);
                        lengthFinal = lengthMax;
                        k = nInput+lengthMax-totalDelayAdd; % for multiplication graph
                    elseif(lengthXn<lengthHn)
                        convolutionTime = t(nInput+lengthMin-totalDelayAdd);
                        lengthFinal = lengthMin;
                        k = nInput+lengthMin-totalDelayAdd; % for multiplication graph
                    elseif(lengthXn==lengthHn)
                        convolutionTime = t(nInput+lengthXn-totalDelayAdd);
                        lengthFinal = lengthXn;
                        k = nInput+lengthXn-totalDelayAdd; % for multiplication graph
                    end
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+lengthFinal-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+lengthFinal-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    lengthMin = min(length(xData),length(xData1));
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
            
                    axes(handles.graphMultiply) 
                    stem(j+totalDelayAdd-lengthMin,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph 
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                    
                elseif(causalRB) % convolution graph (OK), all functions (OK), flip x[n] and h[n] (OK)
                    disp('plotting the for x[n] exponential causal h[n] cosine');
                    convolutionTime = t(nInput+1-totalDelayAdd);
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+1-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    u = yData';
                    v = yData1;
                    lengthMin = min(length(xData),length(xData1));
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    k = nInput+1-totalDelayAdd;
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
                    axes(handles.graphMultiply) 
                    stem(j-1+totalDelayAdd,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                end
            % -----------------------------    
            % last check on 7th January (OK) 
            % for x[n] = sine or cosine
            %     h[n] = cosine
            % -----------------------------
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)  
            % -----------------------------
            elseif(signalIndex==2 || signalIndex==3) % multiplication graph (OK)
                disp('plotting the for x[n] either sine/cosine h[n] cosine');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
                
            % -----------------------------
            % last check on 7th January
            % for x[n] = pulse
            %     h[n] = cosine
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % ----------------------------- 
            elseif(signalIndex==5) 
                disp('plotting the stem for x[n] pulse, h[n] cosine');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
                
            % -----------------------------    
            % last check on 7th January 2016
            % for x[n] = unit sample
            %     h[n] = cosine
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------   
            elseif(signalIndex==6)
                disp('plotting the stem for x[n ]unit sample, h[n] cosine');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5)
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
                
                
                
            % -----------------------------
            % last check on 7th January 2016
            % for x[n] = user signal
            %     h[n] = cosine
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % ----------------------------- 
            elseif(signalIndex==7)
                disp('plotting the stem for x[n] user signal, h[n] cosine');  
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5)
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                u = yData';
                v = yData1;
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
            end
        else
            disp('empty');
            cla(handles.graphMultiply,'reset')
            set(handles.t1,'visible','off');
            set(handles.t2,'visible','off');
            set(handles.t3,'visible','off');
            set(handles.t4,'visible','off');
        end
        
    case 4  % h[n], Exponential
        if causalRB1 == 1
            xData1 = delayInput1 : (delayInput1 + lengthInput1 - 1);
            yData1 = scalingFactorInput1*(expoConstantInput1).^(0:lengthInput1-1);
            xnDataMin = min(xData);
            hnDataMin = min(xData1);
            minData = xnDataMin+hnDataMin;
            xnDataMax = max(xData);
            hnDataMax = max(xData1);
            maxData = xnDataMax+hnDataMax;
            
            xData1 = xData1';
            yData1 = yData1';
            xValue = conv(yData1,yData);
            
            if(signalIndex==4)
                if(nonCausalRB)
                    t = xData(1)+delayInput1:xData1(length(xData1))+delayInput;
                elseif(causalRB)
                    t = minData: maxData;
                end
            elseif(signalIndex==2 || signalIndex==3)           
                t = minData: maxData;
            elseif(signalIndex==5)
                t = minData: maxData;
            elseif(signalIndex==6)
                t = minData: maxData;
            elseif(signalIndex==7)
                t = minData: maxData;     
            end
            
        elseif nonCausalRB1 == 1
            xData1 = (delayInput1 - lengthInput1 + 1):delayInput1;
            yData1 = scalingFactorInput1*(expoConstantInput1).^(lengthInput1-1:-1:0);
            xnDataMin = min(xData);
            hnDataMin = min(xData1);
            minData = xnDataMin+hnDataMin;
            xnDataMax = max(xData);
            hnDataMax = max(xData1);
            maxData = xnDataMax+hnDataMax;
            
            xData1 = xData1';
            yData1 = yData1';
            xValue = conv(yData1,yData);
            
            if(signalIndex==4)
                if(nonCausalRB) % OK
                    t = minData: maxData;
                elseif(causalRB)
                    %t = -convolutionLength/2+totalDelayAdd:convolutionLength/2+totalDelayAdd;
                    t = xData1(1)+delayInput:xData(length(xData))+delayInput1;
                end
            elseif(signalIndex==2 || signalIndex==3)
                %t = -convolutionLength/2+totalDelayAdd:convolutionLength/2+totalDelayAdd
                t = xData1(1)+delayInput:xData(length(xData))+delayInput1;
            elseif(signalIndex==5)
                t = xData1(1)+delayInput:xData(length(xData))+delayInput1;
            elseif(signalIndex==6)
                t = xData1(1)+delayInput:xData(length(xData))+delayInput1;
            elseif(signalIndex==7)
                t = xData1(1)+delayInput:xData(length(xData))+delayInput1;
            end
        end
        axes(handles.graphConvolve)
        stem(t,xValue,'LineStyle','-',...              
            'MarkerFaceColor','yellow',...              
            'MarkerEdgeColor','black');
        hold on
        if (flipXn == 1)
            title('Linear Convolution y[n] = \Sigma h[k]x[n-k]');
        elseif(flipHn == 1)
            title('Linear Convolution y[n] = \Sigma x[k]h[n-k]');
        end 
        hold off
        
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        u = yData;
        v = yData1;
        k = nInput+1-totalDelayAdd;

        m = length(u);
        n = length(v);
        w = m+n-1;
        % ----------------------------- 
        
        % -----------------------------
        % for stem plotting in convolution graph
        % -----------------------------
        if causalRB1 == 1
            convolutionData = xValue;
            lengthXn = length(xData);
            lengthHn = length(xData1);
            
            lengthMax = max(lengthXn,lengthHn);
            lengthMin = min(lengthXn,lengthHn);
            xnTimeMin = min(xData);
            xnTimeMax = max(xData);

            flipXnTimeMin = -(xnTimeMax);
            flipXnTimeMax = -(xnTimeMin);

            hnTimeMin = min(xData1);
            hnTimeMax = max(xData1);

            flipHnTimeMin = -(hnTimeMax);
            flipHnTimeMax = -(hnTimeMin);
            
            % -----------------------------
            % for multiplication graph
            % set x axes and y axes values
            % -----------------------------
            yMax = max(convolutionData);
            yMin = min(convolutionData);
            % ----------------------------- 

            
           if((flipHnTimeMin+nInput <= xnTimeMax && flipHnTimeMax+nInput >= xnTimeMin) || (flipXnTimeMin+nInput <= hnTimeMax && flipXnTimeMax+nInput >= hnTimeMin ))
               % -----------------------------
               % last check on 7th January 2016
               % for x[n] = exponential
               %     h[n] = exponential causal
               % ----------------------------- 
               % flip x[n] and h[n] (OK)
               % all functions (OK)
               % combine graph (OK)
               % multiplication graph (pending)
               % convolution graph (OK)
               % ----------------------------- 
               if(signalIndex==4) 
                    if(nonCausalRB) % convolution graph (OK), all functions (OK), flip x[n] and h[n] (OK), multiplication graph (OK)
                        disp('plotting the stem exponential signal, x[n] non causal, h[n] causal');
                        if(lengthXn<lengthHn)
                            convolutionTime = t(nInput+lengthMin-totalDelayAdd);
                            lengthFinal = lengthMin;
                            k = nInput+lengthMin-totalDelayAdd; % for multiplication graph
                        elseif(lengthXn>lengthHn)
                            convolutionTime = t(nInput+lengthMax-totalDelayAdd);
                            lengthFinal = lengthMax;
                            k = nInput+lengthMax-totalDelayAdd; % for multiplication graph
                        elseif(lengthXn==lengthHn)
                            convolutionTime = t(nInput+lengthXn-totalDelayAdd);
                            lengthFinal = lengthXn;
                            k = nInput+lengthXn-totalDelayAdd; % for multiplication graph
                        end
                        axes(handles.graphConvolve)
                        hold on
                        stem(convolutionTime,convolutionData(nInput+lengthFinal-totalDelayAdd),'r','LineWidth',1.5);
                        hold off
                        xx =(convolutionTime);
                        yy =(convolutionData(nInput+lengthFinal-totalDelayAdd));
                        set(handles.t1,'visible','on');
                        set(handles.t2,'visible','on');
                        set(handles.t3,'visible','on');
                        set(handles.t4,'visible','on');
                        set(handles.t1,'String','y[');
                        set(handles.t2,'String',xx);
                        set(handles.t3,'String','] = ');
                        set(handles.t4,'String',yy);
                        
                        lengthMin = min(length(xData),length(xData1));
                        
                        % -----------------------------
                        % for multiplication graph
                        % -----------------------------
                        j = max(1,k+1-n):1:min(k,m);
                        a1=u(j);
                        a2=v(k-j+1);
                        a3= a1.*a2;
                        length(xValue);
                        axes(handles.graphMultiply) 
                        stem(j-1+totalDelayAdd-lengthMin+1,a3,'b');
                        ylim([0 yMax])
                        xlim([t(1) t(length(convolutionData))]) % time equal to the convolution graph
                        if(flipHn == 1)
                            title('Multiplication x[k]h[n-k]')
                        elseif(flipXn == 1)
                            title('Multiplication h[k]x[n-k]')
                        end
                        % -----------------------------       
                        
                    elseif(causalRB) % convolution graph (OK), all functions (OK), flip x[n] and h[n] (OK), multiplication graph (OK)
                        disp('plotting the stem exponential signal, both causal');
                        convolutionTime = t(nInput+1-totalDelayAdd);
                        axes(handles.graphConvolve)
                        hold on
                        stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                        hold off
                        xx =(convolutionTime);
                        yy =(convolutionData(nInput+1-totalDelayAdd));
                        set(handles.t1,'visible','on');
                        set(handles.t2,'visible','on');
                        set(handles.t3,'visible','on');
                        set(handles.t4,'visible','on');
                        set(handles.t1,'String','y[');
                        set(handles.t2,'String',xx);
                        set(handles.t3,'String','] = ');
                        set(handles.t4,'String',yy);
                        % -----------------------------
                        % for multiplication graph
                        % -----------------------------
                        u = yData';
                        v = yData1;
                        lengthMin = min(length(xData),length(xData1));
                        k = nInput+1-totalDelayAdd;
                        j = max(1,k+1-n):1:min(k,m);
                        a1=u(j);
                        a2=v(k-j+1);
                        a3= a1.*a2;
                        axes(handles.graphMultiply) 
                        stem(j-1+totalDelayAdd,a3,'b');
                        ylim([yMin yMax])
                        xlim([t(1)-1 t(length(convolutionData))+1]) % time equal to the convolution graph
                        if(flipHn == 1)
                            title('Multiplication x[k]h[n-k]')
                        elseif(flipXn == 1)
                            title('Multiplication h[k]x[n-k]')
                        end
                        % -----------------------------
                    end
                   
                % -----------------------------    
                % last check on 7th January 2016
                % for x[n] = sine or cosine
                %     h[n] = exponential causal
                % -----------------------------
                % flip x[n] and h[n] (OK)
                % all functions (OK)
                % combine graph (OK)
                % multiplication graph (pending)
                % convolution graph (OK)  
                % -----------------------------     
                elseif(signalIndex==2 || signalIndex==3)
                    disp('plotting the stem for x[n] sine/cosine, h[n] exponential causal');  
                    convolutionTime = t(nInput+1-totalDelayAdd);
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+1-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    u = yData';
                    v = yData1;
                    lengthMin = min(length(xData),length(xData1));
                    k = nInput+1-totalDelayAdd;
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
                    axes(handles.graphMultiply) 
                    stem(j-1+totalDelayAdd,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                    
                % -----------------------------   
                % last check on 7th January 2016
                % for x[n] = pulse
                %     h[n] = exponential causal
                % -----------------------------  
                % flip x[n] and h[n] (OK)
                % all functions (OK)
                % combine graph (OK)
                % multiplication graph (pending)
                % convolution graph (OK)
                % ----------------------------- 
                elseif(signalIndex==5)
                    disp('plotting the stem for x[n] pulse, h[n] exponential causal');
                    convolutionTime = t(nInput+1-totalDelayAdd);
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+1-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    k = nInput+1-totalDelayAdd;
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
                    axes(handles.graphMultiply) 
                    stem(j-1+totalDelayAdd,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                    
                % -----------------------------
                % last check on 7th January 2016
                % for x[n] = unit sample
                %     h[n] = exponential causal
                % -----------------------------  
                % flip x[n] and h[n] (OK)
                % all functions (OK)
                % combine graph (OK)
                % multiplication graph (pending)
                % convolution graph (OK)
                % -----------------------------    
                elseif(signalIndex==6)
                    disp('plotting the stem for x[n ]unit sample, h[n] exponential causal');
                    convolutionTime = t(nInput+1-totalDelayAdd);
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+1-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    k = nInput+1-totalDelayAdd;
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
                    axes(handles.graphMultiply) 
                    stem(j-1+totalDelayAdd,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                    
                    
                % -----------------------------    
                % last check on 7th January 2016
                % for x[n] = user signal
                %     h[n] = exponential causal
                % -----------------------------  
                % flip x[n] and h[n] (OK)
                % all functions (OK)
                % combine graph (OK)
                % multiplication graph (pending)
                % convolution graph (OK)
                % -----------------------------    
                elseif(signalIndex==7)
                    disp('plotting the stem for x[n] user signal, h[n] exponential causal'); 
                    axes(handles.graphConvolve)
                    hold on
                    convolutionTime = t(nInput+1-totalDelayAdd);
                    stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5)
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+1-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    k = nInput+1-totalDelayAdd;
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
                    axes(handles.graphMultiply) 
                    stem(j-1+totalDelayAdd,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
               end
            else
                disp('empty');  
                cla(handles.graphMultiply,'reset')
                set(handles.t1,'visible','off');
                set(handles.t2,'visible','off');
                set(handles.t3,'visible','off');
                set(handles.t4,'visible','off');
            end
            
        elseif nonCausalRB1 == 1
            convolutionData = xValue;
            xnTimeMin = min(xData);
            xnTimeMax = max(xData);
            lengthXn = length(xData);
            lengthHn = length(xData1);
            
            lengthMax = max(lengthXn,lengthHn);
            lengthMin = min(lengthXn,lengthHn);

            flipXnTimeMin = -(xnTimeMax);
            flipXnTimeMax = -(xnTimeMin);

            hnTimeMin = min(xData1);
            hnTimeMax = max(xData1);

            flipHnTimeMin = -(hnTimeMax);
            flipHnTimeMax = -(hnTimeMin);
            
            yMax = max(convolutionData);
            yMin = min(convolutionData);
            
            if((flipHnTimeMin+nInput <= xnTimeMax && flipHnTimeMax+nInput >= xnTimeMin) || (flipXnTimeMin+nInput <= hnTimeMax && flipXnTimeMax+nInput >= hnTimeMin ))
                % -----------------------------
                % last check on 7th January 2016
                % for x[n] = exponential
                %     h[n] = exponential non causal
                % ----------------------------- 
                % flip x[n] and h[n] (OK)
                % all functions (OK)
                % combine graph (OK)
                % multiplication graph (pending)
                % convolution graph (OK)
                % ----------------------------- 
                if(signalIndex==4) 
                    if(nonCausalRB) % convolution graph (OK), all functions (OK), flip x[n] and h[n] (OK), multiplication graph (OK)
                        disp('plotting the stem exponential signal, both noncausal');
                        lengthT = length(t)-1;
                        convolutionTime = t(lengthT+nInput+1-totalDelayAdd); 
                        axes(handles.graphConvolve)
                        hold on
                        stem(convolutionTime,convolutionData(lengthT+nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                        hold off
                        xx =(convolutionTime);
                        yy =(convolutionData(lengthT+nInput+1-totalDelayAdd));
                        set(handles.t1,'visible','on');
                        set(handles.t2,'visible','on');
                        set(handles.t3,'visible','on');
                        set(handles.t4,'visible','on');
                        set(handles.t1,'String','y[');
                        set(handles.t2,'String',xx);
                        set(handles.t3,'String','] = ');
                        set(handles.t4,'String',yy);

                       
                        % -----------------------------
                        % for multiplication graph
                        % -----------------------------
                        lengthMin = min(length(xData),length(xData1));
                        k = lengthT+nInput+1-totalDelayAdd;
                        j = max(1,k+1-n):1:min(k,m);
                        a1=u(j);
                        a2=v(k-j+1);
                        a3= a1.*a2;
                        axes(handles.graphMultiply) 
                        stem(j-1+totalDelayAdd+1-lengthMin,a3,'b');
                        ylim([yMin yMax])
                        xlim([t(1)-1 t(length(convolutionData))+1]) % time equal to the convolution graph
                        if(flipHn == 1)
                            title('Multiplication x[k]h[n-k]')
                        elseif(flipXn == 1)
                            title('Multiplication h[k]x[n-k]')
                        end
                        % -----------------------------

                    elseif(causalRB) % convolution graph (OK), all functions (OK), flip x[n] and h[n] (OK), need to check again, multiplication graph (OK)
                        disp('plotting the stem exponential signal, x[n] causal, h[n] noncausal');
                        if(lengthXn<lengthHn)
                            convolutionTime = t(nInput+lengthMax-totalDelayAdd); % for multiplication graph
                            lengthFinal = lengthMax;
                            k = nInput+lengthMax-totalDelayAdd;
                        elseif(lengthXn>lengthHn)
                            convolutionTime = t(nInput+lengthMin-totalDelayAdd); % for multiplication graph
                            lengthFinal = lengthMin;
                            k = nInput+lengthMin-totalDelayAdd;
                        elseif(lengthXn==lengthHn)
                            convolutionTime = t(nInput+lengthXn-totalDelayAdd); % for multiplication graph
                            lengthFinal = lengthXn;
                            k = nInput+lengthXn-totalDelayAdd;
                        end
                        axes(handles.graphConvolve)
                        hold on
                        stem(convolutionTime,convolutionData(nInput+lengthFinal-totalDelayAdd),'r','LineWidth',1.5);
                        hold off
                        xx =(convolutionTime);
                        yy =(convolutionData(nInput+lengthFinal-totalDelayAdd));
                        set(handles.t1,'visible','on');
                        set(handles.t2,'visible','on');
                        set(handles.t3,'visible','on');
                        set(handles.t4,'visible','on');
                        set(handles.t1,'String','y[');
                        set(handles.t2,'String',xx);
                        set(handles.t3,'String','] = ');
                        set(handles.t4,'String',yy);
                        
                        
                        % -----------------------------
                        % for multiplication graph
                        % -----------------------------
                        lengthMin = min(length(xData),length(xData1));
                        u = yData';
                        v = yData1;
                        k = nInput+lengthFinal-totalDelayAdd;
                        j = max(1,k+1-n):1:min(k,m);
                        a1=u(j);
                        a2=v(k-j+1);
                        a3= a1.*a2;
                        length(xValue);
                        axes(handles.graphMultiply) 
                        stem(j-1+totalDelayAdd,a3,'b');
                        ylim([0 yMax])
                        xlim([t(1) t(length(convolutionData))])% time equal to the convolution graph
                        if(flipHn == 1)
                            title('Multiplication x[k]h[n-k]')
                        elseif(flipXn == 1)
                            title('Multiplication h[k]x[n-k]')
                        end
                        % -----------------------------    
                        
   
                    end
                % -----------------------------    
                % last check on 7th January (OK) 
                % for x[n] = sine or cosine
                %     h[n] = exponential non causal
                % -----------------------------
                % flip x[n] and h[n] (OK)
                % all functions (OK)
                % combine graph (OK)
                % multiplication graph (pending)
                % convolution graph (OK)  
                % -----------------------------    
                elseif(signalIndex==2 || signalIndex==3)
                    if(lengthXn>lengthHn)
                        convolutionTime = t(nInput+lengthMin-totalDelayAdd);
                        lengthFinal = lengthMin;
                        k = nInput+lengthMin-totalDelayAdd; % for multiplication graph
                    elseif(lengthXn<lengthHn)
                        convolutionTime = t(nInput+lengthMax-totalDelayAdd);
                        lengthFinal = lengthMax;
                        k = nInput+lengthMax-totalDelayAdd; % for multiplication graph
                    elseif(lengthXn==lengthHn)
                        convolutionTime = t(nInput+lengthXn-totalDelayAdd);
                        lengthFinal = lengthXn;
                        k = nInput+lengthXn-totalDelayAdd; % for multiplication graph
                    end
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+lengthFinal-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+lengthFinal-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    lengthMin = min(length(xData),length(xData1));
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
            
                    axes(handles.graphMultiply) 
                    stem(j+totalDelayAdd-lengthMin,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2])% time equal to the convolution graph 
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % ----------------------------- 
                
                % -----------------------------
                % last check on 7th January 2016
                % for x[n] = pulse
                %     h[n] = exponential non causal
                % -----------------------------  
                % flip x[n] and h[n] (OK)
                % all functions (OK)
                % combine graph (OK)
                % multiplication graph (pending)
                % convolution graph (OK)
                % ----------------------------- 
                elseif(signalIndex==5)
                    disp('plotting the stem for x[n] pulse, h[n] exponentia noncausall');
                    if(lengthXn>lengthHn)
                        convolutionTime = t(nInput+lengthMin-totalDelayAdd);
                        lengthFinal = lengthMin;
                        k = nInput+lengthMin-totalDelayAdd; % for multiplication graph
                    elseif(lengthXn<lengthHn)
                        convolutionTime = t(nInput+lengthMax-totalDelayAdd);
                        lengthFinal = lengthMax;
                        k = nInput+lengthMax-totalDelayAdd; % for multiplication graph
                    elseif(lengthXn==lengthHn)
                        convolutionTime = t(nInput+lengthXn-totalDelayAdd);
                        lengthFinal = lengthXn;
                        k = nInput+lengthXn-totalDelayAdd; % for multiplication graph
                    end
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+lengthFinal-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+lengthFinal-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    lengthMin = min(length(xData),length(xData1));
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
            
                    axes(handles.graphMultiply) 
                    stem(j+totalDelayAdd-lengthMin,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph 
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                
                    
                    
                    % -----------------------------
                    
                % -----------------------------    
                % last check on 7th January 2016
                % for x[n] = unit sample
                %     h[n] = exponential non causal
                % -----------------------------  
                % flip x[n] and h[n] (OK)
                % all functions (OK)
                % combine graph (OK)
                % multiplication graph (pending)
                % convolution graph (OK)
                % -----------------------------
                elseif(signalIndex==6)
                    disp('plotting the stem for x[n ]unit sample, h[n] exponential noncausal');
                    if(lengthXn>lengthHn)
                        convolutionTime = t(nInput+lengthMin-totalDelayAdd);
                        lengthFinal = lengthMin;
                        k = nInput+lengthMin-totalDelayAdd;
                    elseif(lengthXn<lengthHn)
                        convolutionTime = t(nInput+lengthMax-totalDelayAdd);
                        lengthFinal = lengthMax;
                        k = nInput+lengthMax-totalDelayAdd;
                    elseif(lengthXn==lengthHn)
                        convolutionTime = t(nInput+lengthXn-totalDelayAdd);
                        lengthFinal = lengthXn;
                        k = nInput+lengthXn-totalDelayAdd;
                    end
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+lengthFinal-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+lengthFinal-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    lengthMin = min(length(xData),length(xData1));
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
            
                    axes(handles.graphMultiply) 
                    stem(j+totalDelayAdd-lengthMin,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph 
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                
                % -----------------------------    
                % last check on 7th January 2016
                % for x[n] = user signal
                %     h[n] = exponential non causal
                % -----------------------------  
                % flip x[n] and h[n] (OK)
                % all functions (OK)
                % combine graph (OK)
                % multiplication graph (pending)
                % convolution graph (OK)
                % -----------------------------
                elseif(signalIndex==7)
                    disp('plotting the stem for x[n] user signal, h[n] exponential noncausal');
                    if(lengthXn>lengthHn)
                        convolutionTime = t(nInput+lengthMin-totalDelayAdd);
                        lengthFinal = lengthMin;
                        k = nInput+lengthMin-totalDelayAdd; % for multiplication graph
                    elseif(lengthXn<lengthHn)
                        convolutionTime = t(nInput+lengthMax-totalDelayAdd);
                        lengthFinal = lengthMax;
                        k = nInput+lengthMax-totalDelayAdd; % for multiplication graph
                    elseif(lengthXn==lengthHn)
                        convolutionTime = t(nInput+lengthXn-totalDelayAdd);
                        lengthFinal = lengthXn;
                        k = nInput+lengthXn-totalDelayAdd; % for multiplication graph
                    end
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+lengthFinal-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+lengthFinal-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    u = yData';
                    v = yData1;
                    lengthMin = min(length(xData),length(xData1));
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
            
                    axes(handles.graphMultiply) 
                    stem(j+totalDelayAdd-lengthMin,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph 
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                
                end
                else
                disp('empty');  
                cla(handles.graphMultiply,'reset')
                set(handles.t1,'visible','off');
                set(handles.t2,'visible','off');
                set(handles.t3,'visible','off');
                set(handles.t4,'visible','off');
            end

        end
    case 5  % h[n], Pulse
        xData1 = delayInput1:delayInput1 + lengthInput1 - 1;
        yData1 = aInput1*ones(lengthInput1,1);
        xData1 = xData1';
        xnDataMin = min(xData);
        hnDataMin = min(xData1);
        minData = xnDataMin+hnDataMin;
        xnDataMax = max(xData);
        hnDataMax = max(xData1);
        maxData = xnDataMax+hnDataMax;
        
        xValue = conv(yData1,yData);
        convolutionLength = length(xValue)-1;
        
        if(signalIndex==4)      % if x[n] is an exponential graph
            if(causalRB)        % if x[n] is causal
                t = minData: maxData;
            elseif(nonCausalRB) % elseif x[n] is noncausal
                t = xData(1)+delayInput1:xData1(length(xData1))+delayInput;
            end
        else
            t= totalDelayAdd: convolutionLength+totalDelayAdd;
        end 
        axes(handles.graphConvolve)
        stem(t,xValue,'LineStyle','-',...              
            'MarkerFaceColor','yellow',...              
            'MarkerEdgeColor','black');
        %xlim([t(1)-1 t(length(xValue))+2])
        hold on
        if (flipXn == 1)
            title('Linear Convolution y[n] = \Sigma h[k]x[n-k]');
        elseif(flipHn == 1)
            title('Linear Convolution y[n] = \Sigma x[k]h[n-k]');
        end 
        hold off
        
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        u = yData;
        v = yData1;
        k = nInput+1-totalDelayAdd;

        m = length(u);
        n = length(v);
        w = m+n-1;
        % -----------------------------
        
        % -----------------------------
        % to plot the stem on convolution graph
        % -----------------------------
        convolutionData = xValue;
        xnTimeMin = min(xData);
        xnTimeMax = max(xData);
        lengthXn = length(xData);
        lengthHn = length(xData1);
            
        lengthMax = max(lengthXn,lengthHn);
        lengthMin = min(lengthXn,lengthHn);

        flipXnTimeMin = -(xnTimeMax);
        flipXnTimeMax = -(xnTimeMin);

        hnTimeMin = min(xData1);
        hnTimeMax = max(xData1);

        flipHnTimeMin = -(hnTimeMax);
        flipHnTimeMax = -(hnTimeMin);
        % -----------------------------
        
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        yMax = max(convolutionData);
        yMin = min(convolutionData);
        % -----------------------------
        
        if(flipHnTimeMax+nInput >= xnTimeMin && flipHnTimeMin+nInput <= xnTimeMax || flipXnTimeMax+nInput >= hnTimeMin && flipXnTimeMin+nInput <= hnTimeMax)
            % -----------------------------
            % last check on 7th January 2016
            % for x[n] = exponential
            %     h[n] = pulse
            % ----------------------------- 
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            if(signalIndex==4)
                if(nonCausalRB)  
                    disp('plotting the for x[n] exponential noncausal h[n] pulse');
                    if(lengthXn>lengthHn)
                        %disp('1');
                        convolutionTime = t(nInput+lengthMax-totalDelayAdd);
                        lengthFinal = lengthMax;
                        k = nInput+lengthMax-totalDelayAdd;% for multiplication graph
                    elseif(lengthXn<lengthHn)
                        %disp('2');
                        convolutionTime = t(nInput+lengthMin-totalDelayAdd);
                        lengthFinal = lengthMin;
                        k = nInput+lengthMin-totalDelayAdd;% for multiplication graph
                    elseif(lengthXn==lengthHn)
                        %disp('3');
                        convolutionTime = t(nInput+lengthXn-totalDelayAdd);
                        lengthFinal = lengthXn;
                        k = nInput+lengthXn-totalDelayAdd;% for multiplication graph
                    end
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+lengthFinal-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+lengthFinal-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    lengthMin = min(length(xData),length(xData1));
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
            
                    axes(handles.graphMultiply) 
                    stem(j+totalDelayAdd-lengthMin,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph 
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                    
                elseif(causalRB)  
                    disp('plotting the for x[n] exponential causal h[n] pulse');
                    convolutionTime = t(nInput+1-totalDelayAdd);
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+1-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    k = nInput+1-totalDelayAdd;
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
                    axes(handles.graphMultiply) 
                    stem(j-1+totalDelayAdd,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                end
                
            % -----------------------------    
            % last check on 7th January 2016
            % for x[n] = sine or cosine
            %     h[n] = pulse
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------    
            elseif(signalIndex==2 || signalIndex ==3) 
                disp('plotting the for x[n] either sine/cosine h[n] pulse');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
             
            % -----------------------------    
            % last check on 7th January 2016
            % for x[n] = pulse
            %     h[n] = pulse
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % ----------------------------- 
            elseif(signalIndex==5) 
                disp('plotting the stem for x[n] pulse, h[n] pulse');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin-2 yMax/2+2])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
            
            % -----------------------------
            % last check on 7th January 2016
            % for x[n] = unit sample
            %     h[n] = pulse
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            elseif(signalIndex==6)
                disp('plotting the stem for x[n] unit sample, h[n] pulse');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5)
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                %ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
            % -----------------------------
            % last check on 7th January 2016
            % for x[n] = user signal
            %     h[n] = pulse
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            elseif(signalIndex==7)
                disp('plotting the stem for x[n] user signal, h[n] pulse');  
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5)
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                u = yData';
                v = yData1;
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
            end
        else
            disp('empty');
            cla(handles.graphMultiply,'reset')
            set(handles.t1,'visible','off');
            set(handles.t2,'visible','off');
            set(handles.t3,'visible','off');
            set(handles.t4,'visible','off');
        end
        
    case 6  % h[n], Unit Sample
        xData1 = delayInput1;
        yData1 = aInput1;
        xnDataMin = min(xData);
        hnDataMin = min(xData1);
        minData = xnDataMin+hnDataMin;
        xnDataMax = max(xData);
        hnDataMax = max(xData1);
        maxData = xnDataMax+hnDataMax;
        
        xValue = conv(yData1,yData);
        convolutionLength = length(xValue)-1;
        if(signalIndex==4)      % if x[n] is an exponential graph
            if(causalRB)        % if x[n] is causal
                t = minData: maxData;
            elseif(nonCausalRB) % elseif x[n] is noncausal
                t = xData(1)+delayInput1:xData1(length(xData1))+delayInput;
            end
        else
            t= totalDelayAdd: convolutionLength+totalDelayAdd;
        end 
        
        axes(handles.graphConvolve)
        stem(t,xValue,'LineStyle','-',...              
            'MarkerFaceColor','yellow',...              
            'MarkerEdgeColor','black');
        hold on
        if (flipXn == 1)
            title('Linear Convolution y[n] = \Sigma h[k]x[n-k]');
        elseif(flipHn == 1)
            title('Linear Convolution y[n] = \Sigma x[k]h[n-k]');
        end 
        hold off
        
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        u = yData;
        v = yData1;
        k = nInput+1-totalDelayAdd;

        m = length(u);
        n = length(v);
        w = m+n-1;
        % -----------------------------
        
        % -----------------------------
        % to plot the stem on convolution graph
        % -----------------------------
        convolutionData = xValue;
        xnTimeMin = min(xData);
        xnTimeMax = max(xData);
        lengthXn = length(xData);
        lengthHn = length(xData1);
            
        lengthMax = max(lengthXn,lengthHn);
        lengthMin = min(lengthXn,lengthHn);
        
        flipXnTimeMin = -(xnTimeMax);
        flipXnTimeMax = -(xnTimeMin);

        hnTimeMin = min(xData1);
        hnTimeMax = max(xData1);

        flipHnTimeMin = -(hnTimeMax);
        flipHnTimeMax = -(hnTimeMin);
        % -----------------------------
        
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        yMax = max(convolutionData);
        yMin = min(convolutionData);
        % -----------------------------
        
        if(flipHnTimeMax+nInput >= xnTimeMin && flipHnTimeMin+nInput <= xnTimeMax || flipXnTimeMax+nInput >= hnTimeMin && flipXnTimeMin+nInput <= hnTimeMax)
            % -----------------------------
            % last check on 7th January 2016
            % for x[n] = exponential
            %     h[n] = unit sample
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            if(signalIndex==4)
                if(nonCausalRB) 
                    disp('plotting the for x[n] exponential noncausal h[n] unit sample');
                    if(lengthXn>lengthHn)
                        %disp('1');
                        convolutionTime = t(nInput+lengthMax-totalDelayAdd);
                        lengthFinal = lengthMax;
                        k = nInput+lengthMax-totalDelayAdd;
                    elseif(lengthXn<lengthHn)
                        %disp('2');
                        convolutionTime = t(nInput+lengthMin-totalDelayAdd);
                        lengthFinal = lengthMin;
                        k = nInput+lengthMin-totalDelayAdd;
                    elseif(lengthXn==lengthHn)
                        %disp('3');
                        convolutionTime = t(nInput+lengthXn-totalDelayAdd);
                        lengthFinal = lengthXn;
                        k = nInput+lengthXn-totalDelayAdd;
                    end
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+lengthFinal-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+lengthFinal-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    lengthMin = min(length(xData),length(xData1));
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
            
                    axes(handles.graphMultiply) 
                    stem(j+totalDelayAdd-lengthMin,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph 
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                    
                elseif(causalRB)
                    disp('plotting the for x[n] exponential causal h[n] unit sample');
                    convolutionTime = t(nInput+1-totalDelayAdd);
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+1-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    k = nInput+1-totalDelayAdd;
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
                    axes(handles.graphMultiply) 
                    stem(j-1+totalDelayAdd,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                end
            
            % -----------------------------    
            % last check on 7th January 2016
            % for x[n] = sine or cosine
            %     h[n] = unit sample
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK) 
            % -----------------------------
            elseif(signalIndex==2 || signalIndex ==3) 
                disp('plotting the for x[n] either sine/cosine h[n] unit sample');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
             
            % -----------------------------    
            % last check on 7th January 2016
            % for x[n] = pulse
            %     h[n] = unit sample
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK) 
            % -----------------------------
            elseif(signalIndex==5) 
                disp('plotting the stem for x[n] pulse, h[n] unit sample');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                %ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
                
            % -----------------------------
            % last check on 7th January 2016
            % for x[n] = unit sample
            %     h[n] = unit sample
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            elseif(signalIndex==6)
                disp('plotting the stem for x[n] unit sample, h[n] unit sample');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5)
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin-2 yMax+2])
                xlim([-2+totalDelayAdd 2+totalDelayAdd]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
                
                
            % -----------------------------    
            % last check on 7th January 2016
            % for x[n] = user signal
            %     h[n] = unit sample
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % -----------------------------
            elseif(signalIndex==7)
                disp('plotting the stem for x[n] user signal, h[n] unit sample');  
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5)
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                %ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
            end
        else
            disp('empty');
            cla(handles.graphMultiply,'reset')
            set(handles.t1,'visible','off');
            set(handles.t2,'visible','off');
            set(handles.t3,'visible','off');
            set(handles.t4,'visible','off');
        end
        
    case 7  % h[n], User Signal
        xData1 = 0:1:length(signalInput1)-1;
        yData1 = signalInput1;
        xnDataMin = min(xData);
        hnDataMin = min(xData1);
        minData = xnDataMin+hnDataMin;
        xnDataMax = max(xData);
        hnDataMax = max(xData1);
        maxData = xnDataMax+hnDataMax;
        
        xValue = conv(yData1,yData);
        convolutionLength = length(xValue)-1;
        if(signalIndex==4)      % if x[n] is an exponential graph
            if(causalRB)        % if x[n] is causal
                t = minData: maxData;
            elseif(nonCausalRB) % elseif x[n] is noncausal
                t = xData(1)+delayInput1:xData1(length(xData1))+delayInput;
            end
        else
            t= totalDelayAdd: convolutionLength+totalDelayAdd;
        end 
        
        axes(handles.graphConvolve)
        stem(t,xValue,'LineStyle','-',...              
            'MarkerFaceColor','yellow',...              
            'MarkerEdgeColor','black');
        hold on
        if (flipXn == 1)
            title('Linear Convolution y[n] = \Sigma h[k]x[n-k]');
        elseif(flipHn == 1)
            title('Linear Convolution y[n] = \Sigma x[k]h[n-k]');
        end   
        hold off
        
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        u = yData;
        v = yData1;
        k = nInput+1-totalDelayAdd;

        m = length(u);
        n = length(v);
        w = m+n-1;
        % -----------------------------
        
        % -----------------------------
        % to plot the stem on convolution graph
        % -----------------------------
        convolutionData = xValue;
        xnTimeMin = min(xData);
        xnTimeMax = max(xData);
        lengthXn = length(xData);
        lengthHn = length(xData1);
            
        lengthMax = max(lengthXn,lengthHn);
        
        flipXnTimeMin = -(xnTimeMax);
        flipXnTimeMax = -(xnTimeMin);

        hnTimeMin = min(xData1);
        hnTimeMax = max(xData1);

        flipHnTimeMin = -(hnTimeMax);
        flipHnTimeMax = -(hnTimeMin);
        % -----------------------------
        
        % -----------------------------
        % for multiplication graph
        % -----------------------------
        yMax = max(convolutionData);
        yMin = min(convolutionData);
        % -----------------------------
        
        if(flipHnTimeMax+nInput >= xnTimeMin && flipHnTimeMin+nInput <= xnTimeMax || flipXnTimeMax+nInput >= hnTimeMin && flipXnTimeMin+nInput <= hnTimeMax)
            % -----------------------------
            % last check on 7th January 2016
            % for x[n] = exponential
            %     h[n] = user signal
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)
            % ----------------------------- 
            if(signalIndex==4)
                if(nonCausalRB) 
                    disp('plotting the for x[n] exponential noncausal h[n] user signal');
                    convolutionTime = t(nInput+lengthMax-totalDelayAdd);
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+lengthMax-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+lengthMax-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    u = yData';
                    v = yData1;
                    lengthMin = min(length(xData),length(xData1));
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
            
                    axes(handles.graphMultiply) 
                    stem(j+totalDelayAdd-lengthMin,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph 
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                elseif(causalRB)  
                    disp('plotting the for x[n] exponential causal h[n] user signal');
                    convolutionTime = t(nInput+1-totalDelayAdd);
                    axes(handles.graphConvolve)
                    hold on
                    stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                    hold off
                    xx =(convolutionTime);
                    yy =(convolutionData(nInput+1-totalDelayAdd));
                    set(handles.t1,'visible','on');
                    set(handles.t2,'visible','on');
                    set(handles.t3,'visible','on');
                    set(handles.t4,'visible','on');
                    set(handles.t1,'String','y[');
                    set(handles.t2,'String',xx);
                    set(handles.t3,'String','] = ');
                    set(handles.t4,'String',yy);
                    
                    % -----------------------------
                    % for multiplication graph
                    % -----------------------------
                    k = nInput+1-totalDelayAdd;
                    j = max(1,k+1-n):1:min(k,m);
                    a1=u(j);
                    a2=v(k-j+1);
                    a3= a1.*a2;
                    axes(handles.graphMultiply) 
                    stem(j-1+totalDelayAdd,a3,'b');
                    ylim([yMin yMax])
                    xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                    if(flipHn == 1)
                        title('Multiplication x[k]h[n-k]')
                    elseif(flipXn == 1)
                        title('Multiplication h[k]x[n-k]')
                    end
                    % -----------------------------
                end
                
            % -----------------------------    
            % last check on 7th January 2016
            % for x[n] = sine or cosine
            %     h[n] = user signal
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)   
            % ----------------------------- 
            elseif(signalIndex==2 || signalIndex ==3)
                disp('plotting the for x[n] either sine/cosine h[n] user signal');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                u = yData';
                v = yData1;
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
            
            % -----------------------------    
            % last check on 7th January 2016
            % for x[n] = pulse
            %     h[n] = user signal
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)  
            % ----------------------------- 
            elseif(signalIndex==5) 
                disp('plotting the stem for x[n] pulse, h[n] user signal');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5);
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                u = yData';
                v = yData1;
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
                
            % -----------------------------    
            % last check on 7th January 2016
            % for x[n] = unit sample
            %     h[n] = user signal
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK) 
            % ----------------------------- 
            elseif(signalIndex==6)
                disp('plotting the stem for x[n] unit sample, h[n] user signal');
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5)
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                %ylim([yMin yMax])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
                
            % -----------------------------    
            % last check on 7th January 2016
            % for x[n] = user signal
            %     h[n] = user signal
            % -----------------------------  
            % flip x[n] and h[n] (OK)
            % all functions (OK)
            % combine graph (OK)
            % multiplication graph (pending)
            % convolution graph (OK)  
            % ----------------------------- 
            elseif(signalIndex==7)
                disp('plotting the stem for x[n] user signal, h[n] user signal');  
                axes(handles.graphConvolve)
                hold on
                convolutionTime = t(nInput+1-totalDelayAdd);
                stem(convolutionTime,convolutionData(nInput+1-totalDelayAdd),'r','LineWidth',1.5)
                hold off
                xx =(convolutionTime);
                yy =(convolutionData(nInput+1-totalDelayAdd));
                set(handles.t1,'visible','on');
                set(handles.t2,'visible','on');
                set(handles.t3,'visible','on');
                set(handles.t4,'visible','on');
                set(handles.t1,'String','y[');
                set(handles.t2,'String',xx);
                set(handles.t3,'String','] = ');
                set(handles.t4,'String',yy);
                
                % -----------------------------
                % for multiplication graph
                % -----------------------------
                k = nInput+1-totalDelayAdd;
                j = max(1,k+1-n):1:min(k,m);
                a1=u(j);
                a2=v(k-j+1);
                a3= a1.*a2;
                axes(handles.graphMultiply) 
                stem(j-1+totalDelayAdd,a3,'b');
                ylim([yMin-2 yMax+2])
                xlim([t(1)-1 t(length(convolutionData))+2]) % time equal to the convolution graph
                if(flipHn == 1)
                    title('Multiplication x[k]h[n-k]')
                elseif(flipXn == 1)
                    title('Multiplication h[k]x[n-k]')
                end
                % -----------------------------
            end
        else
            disp('empty');
            cla(handles.graphMultiply,'reset')
            set(handles.t1,'visible','off');
            set(handles.t2,'visible','off');
            set(handles.t3,'visible','off');
            set(handles.t4,'visible','off');
        end
        
end
% end of signalIndex1 switch case
% -----------------------------



% --- Executes during object creation, after setting all properties.
function graph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate graph



function scalingFactorText_Callback(hObject, eventdata, handles)
% hObject    handle to scalingFactorText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)
    plot_signal(handles);  
    plot_signalCombine(handles);
    plot_signalConvolve(handles); 
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of scalingFactorText as text
%        str2double(get(hObject,'String')) returns contents of scalingFactorText as a double


% --- Executes during object creation, after setting all properties.
function scalingFactorText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scalingFactorText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function expoConstantText_Callback(hObject, eventdata, handles)
% hObject    handle to expoConstantText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)
    plot_signal(handles);  
    plot_signalCombine(handles);
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of expoConstantText as text
%        str2double(get(hObject,'String')) returns contents of expoConstantText as a double


% --- Executes during object creation, after setting all properties.
function expoConstantText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expoConstantText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function userSignalText_Callback(hObject, eventdata, handles)
% hObject    handle to userSignalText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = eval(get(hObject,'String'));

if(isempty(input))
    eval(set(hObject,'Value','[1 1 1 1]'))
end

if(input~=0)
    plot_signal(handles);  
    plot_signalCombine(handles);
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of userSignalText as text
%        str2double(get(hObject,'String')) returns contents of userSignalText as a double


% --- Executes during object creation, after setting all properties.
function userSignalText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userSignalText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in causalRadioButton.
function causalRadioButton_Callback(hObject, eventdata, handles)
% hObject    handle to causalRadioButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = (get(hObject,'Value'));

if(isempty(input))
    set(hObject,'Value','0')
end

if(input == 1)
    plot_signal(handles); 
    plot_signalCombine(handles);  
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of causalRadioButton


% --- Executes on button press in nonCausalRadioButton.
function nonCausalRadioButton_Callback(hObject, eventdata, handles)
% hObject    handle to nonCausalRadioButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = (get(hObject,'Value'));

if(isempty(input))
    set(hObject,'Value','0')
end

if(input == 1)
    plot_signal(handles); 
    plot_signalCombine(handles);
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of nonCausalRadioButton


% --- Executes during object creation, after setting all properties.
function exponentialConstant_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exponentialConstant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function inputParametersDescription_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputParametersDescription (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in signalPopUpMenu1.
% for h[n]
function signalPopUpMenu1_Callback(hObject, eventdata, handles)
% hObject    handle to signalPopUpMenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

signalType = get(hObject,'Value');
switch signalType
    case 1
        reset_values1(handles);
    case 2 % Sine 
        reset_values1(handles);
        plot_signal1(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText1,'enable','on');
        set(handles.periodText1,'enable','on');
        set(handles.lengthText1,'enable','on');
        set(handles.delayText1,'enable','on');
        set(handles.phaseText1,'enable','on'); 
        set(handles.scalingFactorText1,'enable','off');
        set(handles.expoConstantText1,'enable','off');
        set(handles.userSignalText1,'enable','off');
        set(handles.nonCausalRadioButton1,'enable','off');
        set(handles.causalRadioButton1,'enable','off');
          
    case 3 % Cosine
        reset_values1(handles);
        plot_signal1(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText1,'enable','on');
        set(handles.periodText1,'enable','on');
        set(handles.lengthText1,'enable','on');
        set(handles.delayText1,'enable','on');
        set(handles.phaseText1,'enable','on');
        set(handles.scalingFactorText1,'enable','off');
        set(handles.expoConstantText1,'enable','off');
        set(handles.userSignalText1,'enable','off');
        set(handles.nonCausalRadioButton1,'enable','off');
        set(handles.causalRadioButton1,'enable','off');
        
        
    case 4 % Exponential
        reset_values1(handles);
        plot_signal1(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText1,'enable','off');
        set(handles.periodText1,'enable','off');
        set(handles.lengthText1,'enable','on');
        set(handles.delayText1,'enable','on');
        set(handles.phaseText1,'enable','off');
        set(handles.scalingFactorText1,'enable','on');
        set(handles.expoConstantText1,'enable','on');
        set(handles.userSignalText1,'enable','off');
        set(handles.nonCausalRadioButton1,'enable','on');
        set(handles.nonCausalRadioButton1,'Value',1);
        set(handles.causalRadioButton1,'enable','on');
        
    case 5 % Pulse
        reset_values1(handles);
        plot_signal1(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText1,'enable','on');
        set(handles.lengthText1,'enable','on');
        set(handles.delayText1,'enable','on');
        set(handles.periodText1,'enable','off');
        set(handles.phaseText1,'enable','off');  
        set(handles.scalingFactorText1,'enable','off');
        set(handles.expoConstantText1,'enable','off');
        set(handles.userSignalText1,'enable','off');
        set(handles.nonCausalRadioButton1,'enable','off');
        set(handles.causalRadioButton1,'enable','off');
        
        
    case 6 % Unit Sample
        reset_values1(handles);
        plot_signal1(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText1,'enable','on');
        set(handles.delayText1,'enable','on');
        set(handles.lengthText1,'enable','off');
        set(handles.periodText1,'enable','off');
        set(handles.phaseText1,'enable','off');  
        set(handles.scalingFactorText1,'enable','off');
        set(handles.expoConstantText1,'enable','off');
        set(handles.userSignalText1,'enable','off');
        set(handles.nonCausalRadioButton1,'enable','off');
        set(handles.causalRadioButton1,'enable','off');
       
        
    case 7 % User Signal
        reset_values1(handles);
        plot_signal1(handles);
        plot_signalCombine(handles);
        plot_signalConvolve(handles);
        set(handles.amplitudeText1,'enable','off');
        set(handles.periodText1,'enable','off');
        set(handles.lengthText1,'enable','off');
        set(handles.delayText1,'enable','off');
        set(handles.phaseText1,'enable','off');  
        set(handles.scalingFactorText1,'enable','off');
        set(handles.expoConstantText1,'enable','off');
        set(handles.userSignalText1,'enable','on');
        set(handles.nonCausalRadioButton1,'enable','off');
        set(handles.causalRadioButton1,'enable','off');       
end


% Hints: contents = cellstr(get(hObject,'String')) returns signalPopUpMenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from signalPopUpMenu1


% --- Executes during object creation, after setting all properties.
function signalPopUpMenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signalPopUpMenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amplitudeText1_Callback(hObject, eventdata, handles)
% hObject    handle to amplitudeText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)
    plot_signal1(handles); 
    plot_signalCombine(handles); 
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of amplitudeText1 as text
%        str2double(get(hObject,'String')) returns contents of amplitudeText1 as a double


% --- Executes during object creation, after setting all properties.
function amplitudeText1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitudeText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function periodText1_Callback(hObject, eventdata, handles)
% hObject    handle to periodText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)
    plot_signal1(handles);  
    plot_signalCombine(handles); 
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of periodText1 as text
%        str2double(get(hObject,'String')) returns contents of periodText1 as a double


% --- Executes during object creation, after setting all properties.
function periodText1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to periodText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function phaseText1_Callback(hObject, eventdata, handles)
% hObject    handle to phaseText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
else
    plot_signal1(handles); 
    plot_signalCombine(handles); 
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of phaseText1 as text
%        str2double(get(hObject,'String')) returns contents of phaseText1 as a double


% --- Executes during object creation, after setting all properties.
function phaseText1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phaseText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lengthText1_Callback(hObject, eventdata, handles)
% hObject    handle to lengthText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)
    plot_signal1(handles);  
    plot_signalCombine(handles);
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of lengthText1 as text
%        str2double(get(hObject,'String')) returns contents of lengthText1 as a double


% --- Executes during object creation, after setting all properties.
function lengthText1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lengthText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function delayText1_Callback(hObject, eventdata, handles)
% hObject    handle to delayText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
else
    plot_signal1(handles); 
    plot_signalCombine(handles);
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of delayText1 as text
%        str2double(get(hObject,'String')) returns contents of delayText1 as a double


% --- Executes during object creation, after setting all properties.
function delayText1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delayText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scalingFactorText1_Callback(hObject, eventdata, handles)
% hObject    handle to scalingFactorText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2num(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0)
    plot_signal1(handles); 
    plot_signalCombine(handles); 
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of scalingFactorText1 as text
%        str2double(get(hObject,'String')) returns contents of scalingFactorText1 as a double


% --- Executes during object creation, after setting all properties.
function scalingFactorText1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scalingFactorText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function expoConstantText1_Callback(hObject, eventdata, handles)
% hObject    handle to expoConstantText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2num(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0')
end

if(input>0) 
    plot_signal1(handles); 
    plot_signalCombine(handles);  
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of expoConstantText1 as text
%        str2double(get(hObject,'String')) returns contents of expoConstantText1 as a double


% --- Executes during object creation, after setting all properties.
function expoConstantText1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expoConstantText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function userSignalText1_Callback(hObject, eventdata, handles)
% hObject    handle to userSignalText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = eval(get(hObject,'String'));

if(isempty(input))
    eval(set(hObject,'Value','[1 1 1 1]'))
end

if(input~=0)
    plot_signal1(handles); 
    plot_signalCombine(handles); 
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of userSignalText1 as text
%        str2double(get(hObject,'String')) returns contents of userSignalText1 as a double


% --- Executes during object creation, after setting all properties.
function userSignalText1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to userSignalText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in causalRadioButton1.
function causalRadioButton1_Callback(hObject, eventdata, handles)
% hObject    handle to causalRadioButton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = (get(hObject,'Value'));

if(isempty(input))
    set(hObject,'Value','0')
else
    plot_signal1(handles); 
    plot_signalCombine(handles);  
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of causalRadioButton1


% --- Executes on button press in nonCausalRadioButton1.
function nonCausalRadioButton1_Callback(hObject, eventdata, handles)
% hObject    handle to nonCausalRadioButton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = (get(hObject,'Value'));

if(isempty(input))
    set(hObject,'Value','0')
end

if(input == 1)
    plot_signal1(handles);
    plot_signalCombine(handles);   
    plot_signalConvolve(handles);
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of nonCausalRadioButton1


% --- Executes during object creation, after setting all properties.
function graph1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graph1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate graph1


% --- Executes during object creation, after setting all properties.
function graphConvolve_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graphConvolve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate graphConvolve


% --- Executes on button press in fliphn.
function fliphn_Callback(hObject, eventdata, handles)
% hObject    handle to fliphn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fliphnStatus = get(hObject,'Value');

if(fliphnStatus) 
    set(handles.nSlider,'Value',-5);
    set(handles.nText,'String','-5');
    plot_signalCombine(handles); 
    plot_signalConvolve(handles);
    axes(handles.graph2)
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of fliphn


% --- Executes on button press in flipxn.
function flipxn_Callback(hObject, eventdata, handles)
% hObject    handle to flipxn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flipxnStatus = (get(hObject,'Value'));

if(flipxnStatus) 
    set(handles.nSlider,'Value',-5);
    set(handles.nText,'String','-5');
    plot_signalCombine(handles);  
    plot_signalConvolve(handles);
    axes(handles.graph2)
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of flipxn


% --- Executes during object creation, after setting all properties.
function graph2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graph2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate graph2


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function nText_Callback(hObject, eventdata, handles)
% hObject    handle to nText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue = str2num(get(hObject,'String'));

sliderValueMax = get(hObject,'Max');
sliderValueMin = get(hObject,'Min');

if(isempty(sliderValue) ||  sliderValue > 100 || sliderValue < -100)
    set(handles.nSlider,'Value',-5);
    set(handles.nText,'String','-5');
else
    set(handles.nSlider,'Value',sliderValue);
    plot_signalCombine(handles);
    plot_signalConvolve(handles);
end
guidata(hObject,handles)

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


% --- Executes on button press in clearPlotsButton.
function clearPlotsButton_Callback(hObject, eventdata, handles)
% hObject    handle to clearPlotsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

reset_all(handles);
enableEditText_all(handles);
set(handles.signalPopUpMenu,'Value', 1)
set(handles.signalPopUpMenu1,'Value', 1)
guidata(hObject,handles);


% --- Executes on slider movement.
function nSlider_Callback(hObject, eventdata, handles)
% hObject    handle to nSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue = get(handles.nSlider,'Value');

sliderValueMax = get(hObject,'Max');
sliderValueMin = get(hObject,'Min');


if(isempty(sliderValue) || sliderValue > 100 || sliderValue < -100)
    set(handles.nSlider,'Value',-5);
    set(handles.nText,'String','-5'); 
else
    set(handles.nText,'String',num2str(sliderValue));
    plot_signalCombine(handles); 
    plot_signalConvolve(handles);
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


function startText_Callback(hObject, eventdata, handles)
% hObject    handle to startText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
text = get(hObject,'Value');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of startText as text
%        str2double(get(hObject,'String')) returns contents of startText as a double



function convolveNText_Callback(hObject, eventdata, handles)
% hObject    handle to convolveNText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of convolveNText as text
%        str2double(get(hObject,'String')) returns contents of convolveNText as a double


% --- Executes during object creation, after setting all properties.
function convolveNText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to convolveNText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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
