function varargout = AModulation(varargin)
% AMODULATION MATLAB code for AModulation.fig
%      AMODULATION, by itself, creates a new AMODULATION or raises the existing
%      singleton*.
%
%      H = AMODULATION returns the handle to a new AMODULATION or the handle to
%      the existing singleton*.
%
%      AMODULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AMODULATION.M with the given input arguments.
%
%      AMODULATION('Property','Value',...) creates a new AMODULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AModulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AModulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AModulation

% Last Modified by GUIDE v2.5 08-Mar-2016 01:56:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AModulation_OpeningFcn, ...
                   'gui_OutputFcn',  @AModulation_OutputFcn, ...
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


% --- Executes just before AModulation is made visible.
function AModulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AModulation (see VARARGIN)

% Choose default command line output for AModulation
handles.output = hObject;

% Update handles structure
plotGraph(handles);
guidata(hObject, handles);

% UIWAIT makes AModulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AModulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function frequencyResolution_Callback(hObject, eventdata, handles)
% hObject    handle to frequencyResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','0.2')
else
    plotGraph(handles);
end
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of frequencyResolution as text
%        str2double(get(hObject,'String')) returns contents of frequencyResolution as a double


% --- Executes during object creation, after setting all properties.
function frequencyResolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequencyResolution (see GCBO)
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
    set(hObject,'String','0.85')
else
    plotGraph(handles);
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



function carrierFreq_Callback(hObject, eventdata, handles)
% hObject    handle to carrierFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2double(get(hObject,'String'));

if(isempty(input))
    set(hObject,'String','250')
else
    plotGraph(handles);
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



function plotGraph(handles)

% The message signal is +1 for 0 < t < t0/3, -2 for t0/3 < t < 2t0/3 and zero otherwise.

cf = get(handles.carrierFreq,'String');
mi = get(handles.modulationIndex,'String');
fr = get(handles.frequencyResolution,'String');


t0 = 0.15;
ts = 0.001;
fc = str2double(cf);
a = str2double(mi);
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df = str2double(fr);
snr=10;
snr_lin=10^(snr/10);                 	% SNR


% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                   	% carrier signal
m_n=m/max(abs(m));                   	% normalized message signal
[M,m,df1]=Fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
f=[0:df1:df1*(length(m)-1)]-fs/2;    	% frequency vector
u=(1+a*m_n).*c;                      	% modulated signal
[U,u,df1]=Fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;                              	% scaling
signal_power=Spower(u(1:length(t)));  	% power in modulated signal
% power in normalized message
pmn=Spower(m(1:length(t)))/(max(abs(m)))^2;
eta=(a^2*pmn)/(1+a^2*pmn);           	% modulation efficiency
noise_power=eta*signal_power/snr_lin;	% noise power
noise_std=sqrt(noise_power);         	% noise standard deviation
noise=noise_std*randn(1,length(u));  	% generate noise
r=u+noise;                           	% add noise to the modulated signal
[R,r,df1]=Fftseq(r,ts,df);           	% Fourier transform 
R=R/fs;                              	% scaling


