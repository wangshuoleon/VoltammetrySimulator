function varargout = EC_simulator(varargin)
% EC_SIMULATOR MATLAB code for EC_simulator.fig
%      EC_SIMULATOR, by itself, creates a new EC_SIMULATOR or raises the existing
%      singleton*.
%
%      H = EC_SIMULATOR returns the handle to a new EC_SIMULATOR or the handle to
%      the existing singleton*.
%
%      EC_SIMULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EC_SIMULATOR.M with the given input arguments.
%
%      EC_SIMULATOR('Property','Value',...) creates a new EC_SIMULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EC_simulator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EC_simulator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EC_simulator

% Last Modified by GUIDE v2.5 13-Feb-2017 11:42:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EC_simulator_OpeningFcn, ...
                   'gui_OutputFcn',  @EC_simulator_OutputFcn, ...
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


% --- Executes just before EC_simulator is made visible.
function EC_simulator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EC_simulator (see VARARGIN)
load('E.mat');
       axes(handles.axes1);
       switch data.Ctrl.Mechanism
           case 'E'
               % show the E mechanism image in axes1
               imshow('pics\E.jpg')
               % set the title of ReactionParameters panel
               set(handles.RP_panel,'Title','E Mechanism ReactionParameters');
           case 'EC'
               imshow('pics\EC.jpg')
               set(handles.RP_panel,'Title','EC Mechanism ReactionParameters');
           case 'ECE'
               imshow('pics\ECE.jpg')
               set(handles.RP_panel,'Title','ECE Mechanism ReactionParameters');
           case 'ECatalysis'
               imshow('pics\ECatalysis.jpg')
               set(handles.RP_panel,'Title','ECatalysis Mechanism ReactionParameters');
       end
       switch data.Ctrl.Tech
           case 'CV'
               set(handles.EP_panel,'Title','Cyclic Voltammetry Parameters');
           case 'CA'
               set(handles.EP_panel,'Title','Chronoamperometry Parameters');
       end
               % set ReactionParameters table
               fields=fieldnames(data.ReactionParameters);
               TableData=cell(length(fields),2);
               for i=1:length(fields)
                   TableData{i,1}=fields{i};
                   TableData{i,2}=data.ReactionParameters.(fields{i});
               end
               set(handles.RP_table,'data',TableData);
               % set ElectricalParameters table
               fields=fieldnames(data.ElectricalParameters);
               TableData=cell(length(fields),2);
               for i=1:length(fields)
                   TableData{i,1}=fields{i};
                   TableData{i,2}=data.ElectricalParameters.(fields{i});
               end
               set(handles.EP_table,'data',TableData);
               % set the constants table
               TableData=cell(2,3);
               TableData{1,1}='Temperature';
               TableData{1,2}=data.Const.Temperature;
                TableData{1,3}='K';
               TableData{2,1}='Diffusion Coefficient';
                TableData{2,2}=data.Const.DiffusionCo;
                 TableData{2,3}='m^2/s';
                 set(handles.const_table,'data',TableData);
       axes(handles.axes2);
       plottime(data.t,data.i_profiles)
       xlabel('Time s');
       ylabel('Current Density A/m^2')
       handles.data=data;
       
% Choose default command line output for EC_simulator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EC_simulator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EC_simulator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
str=get(hObject,'String');
val=get(hObject,'Value');

switch str{val}
    case 't vs i'
        plottime(handles.data.t,handles.data.i_profiles);
        xlabel('Time s');
        ylabel('Current Density A/m^2')
    case 'potential vs i'
        overlap_cv(handles.data);
        xlabel('Potential V');
       ylabel('Current Density A/m^2')
    case 't vs potential'
        plottime(handles.data.t,handles.data.potential)
             xlabel('Time s');
             ylabel('Potential V')
    
end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Openfilename, Openpathname, filterindex] = uigetfile( ...
  '*.mat', ...
   'Select the experiment file', ...
   'MultiSelect', 'off');
