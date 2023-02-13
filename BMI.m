function varargout = BMI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BMI_OpeningFcn, ...
                   'gui_OutputFcn',  @BMI_OutputFcn, ...
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



function BMI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

handles.metric = 0;
handles.wu = 'lb';
handles.hu = 'in';
handles.name = '';
handles.age = '';
handles.bmi = 0;
handles.weight = '';
handles.height = '';
handles.result = '';
handles.condition = ''; 

guidata(hObject, handles);



function varargout = BMI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function EditText_Name_Callback(hObject, eventdata, handles)
handles.name = get(hObject,'String');
guidata(hObject, handles); 



function EditText_Name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function EditText_Age_Callback(hObject, eventdata, handles)
handles.age = get(hObject,'String');
guidata(hObject, handles);

function EditText_Age_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function anglo_radio_Callback(hObject, eventdata, handles)
handles.anglo = get(hObject,'Value');
set(handles.weight_label, 'String', 'Weight (lb):')
set(handles.height_label, 'String', 'Height (in):')
set(handles.metric_radio, 'Value', 0)
handles.metric = 0;
handles.wu = 'lb';
handles.hu = 'in';
guidata(hObject, handles);

function metric_radio_Callback(hObject, eventdata, handles)
handles.metric = get(hObject,'Value');
set(handles.weight_label, 'String', 'Weight (kg):')
set(handles.height_label, 'String', 'Height (cm):')
set(handles.anglo_radio, 'Value', 0)
handles.anglo = 0;
handles.wu = 'kg';
handles.hu = 'cm';
guidata(hObject, handles);

function weight_text_Callback(hObject, eventdata, handles)
num = str2double(get(hObject,'String'));
if isnan(num)
    set(hObject,'String', 0);
end
handles.weight = num;
guidata(hObject, handles);

function weight_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function height_text_Callback(hObject, eventdata, handles)
num = str2double(get(hObject,'String'));
if isnan(num)
    set(hObject,'String', 0);
end
handles.height = num;
guidata(hObject, handles);


function height_text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Calculate_Button_Callback(hObject, eventdata, handles)
if handles.metric
    w = handles.weight;
    h = handles.height;
else
    w = handles.weight/2.2046;
    h = handles.height/0.3937;
end

bmi = 1e4 * w/h^2;

if bmi < 18.5
    s = ' Underweight';
elseif 18.5 <= bmi & bmi < 25
    s = ' Normal';
elseif 25 <= bmi & bmi < 30
    s = ' Overweight';
else
    s = ' Obese';
end   

bmis = [num2str(bmi, 3) s]; 
set(handles.result_text, 'String', bmis);
handles.result = bmi;
handles.condition = s;
guidata(hObject,handles);

function Clear_Button_Callback(hObject, eventdata, handles)
set(handles.EditText_Name, 'String', '')
handles.name = '';
set(handles.EditText_Age, 'String', '')
handles.age = '';
set(handles.weight_text, 'String', '0')
handles.weight = 0;
set(handles.height_text, 'String', '0')
handles.height = 0;
set(handles.result_text, 'String', '')
handles.result = 0;
handles.condition = '';
