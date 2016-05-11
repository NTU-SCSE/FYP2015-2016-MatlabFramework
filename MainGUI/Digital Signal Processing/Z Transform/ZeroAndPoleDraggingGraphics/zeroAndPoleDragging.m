function varargout = zeroAndPoleDragging(varargin)
% ZEROANDPOLEDRAGGING MATLAB code for zeroAndPoleDragging.fig
%      ZEROANDPOLEDRAGGING, by itself, creates a new ZEROANDPOLEDRAGGING or raises the existing
%      singleton*.
%
%      H = ZEROANDPOLEDRAGGING returns the handle to a new ZEROANDPOLEDRAGGING or the handle to
%      the existing singleton*.
%
%      ZEROANDPOLEDRAGGING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZEROANDPOLEDRAGGING.M with the given input arguments.
%
%      ZEROANDPOLEDRAGGING('Property','Value',...) creates a new ZEROANDPOLEDRAGGING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before zeroAndPoleDragging_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to zeroAndPoleDragging_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help zeroAndPoleDragging

% Last Modified by GUIDE v2.5 08-Mar-2016 02:43:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @zeroAndPoleDragging_OpeningFcn, ...
                   'gui_OutputFcn',  @zeroAndPoleDragging_OutputFcn, ...
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


% --- Executes just before zeroAndPoleDragging is made visible.
function zeroAndPoleDragging_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to zeroAndPoleDragging (see VARARGIN)

% Choose default command line output for zeroAndPoleDragging
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

initialize(handles);