if Openfilename==0
else
 
       Openfname=fullfile(Openpathname,Openfilename);
       load(Openfname);
       axes(handles.axes1);
       switch data.Ctrl.Mechanism
           case 'E'
               % show the E mechanism image in axes1
               imshow('pics\E.jpg')
               % set the title of ReactionParameters panel
               set(handles.RP_panel,'Title','E Mechanism ReactionParameters');
           case 'EC'
               imshow('pics\EC.jpg')
               set(handles.RP_panel,'Title','EC Mechanism ReactionParameters');
           case 'ECE'
               imshow('pics\ECE.jpg')
               set(handles.RP_panel,'Title','ECE Mechanism ReactionParameters');
           case 'ECatalysis'
               imshow('pics\ECatalysis.jpg')
               set(handles.RP_panel,'Title','ECatalysis Mechanism ReactionParameters');
       end
       switch data.Ctrl.Tech
           case 'CV'
               set(handles.EP_panel,'Title','Cyclic Voltammetry Parameters');
           case 'CA'
               set(handles.EP_panel,'Title','Chronoamperometry Parameters');
       end
               % set ReactionParameters table
               fields=fieldnames(data.ReactionParameters);
               TableData=cell(length(fields),2);
               for i=1:length(fields)
                   TableData{i,1}=fields{i};
                   TableData{i,2}=data.ReactionParameters.(fields{i});
               end
               set(handles.RP_table,'data',TableData);
               % set ElectricalParameters table
               fields=fieldnames(data.ElectricalParameters);
               TableData=cell(length(fields),2);
               for i=1:length(fields)
                   TableData{i,1}=fields{i};
                   TableData{i,2}=data.ElectricalParameters.(fields{i});
               end
               set(handles.EP_table,'data',TableData);
               % set the constants table
               TableData=cell(2,3);
               TableData{1,1}='Temperature';
               TableData{1,2}=data.Const.Temperature;
                TableData{1,3}='K';
               TableData{2,1}='Diffusion Coefficient';
                TableData{2,2}=data.Const.DiffusionCo;
                 TableData{2,3}='m^2/s';
                 set(handles.const_table,'data',TableData);
               switch data.Ctrl.SurfaceReaction
                   case 'on'
                       set(handles.sr_checkbox,'value',1)
                   case 'off'
                       set(handles.sr_checkbox,'value',0)
               end
       axes(handles.axes2);
       plottime(data.t,data.i_profiles)
       xlabel('Time s');
       ylabel('Current Density A/m^2')
       handles.data=data;
       set(handles.popupmenu1,'Enable','on')
       set(handles.export,'Enable','on')
       guidata(hObject,handles);
end

       
 


% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[Savefile,Savepath] = uiputfile('*.mat','Save Experiment As');
if Savefile==0
else

Savefilename=fullfile(Savepath,Savefile);
save(Savefilename,'-struct','handles','data' );
end



% --------------------------------------------------------------------
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
if strcmp(handles.data.Ctrl.SurfaceReaction,'off')

 set(handles.figure1, 'pointer', 'watch')
 drawnow;
 % your computation
    tic
    [ handles.data.x,handles.data.t] = meshing(handles.data.ElectricalParameters, handles.data.Ctrl,handles.data.Const);
    [ handles.data.potential ] = PotentialGeneration( handles.data.Ctrl ,handles.data.ElectricalParameters,handles.data.t);
    [handles.data.solution,handles.data.i_profiles]=solver(handles.data.ReactionParameters,handles.data.ElectricalParameters,handles.data.Ctrl,handles.data.Const,handles.data.x,handles.data.t,handles.data.potential);
    elapsedtime=toc;
    set(handles.text1,'string',['Computation Time',num2str(elapsedtime)]);
    set(handles.figure1, 'pointer', 'arrow');
    axes(handles.axes2);
    plottime(handles.data.t,handles.data.i_profiles)
    xlabel('Time s');
    ylabel('Current Density A/m^2')
    set(handles.popupmenu1,'Enable','on')
    set(handles.export,'Enable','on')