axes(handles.messageSignal)
plot(t,m(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The message signal')

axes(handles.carrierSignal)
plot(t,c(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The carrier') 

axes(handles.modulatedSignal)
plot(t,u(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The modulated signal')



function p=Spower(x)
%		p=spower(x)
%SPOWER		Returns the power in signal x
p=(norm(x)^2)/length(x);



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


% --- Executes on button press in spectrumMess.
function spectrumMess_Callback(hObject, eventdata, handles)
% hObject    handle to spectrumMess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cf = get(handles.carrierFreq,'String');
mi = get(handles.modulationIndex,'String');
fr = get(handles.frequencyResolution,'String');


t0 = 0.15;
ts = 0.001;
fc = str2double(cf);
a = str2double(mi);
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df = str2double(fr);
snr=10;
snr_lin=10^(snr/10);                 	% SNR


% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                   	% carrier signal
m_n=m/max(abs(m));                   	% normalized message signal
[M,m,df1]=Fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
f=[0:df1:df1*(length(m)-1)]-fs/2;    	% frequency vector
u=(1+a*m_n).*c;                      	% modulated signal
[U,u,df1]=Fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;                              	% scaling
signal_power=Spower(u(1:length(t)));  	% power in modulated signal
% power in normalized message
pmn=Spower(m(1:length(t)))/(max(abs(m)))^2;
eta=(a^2*pmn)/(1+a^2*pmn);           	% modulation efficiency
noise_power=eta*signal_power/snr_lin;	% noise power
noise_std=sqrt(noise_power);         	% noise standard deviation
noise=noise_std*randn(1,length(u));  	% generate noise
r=u+noise;                           	% add noise to the modulated signal
[R,r,df1]=Fftseq(r,ts,df);           	% Fourier transform 
R=R/fs; 

axes(handles.graph1)
plot(f,abs(fftshift(M))) 
xlabel('Frequency')
title('Spectrum of the message signal')


% --- Executes on button press in noiseSample.
function noiseSample_Callback(hObject, eventdata, handles)
% hObject    handle to noiseSample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cf = get(handles.carrierFreq,'String');
mi = get(handles.modulationIndex,'String');
fr = get(handles.frequencyResolution,'String');


t0 = 0.15;
ts = 0.001;
fc = str2double(cf);
a = str2double(mi);
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df = str2double(fr);
snr=10;
snr_lin=10^(snr/10);                 	% SNR


% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                   	% carrier signal
m_n=m/max(abs(m));                   	% normalized message signal
[M,m,df1]=Fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
f=[0:df1:df1*(length(m)-1)]-fs/2;    	% frequency vector
u=(1+a*m_n).*c;                      	% modulated signal
[U,u,df1]=Fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;                              	% scaling
signal_power=Spower(u(1:length(t)));  	% power in modulated signal
% power in normalized message
pmn=Spower(m(1:length(t)))/(max(abs(m)))^2;
eta=(a^2*pmn)/(1+a^2*pmn);           	% modulation efficiency
noise_power=eta*signal_power/snr_lin;	% noise power
noise_std=sqrt(noise_power);         	% noise standard deviation
noise=noise_std*randn(1,length(u));  	% generate noise
r=u+noise;                           	% add noise to the modulated signal
[R,r,df1]=Fftseq(r,ts,df);           	% Fourier transform 
R=R/fs; 

axes(handles.graph3);
plot(t,noise(1:length(t))) 
title('noise sample') 
xlabel('Time')

% --- Executes on button press in modSignalNoise.
function modSignalNoise_Callback(hObject, eventdata, handles)
% hObject    handle to modSignalNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cf = get(handles.carrierFreq,'String');
mi = get(handles.modulationIndex,'String');
fr = get(handles.frequencyResolution,'String');


t0 = 0.15;
ts = 0.001;
fc = str2double(cf);
a = str2double(mi);
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df = str2double(fr);
snr=10;
snr_lin=10^(snr/10);                 	% SNR


% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                   	% carrier signal
m_n=m/max(abs(m));                   	% normalized message signal
[M,m,df1]=Fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
f=[0:df1:df1*(length(m)-1)]-fs/2;    	% frequency vector
u=(1+a*m_n).*c;                      	% modulated signal
[U,u,df1]=Fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;                              	% scaling
signal_power=Spower(u(1:length(t)));  	% power in modulated signal
% power in normalized message
pmn=Spower(m(1:length(t)))/(max(abs(m)))^2;
eta=(a^2*pmn)/(1+a^2*pmn);           	% modulation efficiency
noise_power=eta*signal_power/snr_lin;	% noise power
noise_std=sqrt(noise_power);         	% noise standard deviation
noise=noise_std*randn(1,length(u));  	% generate noise
r=u+noise;                           	% add noise to the modulated signal
[R,r,df1]=Fftseq(r,ts,df);           	% Fourier transform 
R=R/fs; 

axes(handles.graph4);
plot(t,r(1:length(t))) 
title('Signal and noise')
xlabel('Time')

% --- Executes on button press in spectrumMod.
function spectrumMod_Callback(hObject, eventdata, handles)
% hObject    handle to spectrumMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cf = get(handles.carrierFreq,'String');
mi = get(handles.modulationIndex,'String');
fr = get(handles.frequencyResolution,'String');


t0 = 0.15;
ts = 0.001;
fc = str2double(cf);
a = str2double(mi);
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df = str2double(fr);
snr=10;
snr_lin=10^(snr/10);                 	% SNR


% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                   	% carrier signal
m_n=m/max(abs(m));                   	% normalized message signal
[M,m,df1]=Fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
f=[0:df1:df1*(length(m)-1)]-fs/2;    	% frequency vector
u=(1+a*m_n).*c;                      	% modulated signal
[U,u,df1]=Fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;                              	% scaling
signal_power=Spower(u(1:length(t)));  	% power in modulated signal
% power in normalized message
pmn=Spower(m(1:length(t)))/(max(abs(m)))^2;
eta=(a^2*pmn)/(1+a^2*pmn);           	% modulation efficiency
noise_power=eta*signal_power/snr_lin;	% noise power
noise_std=sqrt(noise_power);         	% noise standard deviation
noise=noise_std*randn(1,length(u));  	% generate noise
r=u+noise;                           	% add noise to the modulated signal
[R,r,df1]=Fftseq(r,ts,df);           	% Fourier transform 
R=R/fs; 

axes(handles.graph2)
plot(f,abs(fftshift(U))) 
title('Spectrum of the modulated signal')
xlabel('Frequency')


% --- Executes on button press in signalSpect.
function signalSpect_Callback(hObject, eventdata, handles)
% hObject    handle to signalSpect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cf = get(handles.carrierFreq,'String');
mi = get(handles.modulationIndex,'String');
fr = get(handles.frequencyResolution,'String');


t0 = 0.15;
ts = 0.001;
fc = str2double(cf);
a = str2double(mi);
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df = str2double(fr);
snr=10;
snr_lin=10^(snr/10);                 	% SNR


% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                   	% carrier signal
m_n=m/max(abs(m));                   	% normalized message signal
[M,m,df1]=Fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
f=[0:df1:df1*(length(m)-1)]-fs/2;    	% frequency vector
u=(1+a*m_n).*c;                      	% modulated signal
[U,u,df1]=Fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;                              	% scaling
signal_power=Spower(u(1:length(t)));  	% power in modulated signal
% power in normalized message
pmn=Spower(m(1:length(t)))/(max(abs(m)))^2;
eta=(a^2*pmn)/(1+a^2*pmn);           	% modulation efficiency
noise_power=eta*signal_power/snr_lin;	% noise power
noise_std=sqrt(noise_power);         	% noise standard deviation
noise=noise_std*randn(1,length(u));  	% generate noise
r=u+noise;                           	% add noise to the modulated signal
[R,r,df1]=Fftseq(r,ts,df);           	% Fourier transform 
R=R/fs; 

axes(handles.graph3);
plot(f,abs(fftshift(U))) 
title('Signal spectrum')
xlabel('Frequency')

% --- Executes on button press in sanSpect.
function sanSpect_Callback(hObject, eventdata, handles)
% hObject    handle to sanSpect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cf = get(handles.carrierFreq,'String');
mi = get(handles.modulationIndex,'String');
fr = get(handles.frequencyResolution,'String');


t0 = 0.15;
ts = 0.001;
fc = str2double(cf);
a = str2double(mi);
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df = str2double(fr);
snr=10;
snr_lin=10^(snr/10);                 	% SNR


% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                   	% carrier signal
m_n=m/max(abs(m));                   	% normalized message signal
[M,m,df1]=Fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
f=[0:df1:df1*(length(m)-1)]-fs/2;    	% frequency vector
u=(1+a*m_n).*c;                      	% modulated signal
[U,u,df1]=Fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;                              	% scaling
signal_power=Spower(u(1:length(t)));  	% power in modulated signal
% power in normalized message
pmn=Spower(m(1:length(t)))/(max(abs(m)))^2;
eta=(a^2*pmn)/(1+a^2*pmn);           	% modulation efficiency
noise_power=eta*signal_power/snr_lin;	% noise power
noise_std=sqrt(noise_power);         	% noise standard deviation
noise=noise_std*randn(1,length(u));  	% generate noise
r=u+noise;                           	% add noise to the modulated signal
[R,r,df1]=Fftseq(r,ts,df);           	% Fourier transform 
R=R/fs; 

axes(handles.graph4);
plot(f,abs(fftshift(R))) 
title('Signal and noise spectrum')
xlabel('Frequency')
