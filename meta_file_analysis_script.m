%
%
%
%

% trial house keeping 

prem = find(behav_meta(:,5)~=999);
RT   = behav_meta(:,4);
fp   = behav_meta(:,6);
fp_1 = behav_meta(:,7);
[xx yy] = size(CZ);

%
% add reaction times
%

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

 
 CZ(CZ==0) = NaN;
% 
% %
% % reverse data file, add nans
% %
% 
  CZ = fliplr(CZ); 
  i=[];
 for i = 1:xx
 
 aa = find(~isnan(CZ(i,:)));
 CZ(i,aa) = fliplr(CZ(i,aa));
 
 end
 


% 
% 
% aa = find(fp == 700);
% 
%  plot(nanmean(CZ(aa,:)));
%  
% hold on
% 
% aa = [];
% aa = find(fp ==2100);
% plot(nanmean(CZ(aa,:)));
%  

prem_EEG = find(behav_meta(:,5) ~=999);
nonprem_EEG = find(behav_meta(:,5) ==999);

plot(CZ(nonprem_EEG,end-400:end);



% add the code to match on the basis of reaction time.
% random sample the same number of trials.