else
    %     handles.data.Const.DiffusionCo=1e12;
    set(handles.figure1, 'pointer', 'watch')
    drawnow;
    tic
    [ handles.data.x,handles.data.t] = meshing(handles.data.ElectricalParameters, handles.data.Ctrl,handles.data.Const);
    [ handles.data.potential ] = PotentialGeneration( handles.data.Ctrl ,handles.data.ElectricalParameters,handles.data.t);
    handles.data.x=linspace(0,1,10);
    handles.data.Const.DiffusionCo=1e12;
    [handles.data.solution,handles.data.i_profiles]=solver(handles.data.ReactionParameters,handles.data.ElectricalParameters,handles.data.Ctrl,handles.data.Const,handles.data.x,handles.data.t,handles.data.potential);
    elapsedtime=toc;
    ConstTable=get(handles.const_table,'data');
    handles.data.Const.DiffusionCo=ConstTable{2,2};
    set(handles.text1,'string',['Computation Time',num2str(elapsedtime)]);
    set(handles.figure1, 'pointer', 'arrow');
    axes(handles.axes2);
    plottime(handles.data.t,handles.data.i_profiles)
    xlabel('Time s');
    ylabel('Current Density A/m^2')
    set(handles.popupmenu1,'Enable','on')
    set(handles.export,'Enable','on')
end
catch 
    set(handles.text1,'String','Error, the solver does not converge, please try to decrese the potential range')
end
guidata(hObject,handles);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run_Callback(handles.run, eventdata, handles)



