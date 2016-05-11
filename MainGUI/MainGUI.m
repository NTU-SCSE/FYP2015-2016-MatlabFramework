% Final Year Project CE
% Author:           Nonny Florentine (U1320766B)
%
% MainGUI
% 
% Lastest update:   15 March 2016     

function varargout = MainGUI(varargin)
% MAINGUI MATLAB code for MainGUI.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainGUI

% Last Modified by GUIDE v2.5 16-Mar-2016 01:56:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MainGUI_OutputFcn, ...
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


% --- Executes just before MainGUI is made visible.
function MainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainGUI (see VARARGIN)

% Choose default command line output for MainGUI
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


% ---------------------------------------------------------------------------%
% The MainGUI
% ---------------------------------------------------------------------------%

% scan xml file 
if isunix
    xmlinfo = rdir(['../','/**/*.xml']);
else
    xmlinfo = rdir(['..\','\**\*.xml']);
end

numCourse = 0;


for i=1:length(xmlinfo)
    xmlstruct = xml2struct(xmlinfo(i).name);
    switch lower(xmlstruct.main_gui.type.Text)
        case 'course' % 2nd Level
            numCourse = numCourse + 1;
            handles.course_group(numCourse) = xmlstruct.main_gui;
    end
end

for i=1:length(xmlinfo)
    xmlstruct = xml2struct(xmlinfo(i).name);
    [path,name, ext] = fileparts(xmlinfo(i).name);
    switch lower(xmlstruct.main_gui.type.Text)
        case 'topic' % 3rd Level   
            for y = 1:length(handles.course_group)
                if strcmp(handles.course_group(y).course.Text,xmlstruct.main_gui.course.Text)
                    if isfield(handles.course_group(y),{'topic_group'})
                        xmlstruct.main_gui.path = path;
                        handles.course_group(y).topic_group(end+1) = xmlstruct.main_gui;
                        %handles.course_group(y).topic_group(end+1).path = path;
                    else
                        handles.course_group(y).topic_group(1) = xmlstruct.main_gui;
                        handles.course_group(y).topic_group(1).path = path;
                    end
                end
            end
           
    end
end



for i=1:length(xmlinfo)
    xmlstruct = xml2struct(xmlinfo(i).name);
    [path,name, ext] = fileparts(xmlinfo(i).name);
    switch lower(xmlstruct.main_gui.type.Text)
    
        case 'subtopic' % 4th Level
            course_index = 0;
            % find a course
            for y = 1:length(handles.course_group)
                if strcmp(handles.course_group(y).course.Text,xmlstruct.main_gui.course.Text)
                    course_index = y;
                end
            end
            
            % find a topic
            for g = 1:length(handles.course_group(course_index).topic_group)
                if strcmp(handles.course_group(course_index).topic_group(g).topic.Text,xmlstruct.main_gui.topic.Text)
                    if isfield(handles.course_group(course_index).topic_group(g),{'subTopic_group'})
                        xmlstruct.main_gui.path = path;
                        handles.course_group(course_index).topic_group(g).subTopic_group(end+1) = xmlstruct.main_gui;
                        %handles.course_group(module_index).topic_group(g).subTopic_group(end+1).path = path;
                    else
                        handles.course_group(course_index).topic_group(g).subTopic_group(1) = xmlstruct.main_gui;
                        handles.course_group(course_index).topic_group(g).subTopic_group(1).path = path;
                    end
                end
            end
                   
        end
    
end

% ---------------------------------------------------------------------------%


% ---------------------------------------------------------------------------%
% For the Main GUI, 1st pop-up menu, 2nd pop-up menu and the list box
% ---------------------------------------------------------------------------%

course = get(handles.coursePopupMenu,'value');
topic = get(handles.topicPopupMenu,'value');

% populate module
for i=1:length(handles.course_group) % length of course_group = 1 2 
    courseStr{i} = [handles.course_group(i).course.Text]; 
end
set(handles.coursePopupMenu,'String',courseStr);



populateTopics(handles,course)
populateSubTopics(hObject,handles,course,1,1)

function populateTopics (handles, course)
% populates topic
ii=1;
for i=1:length(handles.course_group(course).topic_group)
    if strcmp(handles.course_group(course).course.Text,handles.course_group(course).topic_group(i).course.Text)
        topicStr{i} = [handles.course_group(course).topic_group(i).topic.Text]; 
        ii=ii+1;
    end
end

set(handles.topicPopupMenu,'String',topicStr); 


function populateSubTopics(hObject,handles,course,topic,subTopic)
% populates subtopic
count=0;
for k = 1:length(handles.course_group(course).topic_group)
       if strcmp(handles.course_group(course).course.Text,handles.course_group(course).topic_group(k).course.Text)
            count=count+1;
            if count==topic
                 for i=1:length(handles.course_group(course).topic_group(k).subTopic_group)
                     if strcmp(handles.course_group(course).topic_group(k).topic.Text,handles.course_group(course).topic_group(k).subTopic_group(i).topic.Text)
                        subTopicStr{i} = [handles.course_group(course).topic_group(topic).subTopic_group(i).subtopic.Text];
                     end
                 end 
                 realTopic=k;
            end
       end
end

% variables in handles for button value
handles.realSubmodule=realTopic; 
handles.realSubsubmodule=subTopic; 
 
set(handles.subTopicList,'String',subTopicStr);    

display_subTopic(handles, course, topic, subTopic);

% ---------------------------------------------------------------------------%

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes MainGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in topicPopupMenu.
function topicPopupMenu_Callback(hObject, eventdata, handles)
% hObject    handle to topicPopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns topicPopupMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from topicPopupMenu


% get the current topic to show
topic = get(handles.topicPopupMenu,'value');
course = get(handles.coursePopupMenu,'value');
subTopic = get(handles.subTopicList,'value');

set(handles.startText,'visible','off');
set(handles.subTopicList,'value',1);
populateSubTopics(hObject,handles,course,topic,1)  

display_subTopic(handles, course, topic, subTopic);
guidata(hObject, handles);

%% Display the information of the MATLAB GUI app
function display_subTopic(handles,course, topic, subTopic)
% display description
set(handles.desText,'String',handles.course_group(course).topic_group(topic).subTopic_group(subTopic).description.Text);
% display snapshot
if ~isempty(handles.course_group(course).topic_group(topic).subTopic_group(subTopic).snapshot.Text)
    axes(handles.snapshotAxes)
    imshow([handles.course_group(course).topic_group(topic).subTopic_group(subTopic).path '/' handles.course_group(course).topic_group(topic).subTopic_group(subTopic).snapshot.Text]);
end


% --- Executes during object creation, after setting all properties.
function topicPopupMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to topicPopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in subTopicList.
function subTopicList_Callback(hObject, eventdata, handles)
% hObject    handle to subTopicList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns subTopicList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from subTopicList
topic = get(handles.topicPopupMenu,'value');
subTopic = get(handles.subTopicList,'value');
course = get(handles.coursePopupMenu,'value');

populateSubTopics(hObject,handles,course,topic,subTopic) 

set(handles.startText,'visible','off');
display_subTopic(handles,course,topic,subTopic);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function subTopicList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subTopicList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in logout.
function logout_Callback(hObject, eventdata, handles)
% hObject    handle to logout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in openBtn.
function openBtn_Callback(hObject, eventdata, handles)
% hObject    handle to openBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
topic = get(handles.topicPopupMenu,'value');
subTopic = get(handles.subTopicList,'value');
course = get(handles.coursePopupMenu,'value');

if ~isempty(handles.course_group(course).topic_group(topic).subTopic_group(subTopic).function.Text)
    funcstr = [handles.course_group(course).topic_group(topic).subTopic_group(subTopic).path '/' handles.course_group(course).topic_group(topic).subTopic_group(subTopic).function.Text];
    eval_func = str2func(handles.course_group(course).topic_group(topic).subTopic_group(subTopic).function.Text(1:end-2));
    addpath(handles.course_group(course).topic_group(topic).subTopic_group(subTopic).path);
    eval_func();
end


% --- Executes during object creation, after setting all properties.
function snapshotAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to snapshotAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate snapshotAxes


% --- Executes on selection change in coursePopupMenu.
function coursePopupMenu_Callback(hObject, eventdata, handles)
% hObject    handle to coursePopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
topic = get(handles.topicPopupMenu,'value');
subTopic = get(handles.subTopicList,'value');
course = get(handles.coursePopupMenu,'value');

set(handles.topicPopupMenu,'value',1);
set(handles.subTopicList,'value',1);

populateTopics(handles,course)
populateSubTopics(hObject,handles,course,1,1) 

set(handles.startText,'visible','off');

guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns coursePopupMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from coursePopupMenu


% --- Executes during object creation, after setting all properties.
function coursePopupMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coursePopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function startText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
