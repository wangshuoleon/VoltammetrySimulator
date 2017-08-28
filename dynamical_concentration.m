function varargout = dynamical_concentration(varargin)
%DYNAMICAL_CONCENTRATION M-file for dynamical_concentration.fig
%      DYNAMICAL_CONCENTRATION, by itself, creates a new DYNAMICAL_CONCENTRATION or raises the existing
%      singleton*.
%
%      H = DYNAMICAL_CONCENTRATION returns the handle to a new DYNAMICAL_CONCENTRATION or the handle to
%      the existing singleton*.
%
%      DYNAMICAL_CONCENTRATION('Property','Value',...) creates a new DYNAMICAL_CONCENTRATION using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to dynamical_concentration_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      DYNAMICAL_CONCENTRATION('CALLBACK') and DYNAMICAL_CONCENTRATION('CALLBACK',hObject,...) call the
%      local function named CALLBACK in DYNAMICAL_CONCENTRATION.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dynamical_concentration

% Last Modified by GUIDE v2.5 27-Aug-2017 22:05:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dynamical_concentration_OpeningFcn, ...
                   'gui_OutputFcn',  @dynamical_concentration_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before dynamical_concentration is made visible.
function dynamical_concentration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

%% passing the data from figure1 to figure2
h = findobj('Tag','figure1');
g1data = guidata(h);
handles.data=g1data.data;

%% initialise the plots 
i=1;
x=handles.data.x;
t=handles.data.t;
solution=handles.data.solution;
sizes=size(solution);
X=x'*ones(1,sizes(3));
Y=squeeze(solution(i,:,:));
% concentration plot
axes(handles.axes1);
plot(X,Y)
title(['t=',num2str(t(i)),'s'])
xlabel('Distance to electrode m')
ylabel('Concentration mmol/L')
switch handles.data.Ctrl.Mechanism
           case 'E'
              legend('R','O');
           case 'EC'
               legend('R','O','Products')
           case 'ECE'
               legend('R','O','S','T')
           case 'ECatalysis'
               legend('R','O','Y')
end
% current time plot
axes(handles.axes2);
plot(t(1:i),handles.data.i_profiles(1:i))
       title(['Time=',num2str(t(i)),'s,i=',num2str(handles.data.i_profiles(i)),'A/m^2'])
       xlabel('Time (s)')
       ylabel('Current density A/m^2')
       
%% initialise the listbox
 set(handles.listbox2,'String',num2cell(t));

%%

guidata(hObject,handles);




% Choose default command line output for dynamical_concentration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dynamical_concentration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dynamical_concentration_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called






% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i=get(hObject,'Value');
x=handles.data.x;
t=handles.data.t;
solution=handles.data.solution;
sizes=size(solution);
X=x'*ones(1,sizes(3));
Y=squeeze(solution(i,:,:));
% concentration plot
axes(handles.axes1);
plot(X,Y)
title(['t=',num2str(t(i)),'s'])
xlabel('Distance to electrode m')
ylabel('Concentration mmol/L')
switch handles.data.Ctrl.Mechanism
           case 'E'
              legend('R','O');
           case 'EC'
               legend('R','O','Products')
           case 'ECE'
               legend('R','O','S','T')
           case 'ECatalysis'
               legend('R','O','Y')
end
% current time plot
axes(handles.axes2);
plot(t(1:i),handles.data.i_profiles(1:i))
       title(['Time=',num2str(t(i)),'s,i=',num2str(handles.data.i_profiles(i)),'A/m^2'])
       xlabel('Time (s)')
       ylabel('Current density A/m^2')



% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
keyboard