% --- Executes when entered data in editable cell(s) in RP_table.
function RP_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to RP_table (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
TableData=get(handles.RP_table,'data');
fields=fieldnames(handles.data.ReactionParameters);
     for i=1:length(fields)
        handles.data.ReactionParameters.(fields{i})=TableData{i,2};
     end
     set(handles.popupmenu1,'Enable','off')
     set(handles.export,'Enable','off')
     guidata(hObject,handles);
     


% --- Executes when entered data in editable cell(s) in EP_table.
function EP_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to EP_table (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
TableData=get(handles.EP_table,'data');
fields=fieldnames(handles.data.ElectricalParameters);
     for i=1:length(fields)
        handles.data.ElectricalParameters.(fields{i})=TableData{i,2};
     end
     [ handles.data.x,handles.data.t] = meshing(handles.data.ElectricalParameters, handles.data.Ctrl,handles.data.Const);
     [ handles.data.potential ] = PotentialGeneration( handles.data.Ctrl ,handles.data.ElectricalParameters,handles.data.t);
     axes(handles.axes2)
     plottime(handles.data.t,handles.data.potential)
     xlabel('Time s');
     ylabel('Potential V')
     set(handles.popupmenu1,'Enable','off')
     set(handles.export,'Enable','off')
     guidata(hObject,handles);


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function setups_Callback(hObject, eventdata, handles)
% hObject    handle to setups (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.popupmenu1,'Enable','off')
     set(handles.export,'Enable','off')



% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tech_Callback(hObject, eventdata, handles)
% hObject    handle to tech (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function cv_Callback(hObject, eventdata, handles)
% hObject    handle to cv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.EP_panel,'title','Cyclic voltammetry Parameters')
CVParameters;
fields=fieldnames(CV);
TableData=cell(length(fields),2);
               for i=1:length(fields)
                   TableData{i,1}=fields{i};
                   TableData{i,2}=CV.(fields{i});
               end
set(handles.EP_table,'data',TableData);
handles.data.ElectricalParameters=CV;
handles.data.Ctrl.Tech='CV';
[ handles.data.x,handles.data.t] = meshing(handles.data.ElectricalParameters, handles.data.Ctrl,handles.data.Const);
     [ handles.data.potential ] = PotentialGeneration( handles.data.Ctrl ,handles.data.ElectricalParameters,handles.data.t);
     axes(handles.axes2)
     plottime(handles.data.t,handles.data.potential)
     xlabel('Time s');
     ylabel('Potential V')
guidata(hObject,handles);


% --------------------------------------------------------------------
function CA_Callback(hObject, eventdata, handles)
% hObject    handle to CA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.EP_panel,'title','Chronoamperometry Parameters')
CAParameters;
fields=fieldnames(CA);
TableData=cell(length(fields),2);
               for i=1:length(fields)
                   TableData{i,1}=fields{i};
                   TableData{i,2}=CA.(fields{i});
               end
set(handles.EP_table,'data',TableData);
handles.data.ElectricalParameters=CA;
handles.data.Ctrl.Tech='CA';
[ handles.data.x,handles.data.t] = meshing(handles.data.ElectricalParameters, handles.data.Ctrl,handles.data.Const);
     [ handles.data.potential ] = PotentialGeneration( handles.data.Ctrl ,handles.data.ElectricalParameters,handles.data.t);
     axes(handles.axes2)
     plottime(handles.data.t,handles.data.potential)
     xlabel('Time s');
     ylabel('Potential V')
guidata(hObject,handles);




% --------------------------------------------------------------------
function E_Callback(hObject, eventdata, handles)
% hObject    handle to E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imshow('pics\E.jpg');
set(handles.RP_panel,'title','E Parameters')
E_mechanism_parameters;
fields=fieldnames(E);
TableData=cell(length(fields),2);
               for i=1:length(fields)
                   TableData{i,1}=fields{i};
                   TableData{i,2}=E.(fields{i});
               end
set(handles.RP_table,'data',TableData);
handles.data.ReactionParameters=E;
handles.data.Ctrl.Mechanism='E';
guidata(hObject,handles);



% --------------------------------------------------------------------
function EC_Callback(hObject, eventdata, handles)
% hObject    handle to EC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imshow('pics\EC.jpg');
set(handles.RP_panel,'title','EC Parameters')
EC_mechanism_parameters;
fields=fieldnames(EC);
TableData=cell(length(fields),2);
               for i=1:length(fields)
                   TableData{i,1}=fields{i};
                   TableData{i,2}=EC.(fields{i});
               end
set(handles.RP_table,'data',TableData);
handles.data.ReactionParameters=EC;
handles.data.Ctrl.Mechanism='EC';
guidata(hObject,handles);


% --------------------------------------------------------------------
function ECE_Callback(hObject, eventdata, handles)
% hObject    handle to ECE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imshow('pics\ECE.jpg');
set(handles.RP_panel,'title','ECE Parameters')
ECE_parameters;
fields=fieldnames(ECE);
TableData=cell(length(fields),2);
               for i=1:length(fields)
                   TableData{i,1}=fields{i};
                   TableData{i,2}=ECE.(fields{i});
               end
set(handles.RP_table,'data',TableData);
handles.data.ReactionParameters=ECE;
handles.data.Ctrl.Mechanism='ECE';
guidata(hObject,handles);



% --------------------------------------------------------------------
function ECatalysis_Callback(hObject, eventdata, handles)
% hObject    handle to ECatalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imshow('pics\ECatalysis.jpg');
set(handles.RP_panel,'title','ECatalysis Parameters')
ECatalysis_parameters;
fields=fieldnames(ECatalysis);
TableData=cell(length(fields),2);
               for i=1:length(fields)
                   TableData{i,1}=fields{i};
                   TableData{i,2}=ECatalysis.(fields{i});
               end
set(handles.RP_table,'data',TableData);
handles.data.ReactionParameters=ECatalysis;
handles.data.Ctrl.Mechanism='ECatalysis';
guidata(hObject,handles);


% --------------------------------------------------------------------
function export_Callback(hObject, eventdata, handles)
% hObject    handle to export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function cp_Callback(hObject, eventdata, handles)
% hObject    handle to cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Savefile,Savepath] = uiputfile('*.mp4','Export the concentration profiles');
if Savefile==0
else
Savefilename=fullfile(Savepath,Savefile);
set(handles.figure1, 'pointer', 'watch')
drawnow;
[ video ] = output_avi( handles.data.i_profiles,handles.data.solution,handles.data.x,handles.data.t,handles.data.potential,handles.data);
v=VideoWriter(Savefilename,'MPEG-4');
open(v);
writeVideo(v,video);
close(v);
set(handles.figure1, 'pointer', 'arrow');
end

