clear all, close all, clc

%%      load in brain vision data
'select the brain vision analyser 700 matlab file'
fp700 = uiimport
fp_check = 0;
while fp_check == 0;
 fp_check  =   exist('fp700','var') ;
end
%%      load in brain vision data
'select the brain vision analyser 2100 matlab file'
fp2100 = uiimport
fp_check = 0;
while fp_check == 0;
 fp_check  =   exist('fp2100','var') ;
end
% 'select the data file'
BehaviouralData = uiimport;
data_check = 0;
while data_check ~= 1;
 data_check  =   exist('BehaviouralData','var') ;
end
fullData = BehaviouralData.fullData;

% %         create meta of foreperiods 700/2100
[a_700 b_700] = find(fullData(:,6) ==700);
meta700 = fullData(a_700,:);
%
[a_2100 b_2100] = find(fullData(:,6) == 2100);
meta2100 = fullData(a_2100,:);

% find bad trials
match = reshape(strcmp({fp2100.Markers.Type}, 'Bad Interval'), size(fp2100.Markers))
% bad_interval_marker = vertcat(fp2100.Markers(match).Type)
[fp2100bad_trials bb] = find(match == 1)
bb = []

match = reshape(strcmp({fp700.Markers.Type}, 'Bad Interval'), size(fp700.Markers))
% bad_interval_marker = vertcat(fp2100.Markers(match).Type)
[fp700bad_trials bb] = find(match == 1)
bb = []





 
