clear all,
close all,
clc,

load('CZ_files.mat');
RT      = behav_meta(:,4); prem_RT = behav_meta(:,5);
% find premature and non-premature 
prem_EEG = find(behav_meta(:,5) ~= -999 & behav_meta(:,5) >0);
nonprem_EEG = find(behav_meta(:,5) == -999);
% make response locked
prem     = find(behav_meta(:,5) ~= -999 & behav_meta(:,5) >0);
nonPrem700   = find(behav_meta(:,5) == -999  & behav_meta(:,6) == 700);
nonPrem2100  = find(behav_meta(:,5) == -999  & behav_meta(:,6) == 2100);
nonPrem      = find(behav_meta(:,5) == -999 );
% remove data for responses:


[xx yy] = size(CZ);

for i= 2:xx
    
    if isnan(behav_meta(i,1))
        nan_RT = [];
    else
        if behav_meta(i,5)== -999
            
            nan_RT = 601 + behav_meta(i,4) + behav_meta(i,6);
            CZ(i,nan_RT:end) = 0;
            nan_RT_record(i) = nan_RT;
           % nan_RT = [];
        else
            
            nan_RT = 601 + behav_meta(i,5);
            CZ(i,nan_RT:end) = 0;
            nan_RT_record(i) = nan_RT;
          %  nan_RT = [];
            
        end
        
        
        
    end
end

 













% convert to NaN
 CZ(CZ==0)= NaN;
 
% reverse so plot where RTs end 
  CZ = fliplr(CZ);
 for i =2:length(CZ);
     
 aa = find(~isnan(CZ(i,:)));
 CZ(i,aa) = fliplr(CZ(i,aa));
 
 end
 
 
 


  

plot(nanmean(CZ(prem,end-400:end)),'b');

hold on

for i=1:10000
    
nonPrem_ranPerm = randsample(nonPrem,length(prem));
plot(nanmean(CZ(nonPrem_ranPerm,end-400:end)),'r');

end
 
title '10000 permutation'
 
 
 
 