% --- Executes on button press in sr_checkbox.
function sr_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to sr_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.data.Ctrl.SurfaceReaction='on';
else
	handles.data.Ctrl.SurfaceReaction='off';
end
set(handles.popupmenu1,'Enable','off')
     set(handles.export,'Enable','off')
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of sr_checkbox


% --------------------------------------------------------------------
function csv_Callback(hObject, eventdata, handles)
% hObject    handle to csv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hChildren = get(handles.axes2,'Children');
 xData1 = get(hChildren(1),'XData');
 yData1 = get(hChildren(1),'YData');
 Data1=zeros(length(xData1),2);
 Data1(:,1)=xData1;
 Data1(:,2)=yData1;
 [Savefile,Savepath] = uiputfile('*.csv','export to csv');
 if Savefile==0
else
 Savefilename=fullfile(Savepath,Savefile);
 csvwrite(Savefilename,Data1);
 end
 


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function select_files_Callback(hObject, eventdata, handles)
% hObject    handle to select_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Openfilename, Openpathname, filterindex] = uigetfile( ...
  '*.csv', ...
   'Select the reverse_plot data', ...
   'MultiSelect', 'on');
if Openpathname==0
else
    cla(handles.axes2)
    axes(handles.axes2);
   
    hold all
     
   
     for i=1:length(Openfilename)
         Openfname=fullfile(Openpathname,Openfilename{i});
         data=csvread(Openfname);
         reverse_plot(data(:,1),data(:,2))
     end
     legend(Openfilename)
     hold off
end
         
     
    


% --- Executes when entered data in editable cell(s) in const_table.
function const_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to const_table (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
TableData=get(handles.const_table,'data');
handles.data.Const.Temperature=TableData{1,2};
handles.data.Const.DiffusionCo=TableData{2,2};
guidata(hObject,handles);


% --------------------------------------------------------------------
function analysis_Callback(hObject, eventdata, handles)
% hObject    handle to analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
about;


% --------------------------------------------------------------------
function pf_Callback(hObject, eventdata, handles)
% hObject    handle to pf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  if strcmp(handles.data.Ctrl.Tech,'CV') && get(handles.popupmenu1,'value')==2 && get(handles. sr_checkbox,'value')==0
      [ ip,Ep,locs ] = EC_findpeaks( handles.data.i_profiles, handles.data.t ,handles.data.potential,handles.data.ElectricalParameters);
       
       axes(handles.axes2);
       hold on
       for i=1:length(ip)
       plot(Ep(i),handles.data.i_profiles(locs(i)),'o')
       str=['Ip= ',num2str(ip(i)),',Ep=',num2str(Ep(i))];
       text(Ep(i)+.02,handles.data.i_profiles(locs(i)),strjoin(str))
       end
       hold off
  else
      set(handles.text1,'String','Peak finding not available')
  end
      
    



% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fitting_Callback(hObject, eventdata, handles)
% hObject    handle to fitting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function import_cv_Callback(hObject, eventdata, handles)
% hObject    handle to import_cv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[Openfilename, Openpathname, filterindex] = uigetfile( ...
  '*.csv', ...
   'Select the reverse_plot data', ...
   'MultiSelect', 'off');
if Openpathname==0
else
    handles.data.Ctrl.Fitting=1;
    Openfname=fullfile(Openpathname,Openfilename);
    EXdata=csvread(Openfname);
    handles.data.ExperimentalData=EXdata;
    axes(handles.axes2);
    reverse_plot(handles.data.ExperimentalData(:,1),handles.data.ExperimentalData(:,2),'o')
    guidata(hObject,handles);    
     
     
end


% --------------------------------------------------------------------
function clear_axes_Callback(hObject, eventdata, handles)
% hObject    handle to clear_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.data.Ctrl.Fitting=0;
guidata(hObject,handles); 



% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
keyboard;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
keyboard;
