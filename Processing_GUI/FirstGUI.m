function varargout = FirstGUI(varargin)
% FIRSTGUI MATLAB code for FirstGUI.fig
%      FIRSTGUI, by itself, creates a new FIRSTGUI or raises the existing
%      singleton*.
%
%      H = FIRSTGUI returns the handle to a new FIRSTGUI or the handle to
%      the existing singleton*.
%
%      FIRSTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRSTGUI.M with the given input arguments.
%
%      FIRSTGUI('Property','Value',...) creates a new FIRSTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FirstGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FirstGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FirstGUI

% Last Modified by GUIDE v2.5 24-Mar-2015 11:04:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FirstGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FirstGUI_OutputFcn, ...
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


% --- Executes just before FirstGUI is made visible.
function FirstGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FirstGUI (see VARARGIN)

% Choose default command line output for FirstGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FirstGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FirstGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function first_dat_file_Callback(hObject, eventdata, handles)
% hObject    handle to first_dat_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of first_dat_file as text
%        str2double(get(hObject,'String')) returns contents of first_dat_file as a double



% --- Executes during object creation, after setting all properties.
function first_dat_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to first_dat_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function last_dat_file_Callback(hObject, eventdata, handles)
% hObject    handle to last_dat_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of last_dat_file as text
%        str2double(get(hObject,'String')) returns contents of last_dat_file as a double



% --- Executes during object creation, after setting all properties.
function last_dat_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to last_dat_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sum_squared_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sum_squared_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sum_squared_edit as text
%        str2double(get(hObject,'String')) returns contents of sum_squared_edit as a double



% --- Executes during object creation, after setting all properties.
function sum_squared_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sum_squared_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function best_velocity_edit_Callback(hObject, eventdata, handles)
% hObject    handle to best_velocity_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of best_velocity_edit as text
%        str2double(get(hObject,'String')) returns contents of best_velocity_edit as a double


% --- Executes during object creation, after setting all properties.
function best_velocity_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to best_velocity_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in do_it.
function do_it_Callback(hObject, eventdata, handles)
% hObject    handle to do_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get user input from GUI
startNum = str2double(get(handles.first_dat_file,'String'));
endNum = str2double(get(handles.last_dat_file,'String'));
size = str2double(get(handles.radius_edit,'String'));
distance = str2double(get(handles.distance_edit,'String'));

% Calculate the appropriate data using the model code (note the 450
% time data points corresponds to the number of non-negative time 
% points are on the DAT files from the PMT traces)
timeNums = 450;
times = 0:0.000001:0.000449;
labData = getDataFromFiles(startNum,endNum);
bestFitDataRaw = calcFit(labData,size,distance);
bestFitData = zeros(timeNums);
bestVelocity = bestFitDataRaw(451);
sumSquared = bestFitDataRaw(452);
for k=1:450
    bestFitData(k) = bestFitDataRaw(k);
end

% Create the original data plot
plot(handles.normalized_summed_data_plot,times*10^6,labData,'LineWidth',2);
title(handles.normalized_summed_data_plot, 'Lab Data: Negative Bias Normalized PMT Voltage vs. Time');
ylabel(handles.normalized_summed_data_plot, 'Normalized Voltage (Unitless)');
xlabel(handles.normalized_summed_data_plot, 'Time (s)');
set(handles.normalized_summed_data_plot,'XGrid','on','XMinorGrid','on');

% Create the best fit plot
plot(handles.normalized_fit_plot,times*10^6,bestFitData,'LineWidth',2);
title(handles.normalized_fit_plot, 'Fit Data: Negative Bias Normalized PMT Voltage vs. Time');
ylabel(handles.normalized_fit_plot, 'Normalized Voltage (Unitless)');
xlabel(handles.normalized_fit_plot, 'Time (\mus)');
set(handles.normalized_fit_plot,'XGrid','on','XMinorGrid','on');

