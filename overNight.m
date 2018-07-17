clear all, close all, clc

global files


%load files

files = dir('*.asc');

for i = 1:length(files);
    
    
    fileName = files(i).name;
    
    [EyeData, foreperiod] =  extractPupil_gold(fileName);
    
    filename1 = [files(i).name, 'EyeData', '.mat'];
    filename2 = [files(i).name, 'foreperiod', '.mat'];  
    
    
    save(filename1,'EyeData')

    save(filename2,'foreperiod')
    
end

