% Final Year Project CE
% Author:           Nonny Florentine (U1320766B)
% Sub-GUI
% Transfer Function
% Created:          

function varargout = transferFunction(varargin)
% TRANSFERFUNCTION MATLAB code for transferFunction.fig
%      TRANSFERFUNCTION, by itself, creates a new TRANSFERFUNCTION or raises the existing
%      singleton*.
%
%      H = TRANSFERFUNCTION returns the handle to a new TRANSFERFUNCTION or the handle to
%      the existing singleton*.
%
%      TRANSFERFUNCTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSFERFUNCTION.M with the given input arguments.
%
%      TRANSFERFUNCTION('Property','Value',...) creates a new TRANSFERFUNCTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before transferFunction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to transferFunction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help transferFunction

% Last Modified by GUIDE v2.5 08-Mar-2016 03:16:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @transferFunction_OpeningFcn, ...
                   'gui_OutputFcn',  @transferFunction_OutputFcn, ...
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


% --- Executes just before transferFunction is made visible.
function transferFunction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to transferFunction (see VARARGIN)

% Choose default command line output for transferFunction
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
% Update handles structure
guidata(hObject, handles);

Initializing_fegure(hObject, eventdata, handles)
% UIWAIT makes transferFunction wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = transferFunction_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc

global sys t Hold_number


Acquiring_data(handles);

if get(handles.checkbox2,'Value') == 1
    sys = feedback(sys,1);
end

y_impulse = impulse(sys,t);
y_step    = step(sys,t);

% if Hold_number == 1
%     y = 
% end
    axes(handles.axes1);
        plot(t,y_impulse);
        title(handles.axes1,'Impulse Response');
        xlabel(handles.axes1,'T, time(sec)');
        ylabel(handles.axes1,'y(t)');
        legend(handles.axes1)
    axes(handles.axes2);    
        plot(t,y_step);
        title(handles.axes2,'Unit Step Response');
        xlabel(handles.axes2,'T, time(sec)');
        ylabel(handles.axes2,'y(t)');
        legend(handles.axes2)
axes(handles.axes3);
    rlocus(sys);
axes(handles.axes4);
    bode(sys)
axes(handles.axes5);
    nyquist(sys)

TF = evalc('sys');
set(handles.text6,'string',TF)

% pidtool(sys);
% sisotool(sys)



function Acquiring_data(handles)
global sys t RB1 RB2

if RB1 == 1    
    zeros = str2num(get(handles.edit3,'string'));
    poles = str2num(get(handles.edit4,'string'));
    gain  = str2num(get(handles.edit5,'string'));    
    sys = zpk(zeros,poles,gain);
else if RB2 == 1
     num   = str2num(get(handles.edit3,'string'));
     den   = str2num(get(handles.edit4,'string'));
     K     = str2num(get(handles.edit5,'string'));
     sys   = tf(K*num,den); 
    else
    end
end
h     = 1000;
t0    = str2num(get(handles.edit1,'string'));
te    = str2num(get(handles.edit2,'string'));
% t     = t0:0.05:te;
t =linspace(t0, te, h);




function Calculate_final_value()
global sys


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

Initializing_fegure(hObject, eventdata, handles)

function Initializing_fegure(hObject, eventdata, handles)
global RB1 RB2
set(handles.edit1,'string','0');
set(handles.edit2,'string','4');
set(handles.edit3,'string','[]');
set(handles.edit4,'string','[-1, -2]');
set(handles.edit5,'string','[1]');

set(handles.checkbox1,'value',0);
set(handles.checkbox2,'Value',0);
set(handles.text6,'string','Transfer Function');

set(handles.radiobutton1,'value',1);
set(handles.radiobutton2,'value',0);
RB1 = 1;
RB2 = 0;

cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');
cla(handles.axes4,'reset');
cla(handles.axes5,'reset');

% radiobutton1_Callback(hObject, eventdata, handles)






function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
global Hold_number

Hold_number = get(hObject,'Value');
if Hold_number == 1
    hold(handles.axes1,'on');
    hold(handles.axes2,'on');
    hold(handles.axes3,'on');
    hold(handles.axes4,'on');
    hold(handles.axes5,'on');    

else
    hold(handles.axes1,'off');
    hold(handles.axes2,'off');
    hold(handles.axes3,'off');
    hold(handles.axes4,'off');
    hold(handles.axes5,'off');
   
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global RB1 RB2
RB1 = get(hObject,'Value'); 
set(handles.radiobutton2,'value',0);
RB2 = 0;

set(handles.text3,'string','Zeros : ');
set(handles.text4,'string','Poles : ');
set(handles.text5,'string','Gain : ');

set(handles.edit1,'string','0');
set(handles.edit2,'string','4');
set(handles.edit3,'string','[]');
set(handles.edit4,'string','[-1, -2]');
set(handles.edit5,'string','[1]');


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global RB1 RB2

RB2 = get(hObject,'Value');
set(handles.radiobutton1,'value',0);
RB1 = 0;

set(handles.text3,'string','Numerator : ');
set(handles.text4,'string','Denominator : ');
set(handles.text5,'string','K : ');

set(handles.edit1,'string','0');
set(handles.edit2,'string','4');
set(handles.edit3,'string','[1]');
set(handles.edit4,'string','[1, 3, 2]');
set(handles.edit5,'string','[1]');


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sys t

y_impulse = impulse(sys,t);
figure,
plot(t,y_impulse);
        title(handles.axes1,'Impulse Response');
        xlabel(handles.axes1,'T, time(sec)');
        ylabel(handles.axes1,'y(t)');
        legend(handles.axes1)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sys t

y_step    = step(sys,t);
figure,
plot(t,y_step);
        title(handles.axes2,'Unit Step Response');
        xlabel(handles.axes2,'T, time(sec)');
        ylabel(handles.axes2,'y(t)');
        legend(handles.axes2)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sys

figure, rlocus(sys);
    
    
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sys

figure, bode(sys)

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sys

figure, nyquist(sys)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sys

pidtool(sys)