recompute(handles);
axes(handles.zeroPoleGraph)
poleclick(handles);
axes(handles.zeroPoleGraph)
zeroclick(handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes zeroAndPoleDragging wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function initialize(handles)
global zh ph Lresp Nfft b a z h Y p
global ax1 ax2 ax3 z_surface_CameraPos z_surface_CameraUpVec toggleDisplay
 
z_surface_CameraPos=[3.7719  -15.7111  275.3541];
z_surface_CameraUpVec=[-0.1237    0.5153   23.1286];
toggleDisplay = 0;
set(0,'defaultaxesfontsize',10)

z = [0.29-0.41j 0.29+0.41j]' ;
p = [-0.6+0.73j -0.6-0.73j]' ;
axes(handles.zeroPoleGraph)
[zh,ph,cruff]=zplaneplot(z,p);
set(cruff,'hittest','off')
ax1 = gca;
ylabel('Imaginary Part')
xlabel('Real Part')


axes(handles.magnitudePart)
[b,a]=zp2tf(z,p,1);   
Nfft = 512;
Y = fft(b,Nfft)./fft(a,Nfft);
Lresp = plot((0:Nfft-1)/Nfft*2-1, 20*log10(fftshift(abs(Y))),'linewidth',2);
ax2 = gca;
set(ax2,'xlim',[0 1])

%set(ax2,'xlim',[-.5 .5])
%set(ax2,'ylim',[-50 20])

grid on
xlabel('Normalised Frequency (x\pi rads/sample)')
ylabel('Magnitude (db) ')



%set(Lresp,'erasemode','xor')
%set(Lresp,'erasemode','xor')
set(zh,'buttondownfcn','zeroAndPoleDragging(''zeroclick'')',...
    'markersize',10,'linewidth',2)
set(ph,'buttondownfcn','zeroAndPoleDragging(''poleclick'')',...
    'markersize',10,'linewidth',2)


zeroAndPoleDragging('recompute')

         

% --- Outputs from this function are returned to the command line.
function varargout = zeroAndPoleDragging_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in addZeroButton.
function addZeroButton_Callback(hObject, eventdata, handles)
% hObject    handle to addZeroButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global zh ph Lresp Nfft b a z h Y p
global ax1 ax2 ax3 z_surface_CameraPos z_surface_CameraUpVec toggleDisplay

if length(zh)>0
    zh(end+1) =  line(.5,0,'parent',ax1,'buttondownfcn','zeroAndPoleDragging(''zeroclick'')',...
        'markersize',8,'linewidth',1,'marker','o','linestyle','none');
else
    zh = line(.5,0,'parent',ax1,'buttondownfcn','zeroAndPoleDragging(''zeroclick'')',...
        'markersize',8,'linewidth',1,'marker','o','linestyle','none');
    set(findobj('string','Remove Zeros'),'enable','on')
end


axes(handles.zeroPoleGraph)
zeroAndPoleDragging('recompute')


% --- Executes on button press in addPoleButton.
function addPoleButton_Callback(hObject, eventdata, handles)
% hObject    handle to addPoleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global zh ph Lresp Nfft b a z h Y p
global ax1 ax2 ax3 z_surface_CameraPos z_surface_CameraUpVec toggleDisplay

if length(ph)>0
    ph(end+1) =  line(.5,0,'parent',ax1,'buttondownfcn','zeroAndPoleDragging(''poleclick'')',...
        'markersize',8,'linewidth',1,'marker','x','linestyle','none');
else
	ph =  line(.5,0,'parent',ax1,'buttondownfcn','zeroAndPoleDragging(''poleclick'')',...
        'markersize',8,'linewidth',1,'marker','x','linestyle','none');
    set(findobj('string','Remove Poles'),'enable','on')
end
axes(handles.zeroPoleGraph)
zeroAndPoleDragging('recompute')

% --- Executes on button press in toggleDisplay.
function toggleDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to toggleDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global zh ph Lresp Nfft b a z h Y
global ax1 ax2 ax3 z_surface_CameraPos z_surface_CameraUpVec toggleDisplay
 

toggleDisplay = get(handles.toggleDisplay);
axes(handles.zeroPoleGraph)
zeroAndPoleDragging('recompute')

% --- Executes on button press in removePoleButton.
function removePoleButton_Callback(~, ~, handles)
% hObject    handle to removePoleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global zh ph Lresp Nfft b a z h Y p
global ax1 ax2 ax3 z_surface_CameraPos z_surface_CameraUpVec toggleDisplay

delete(ph(end))
ph(end)=[];
if length(ph)==0
    set(gco,'enable','off')
end
axes(handles.zeroPoleGraph)
zeroAndPoleDragging('recompute')


% --- Executes on button press in removeZeroButton.
function removeZeroButton_Callback(~, ~, handles)
% hObject    handle to removeZeroButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global zh ph Lresp Nfft b a z h Y p
global ax1 ax2 ax3 z_surface_CameraPos z_surface_CameraUpVec toggleDisplay


delete(zh(end))
zh(end)=[];
if length(zh)==0
    set(gco,'enable','off')
end

axes(handles.zeroPoleGraph)
zeroAndPoleDragging('recompute')




function zeroclick(handles)
global zh ph Lresp Nfft b a z h Y p
global ax1 ax2 ax3 z_surface_CameraPos z_surface_CameraUpVec toggleDisplay

set(gcf,'userdata','')
set(gcf,'windowbuttonmotionfcn','set(gcf,''userdata'',''motion'')')
set(gcf,'windowbuttonupfcn','set(gcf,''userdata'',''up'')')

ind = find(zh==gco);
set(zh(ind),'erasemode','xor')
set(Lresp,'erasemode','xor')
pair = length(get(zh(ind),'xdata'))==2;
done = 0;

pt = get(ax1,'currentpoint');
pt = pt(1,1:2);


title(['selected position: ' num2str(pt) 'j'])

while ~done
    waitfor(gcf,'userdata')
    switch get(gcf,'userdata')
    case 'motion'
        pt = get(ax1,'currentpoint');
        pt = pt(1,1:2);
        title(['selected position: ' num2str(pt) 'j'])
        %if pair
        if 1
            set(zh(ind),'xdata',[pt(1) pt(1)],'ydata',[pt(2) -pt(2)])
        else
            set(zh(ind),'xdata',pt(1),'ydata',pt(2))
        end

        zeroAndPoleDragging('recompute')
    case 'up'
        done = 1;
    end
    set(gcf,'userdata','')
end
set(gcf,'windowbuttonmotionfcn','')
set(gcf,'windowbuttonupfcn','')
set(zh(ind),'erasemode','xor')
set(Lresp,'erasemode','xor')
set(ax2,'ylimmode','auto')
ylim = get(ax2,'ylim');
Y = get(Lresp,'ydata');

if ylim(1)>min(Y)-3 || ylim(2)<max(Y)+3
    set(ax2,'ylim',[min(Y)-3 max(Y)+3])
end



function poleclick(handles)
global zh ph Lresp Nfft b a z h Y
global ax1 ax2 z_surface_CameraPos z_surface_CameraUpVec toggleDisplay

set(gcf,'userdata','')
set(gcf,'windowbuttonmotionfcn','set(gcf,''userdata'',''motion'')')
set(gcf,'windowbuttonupfcn','set(gcf,''userdata'',''up'')')

ind = find(ph==gco);
%set(ph(ind),'erasemode','xor')
%set(Lresp,'erasemode','xor')
pair = length(get(ph(ind),'xdata'))==2;
done = 0;

pt = get(ax1,'currentpoint');
pt = pt(1,1:2);



title(['selected position: ' num2str(pt) 'j'])

while ~done
    waitfor(gcf,'userdata')
    switch get(gcf,'userdata')
    case 'motion'
        pt = get(ax1,'currentpoint');
        pt = pt(1,1:2);

        if 1
            set(ph(ind),'xdata',[pt(1) pt(1)],'ydata',[pt(2) -pt(2)])
        else
            set(ph(ind),'xdata',pt(1),'ydata',pt(2))
        end

        zeroAndPoleDragging('recompute')
    case 'up'
        done = 1;
    end
    set(gcf,'userdata','')
end

set(gcf,'windowbuttonmotionfcn','')
set(gcf,'windowbuttonupfcn','')
set(ph(ind),'erasemode','normal')
set(Lresp,'erasemode','normal')
set(ax2,'ylimmode','auto')
Y = get(Lresp,'ydata');
ylim = get(ax2,'ylim');
if ylim(1)>min(Y)-3 || ylim(2)<max(Y)+3
    set(ax2,'ylim',[min(Y)-3 max(Y)+3])
end



function recompute(handles)
global zh ph Lresp Nfft b a z h Y
global ax1 ax2 ax3 z_surface_CameraPos z_surface_CameraUpVec toggleDisplay

z = [];
p = [];
b = 1;
a = 1;
for i=1:length(zh)
    zx = get(zh(i),'xdata');
    zy = get(zh(i),'ydata');
    if length(zx)==1
        b = conv(b,[1 -(zx+sqrt(-1)*zy)]);
    else
        b = conv(b,[1 -2*zx(1) zx(1).^2+zy(1).^2]);
    end
    z = [z zx+sqrt(-1)*zy];
end
for i=1:length(ph)
    px = get(ph(i),'xdata');
    py = get(ph(i),'ydata');
    if length(px)==1
        a = conv(a,[1 -(px+sqrt(-1)*py)]);
    else
        a = conv(a,[1 -2*px(1) px(1).^2+py(1).^2]);
    end
    p = [p px+sqrt(-1)*py];
end

Y = fft(b,Nfft)./fft(a,Nfft);
%Y = Y/max(abs(Y));
set(Lresp,'ydata',20*log10(fftshift(abs(Y))))




% --- Executes during object creation, after setting all properties.
function zeroPoleGraph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zeroPoleGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate zeroPoleGraph
