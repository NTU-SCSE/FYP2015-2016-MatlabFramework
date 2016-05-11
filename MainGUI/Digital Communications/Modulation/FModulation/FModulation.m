function varargout = FModulation(varargin)
% FMODULATION MATLAB code for FModulation.fig
%      FMODULATION, by itself, creates a new FMODULATION or raises the existing
%      singleton*.
%
%      H = FMODULATION returns the handle to a new FMODULATION or the handle to
%      the existing singleton*.
%
%      FMODULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FMODULATION.M with the given input arguments.
%
%      FMODULATION('Property','Value',...) creates a new FMODULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FModulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FModulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FModulation

% Last Modified by GUIDE v2.5 08-Mar-2016 00:53:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FModulation_OpeningFcn, ...
                   'gui_OutputFcn',  @FModulation_OutputFcn, ...
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


% --- Executes just before FModulation is made visible.
function FModulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FModulation (see VARARGIN)

% Choose default command line output for FModulation
handles.output = hObject;

% Update handles structure
plotMessageSignal(handles);
guidata(hObject, handles);

% UIWAIT makes FModulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FModulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function carrierFreq_Callback(hObject, eventdata, handles)
% hObject    handle to carrierFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','200')
else
    plotMessageSignal(handles);
end
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of carrierFreq as text
%        str2double(get(hObject,'String')) returns contents of carrierFreq as a double


% --- Executes during object creation, after setting all properties.
function carrierFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to carrierFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function samplingDuration_Callback(hObject, eventdata, handles)
% hObject    handle to samplingDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0.0005')
else
    plotMessageSignal(handles);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of samplingDuration as text
%        str2double(get(hObject,'String')) returns contents of samplingDuration as a double


% --- Executes during object creation, after setting all properties.
function samplingDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplingDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function signalDuration_Callback(hObject, eventdata, handles)
% hObject    handle to signalDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0.15')
else
    plotMessageSignal(handles);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of signalDuration as text
%        str2double(get(hObject,'String')) returns contents of signalDuration as a double


% --- Executes during object creation, after setting all properties.
function signalDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signalDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function modulationIndex_Callback(hObject, eventdata, handles)
% hObject    handle to modulationIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','50')
else
    plotMessageSignal(handles);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of modulationIndex as text
%        str2double(get(hObject,'String')) returns contents of modulationIndex as a double


% --- Executes during object creation, after setting all properties.
function modulationIndex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modulationIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freqResolution_Callback(hObject, eventdata, handles)
% hObject    handle to freqResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0.25')
else
    plotMessageSignal(handles);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of freqResolution as text
%        str2double(get(hObject,'String')) returns contents of freqResolution as a double


% --- Executes during object creation, after setting all properties.
function freqResolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plotMessageSignal(handles)
% The message signal is +1 for 0 < t < t0/3, -2 for t0/3 < t < 2t0/3 and zero otherwise.

cf = get(handles.carrierFreq,'String');
mi = get(handles.modulationIndex,'String');
fr = get(handles.freqResolution,'String');


t0 = 0.15;
ts = 0.0005;
fc = str2double(cf);
kf = str2double(mi);
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df = str2double(fr);

% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
int_m(1)=0;
for i=1:length(t)-1                  	% Integral of m
  int_m(i+1)=int_m(i)+m(i)*ts;
  echo off ;
end
echo on ;
[M,m,df1]=Fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
f=[0:df1:df1*(length(m)-1)]-fs/2;    	% frequency vector
u=cos(2*pi*fc*t+2*pi*kf*int_m);      	% modulated signal
[U,u,df1]=Fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;   

axes(handles.messageSignal);
plot(t,m(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The message signal')

axes(handles.modulatedSignal);
plot(t,u(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The modulated signal')

axes(handles.msMessageSignal);
plot(f,abs(fftshift(M))) 
xlabel('Frequency')
title('Magnitude-spectrum of the message signal')

axes(handles.msModulatedSignal);
plot(f,abs(fftshift(U))) 
title('Magnitude-spectrum of the modulated signal')
xlabel('Frequency')


function [M,m,df]=Fftseq(m,ts,df) 
%		[M,m,df]=fftseq(m,ts,df)
%		[M,m,df]=fftseq(m,ts)
%FFTSEQ		Generates M, the FFT of the sequence m.
%		The sequence is zero padded to meet the required frequency resolution df.
%		ts is the sampling interval. The output df is the final frequency resolution.
%		Output m is the zero padded version of input m. M is the FFT.
fs=1/ts;
if nargin == 2
  n1=0;
else
  n1=fs/df;
end
n2=length(m);
n=2^(max(nextpow2(n1),nextpow2(n2)));
M=fft(m,n);
m=[m,zeros(1,n-n2)];
df=fs/n;
