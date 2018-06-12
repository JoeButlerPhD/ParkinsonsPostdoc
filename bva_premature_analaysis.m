
clear all,
close all,
clc
  
files = dir('*.mat');







for i = 1:length(files);  

load(files(i).name);
 
%
% clear noisy trials selected in BVA; select find good trials
meta2100(fp2100bad_trials,:) = 0;
erp2100 = find(meta2100(:,5)~= -999 & meta2100(:,5)~=0);   

%
% add reaction times to S2 in case of premature trials.
% find S2 trials
% clear noisy trials selected in BVA; select find good trials
%
meta700(fp700bad_trials,:) = 0;
erp700 = find(meta700(:,5)~= -999 & meta700(:,5)~=0);


meta700(fp700bad_trials,:) = nan;
meta2100(fp2100bad_trials,:) = nan;




match = reshape(strcmp({fp700.Markers.Description}, 's2'), size(fp700.Markers));
s2Times_700 =(fp700.Markers(match));
match=[];

match = reshape(strcmp({fp2100.Markers.Description}, 's2'), size(fp2100.Markers));
s2Times_2100 =(fp2100.Markers(match));
match=[]; 


if i ==1


[x_size y_size] = size(fp2100.CZ);
CZ(1,1:y_size) = nan;
behav_meta(1,1:13) = nan;

cz700_holder(x_size,y_size) = nan;
    
end

cz700_holder(1:210,1:2900)   = fp700.CZ;
cz2100_holder                = fp2100.CZ;

cz_all = [cz700_holder; cz2100_holder]
CZ = [CZ; cz_all];


                  
behavioural = [meta700;meta2100];
behavioural(:,end+1) = i;
   
behav_meta = [behav_meta;behavioural];

end



