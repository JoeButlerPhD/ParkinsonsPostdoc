clear all, close all, home

i = 1;
files = dir('*.txt');



for i = 1:length(files);

data                 = importdata(files(i).name);
prem                 = data.textdata(2:end,7);
not_Prem             = find(strcmp(prem,'False'));
prem                 = find(strcmp(prem,'True'));
premRT = zeros(60,1); premRT(not_Prem,1) = 1;

amplitude = data.data(:,1);
peak_velocity        = data.data(:,2);
average_velocity     = data.data(:,3);
duration = data.data(:,4);

prematureRT          = str2double(data.textdata(2:end,13));

Foreperiod           = str2double(data.textdata(2:end,6));
prevForeperiod       = circshift(Foreperiod,1);
prevForeperiod(1,1)  = 999;



targetLocation       = str2double(data.textdata(2:end,9));
latencies            = str2double(data.textdata(2:end,11));
block = targetLocation; block(:) = i;

data = [block,       targetLocation,    premRT,...
        latencies, prematureRT,   Foreperiod, prevForeperiod,   amplitude, ...
        peak_velocity, average_velocity,  duration, ];    
if i == 1
    fullData = data;    
else    
    fullData = [fullData; data];
end

end

fullData(:,12) = 1:length(fullData);

save FullData fullData;

clear all,close all, clc









































































































































































%   recip_latencies = 1000/Latencies;

%
%
%

%   FP500  = find(Foreperiod == 500   & Latencies > 100 & Latencies < 600);
%   FP1500 = find(Foreperiod == 1500 & Latencies > 100 & Latencies < 600);

%   FP500_pFP1500  = find(Foreperiod == 500 & prev_Foreperiod ==1500 & Latencies >100 & Latencies <600);
%   FP500_pFP500   = find(Foreperiod == 500 & prev_Foreperiod ==500  & Latencies >100 & Latencies <600);

%   FP1500_pFP500  = find(Foreperiod == 1500 & prev_Foreperiod ==500 & Latencies >100 & Latencies <600);
%   FP1500_pFP1500 = find(Foreperiod == 1500 & prev_Foreperiod ==1500 &

%   Latencies >100 & Latencies <600);

%   same_          = find(Foreperiod ==  prev_Foreperiod  & Latencies >100 & Latencies <600);
%   different_     = find(Foreperiod ~=  prev_Foreperiod  & Latencies >100 & Latencies <600);

%   figure
%   hold on

 

% subplot(2,2,1)
% qq1 = plot(Latencies(FP500),20)
% title('fp500')
% ylim([0 30])

% subplot(2,2,2)
% qq2 = hist(Latencies(FP500_pFP1500),10);
% title('fp500,pFP1500')
% ylim([0 30])
% xlim([0 15])
 
 
% subplot(2,2,3)
% qq3 = hist(Latencies(FP500_pFP500),20);
% title('fp500,pfp500')
% ylim([0 30])
% xlim([0 15])
 
 
% subplot(2,2,4)
% qq3 = qqplot(Latencies(FP1500_pFP500);
 

% figure 
% hold on

% subplot(2,2,1)
% qq1 = hist(Latencies(FP1500),20)
% title('fp1500')
% ylim([0 700])
% xlim([0 ])
 
 
% subplot(2,2,2)
% qq2 = hist(Latencies(FP1500_pFP1500),20);
% title('fp1500,pFP1500')
% ylim([0 30])
% xlim([0 15])
  
% subplot(2,2,3)
% qq3 = hist(Latencies(FP1500_pFP500),20);
% title('fp1500,pfp500')
% ylim([0 30])
 % xlim([0 15])

% figure 
% hold on

% subplot(2,2,1)
% qq1 = hist(Latencies(same_),20)
% title('same_')
% ylim([0 30])
% xlim([0 15])
 
 
% subplot(2,2,2)
% qq2 = hist(Latencies(different_),20);
% title('different_')
% ylim([0 30])
% xlim([0 15])

 
 
 
%

% FP500_mean = mean(Latencies(FP500));
% FP1500_mean = mean(Latencies(FP1500));

% FP500_pFP500_mean = mean(Latencies(FP500_pFP500))
% FP500_pFP1500_mean = mean(Latencies(FP500_pFP1500))

% FP1500_pFP500_mean = mean(Latencies(FP1500_pFP500))
% FP1500_pFP1500_mean = mean(Latencies(FP1500_pFP1500))
 

%  same_mean = mean(Latencies(same_))
%  different_mean = mean(Latencies(different_))



%% current
% delays = [500,1500];
% rt_mean = [FP500_mean,FP1500_mean]
% std_current(1,1) = std(Latencies(FP500));
% std_current(1,2) = std(Latencies(FP1500));

% figure; 
% subplot(1,2,1)
% scatter(delays,rt_mean)

%  errorbar(delays, rt_mean, std_current);

%  axis([400 1600 80 600])
%  xlabel('foreperiod')
%  ylabel('mean RT')
%  legend off



%% history

%  subplot(1,2,2)
% (/1,2) = std(Latencies(FP500_pFP1500));
 
% errorbar(delays,previous_rt_mean500, previous_STD_mean500);

% axis([400 1600 80 600])


% xlabel('previous foreperiod (current fp500)')
% ylabel('mean RT')
% legend off



% figure

% subplot(2,2,1); hist(Latencies(FP500),20)
% xlabel('FP500')
% axis([0 600 0 150])


% subplot(2,2,2); hist(Latencies(FP1500),20)
% xlabel('FP1500')
% axis([0 600 0 150])


%% t-test
 
%[h p ci stats] = ttest2(Latencies(FP500_pFP500),Latencies(FP500_pFP1500))
 
 
 
 