% Create the superimposed plots
plot(handles.superimposed_plot,times*10^6,labData,times*10^6,bestFitData,'LineWidth',2);
title(handles.superimposed_plot, 'Lab & Fit Data: Negative Bias Normalized PMT Voltage vs. Time');
ylabel(handles.superimposed_plot, 'Normalized Voltage (Unitless)');
xlabel(handles.superimposed_plot, 'Time (\mus)');
legend(handles.superimposed_plot, 'Lab Data Curve', 'Zero', 'Fit Data Curve','Location','SouthEast');
set(handles.superimposed_plot,'XGrid','on','XMinorGrid','on');

% Set the output strings of the best velocity and sum squared error
set(handles.best_velocity_edit,'String',num2str(bestVelocity));
set(handles.sum_squared_edit,'String',num2str(sumSquared));



function radius_edit_Callback(hObject, eventdata, handles)
% hObject    handle to radius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius_edit as text
%        str2double(get(hObject,'String')) returns contents of radius_edit as a double


% --- Executes during object creation, after setting all properties.
function radius_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function distance_edit_Callback(hObject, eventdata, handles)
% hObject    handle to distance_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distance_edit as text
%        str2double(get(hObject,'String')) returns contents of distance_edit as a double



% --- Executes during object creation, after setting all properties.
function distance_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distance_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function save_menu_item_Callback(hObject, eventdata, handles)
% hObject    handle to save_menu_item (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function save_data_Callback(hObject, eventdata, handles)
% hObject    handle to save_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = strcat(get(handles.normalized_data_edit,'String'),get(handles.extension_edit,'String'));
export_fig(handles.normalized_summed_data_plot,filename);



% --------------------------------------------------------------------
function save_sim_Callback(hObject, eventdata, handles)
% hObject    handle to save_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = strcat(get(handles.normalized_fit_edit,'String'),get(handles.extension_edit,'String'));
export_fig(handles.normalized_fit_plot,filename);



% --------------------------------------------------------------------
function save_superposed_Callback(hObject, eventdata, handles)
% hObject    handle to save_superposed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = strcat(get(handles.superposed_edit,'String'),get(handles.extension_edit,'String'));
export_fig(handles.superimposed_plot,filename);



function normalized_data_edit_Callback(hObject, eventdata, handles)
% hObject    handle to normalized_data_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of normalized_data_edit as text
%        str2double(get(hObject,'String')) returns contents of normalized_data_edit as a double


% --- Executes during object creation, after setting all properties.
function normalized_data_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to normalized_data_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function normalized_fit_edit_Callback(hObject, eventdata, handles)
% hObject    handle to normalized_fit_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of normalized_fit_edit as text
%        str2double(get(hObject,'String')) returns contents of normalized_fit_edit as a double


% --- Executes during object creation, after setting all properties.
function normalized_fit_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to normalized_fit_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function superposed_edit_Callback(hObject, eventdata, handles)
% hObject    handle to superposed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of superposed_edit as text
%        str2double(get(hObject,'String')) returns contents of superposed_edit as a double


% --- Executes during object creation, after setting all properties.
function superposed_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to superposed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function extension_edit_Callback(hObject, eventdata, handles)
% hObject    handle to extension_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of extension_edit as text
%        str2double(get(hObject,'String')) returns contents of extension_edit as a double


% --- Executes during object creation, after setting all properties.
function extension_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to extension_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function make_figure_Callback(hObject, eventdata, handles)
% hObject    handle to make_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function data_plot_figure_Callback(hObject, eventdata, handles)
% hObject    handle to data_plot_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure()

% Get user input from GUI
startNum = str2double(get(handles.first_dat_file,'String'));
endNum = str2double(get(handles.last_dat_file,'String'));

% Calculate the appropriate data using the model code (note the 450
% time data points corresponds to the number of non-negative time 
% points are on the DAT files from the PMT traces)
times = 0:0.000001:0.000449;
labData = getDataFromFiles(startNum,endNum);

% Create the original data plot
plot(times,labData);


% --------------------------------------------------------------------
function save_gui_Callback(hObject, eventdata, handles)
% hObject    handle to save_gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
export_fig(gcf,'RunningGUI.jpg');