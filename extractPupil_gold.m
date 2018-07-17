% Latest version
% fixed a bug where large pupil sizes changed white space formaing,
% and led to data not being parsed from text-file 

% script to collect pupilometry data
%  matrix will look like this
% column one    - linux time
% column two    - eye x position
% column three  - eye y position
% column four   - t.
% column five   -
% column six    -
% foreperiods variable = list of stored variables.

% messages contained with the file are  (trial 1)
% START	112715 	RIGHT	SAMPLES	EVENTS - trial start messag
% MSG	112747 SET_TTL_0   - display initial fixation
% MSG	112753 -7 DISPLAY_FIXATION  - di
% MSG	112761 SET_TTL_01
% MSG	113065 -4 DISPLAY_FIXATION_TARGET
% MSG	113071 SET_TTL_02
% MSG	113103 -7 DISPLAY_FIXATION_NO_TARGET
% MSG	114562 -8 DISPLAY_TARGET
% MSG	114571 SET_TTL_16
% MSG	114582 -8 DISPLAY_TARGET_END
% MSG	115590 0 TARGET_OFF_PLUS_2000
% MSG	115601 SET_TTL_32
% MSG	115632 -8 TRIAL_END
% MSG	115641 SET_TTL_128

% trial 2 (to see iti Fixation).

% MSG	119978 SET_TTL_0
% MSG	119982 -8 DISPLAY_FIXATION - likely this can be isi period.
% MSG	121962 -8 DISPLAY_FIXATION - show fixation square
% MSG	121971 SET_TTL_01 ^ ttl for above
% MSG	122275 -5 DISPLAY_FIXATION_TARGET  - warning target.
% MSG	122281 SET_TTL_02 ^ ttl for above.
% MSG	122312 -8 DISPLAY_FIXATION_NO_TARGET - warning target disapear
% MSG	122772 -8 DISPLAY_TARGET - show imperitive target.
% MSG	122781 SET_TTL_16
% MSG	122792 -8 DISPLAY_TARGET_END - imperitive target disapear
% MSG	123801 0 TARGET_OFF_PLUS_2000
% MSG	123842 -8 TRIAL_END
% MSG	123851 SET_TTL_128


function [new_matrix, foreperiod] = extractPupil_gold(fileName)
file = fileName;

content=textread(fileName,'%s','delimiter','\n','whitespace','');




%   fid = fopen(file,'r+') % open a file
new_matrix = zeros(length(content),9); %this is where we save the data to.
foreperiod   = [];  
d=1; % index matrix
open_gate = 0;
trial = 0;

% this function goes through the ASC file and collates the pupilometry
% data line by line.
% due to the layout of the text/asc files, this is

% next we collate a list of events.

fp = 1; % this is foreperiod index

% w_Target = 0; % warning target
% i_Target = 0; % imperitive target

fixation_target   = 0; % if closed (==0), variable is not written
fixation_period   = 0; % if closed (==0), variable is not written
imperative_target = 0; % if closed (==0), variable is not written
isi_period        = 0; % if closed (==0), variable is not written

for i = 1:length(content);
    
    tline = content{i};
    if isempty(tline) == 0; % check tline (variable interested in) is not empty.
        
        if tline(1) == 'S' && tline(2) == 'T'; % START
            open_gate = 1; % means routine can be opened to save trial shiz.
            trial = trial+1; %trial number is coded in the matrix
            
            % for start trial
            fixation_period      = 0;
            isi_period           = 0;
            fixation_target      = 0;
            imperative_target    = 0;
            
            % stop_recording_data into matrix
        elseif tline(1) == 'E' && tline(2) == 'N'; % END
            open_gate = 0; % close the gate and ignore stuff between trials.
        end
        
        % collate foreperiod times
        
        if strfind(tline, 'target_delay 1100')
            foreperiod(fp) = 1100; fp = fp+1;
            
        elseif strfind(tline, 'target_delay 2500')
            foreperiod(fp) = 2500; fp = fp+1;
            
        end
        
        if strfind(tline, 'MSG')
            tline_a = regexp(tline, ' +', 'split'); %split line into struct
            
            
            % display_fixation_target
            
            % after warning target fixation period
            if strfind(tline, 'period_display_fixation_point')
                fixation_period         = 1;
                
                isi_period                   = 0;
                fixation_target          = 0;
                imperative_target    = 0;
            end
            
            % isi period
            %
            %
          if strcmpi(tline_a(2), 'period_s1')
                tline = strtrim(tline); % this doesn't do anything?
                isi_period                  = 1;
                 
                fixation_target          = 0;
                fixation_period         = 0;
                imperative_target    = 0;
          end
          
          
             if strcmpi(tline_a(2), 'period_premature');
                tline = strtrim(tline); % this doesn't do anything?
                isi_period                  = 2;
                 
                fixation_target          = 0;
                fixation_period         = 0;
                imperative_target    = 0;
             end
            
            
            
          
          
          
          
          
          
            % imperative target period
            %
            %
            
            if strcmpi(tline_a(2), 'period_s2')
                imperative_target = 1;
                
                isi_period = 0;
                fixation_period = 0;
                fixation_target = 0;
            end
            
            
        end
        if open_gate ==1; % checks inline belongs between a trial
            a = str2double(tline(1)); % convert firt char to a number
            if isnumeric(a); % is this number a number?
                if isnan(a) == 0; % 1 is numeric, and 2 is not NaN?
            
                    tline  = regexp(tline,'\s+','split'); % replaced voodoo.
                  %  tline = regexp(tline, '  +', 'split'); %split line into struct
                    tline = strtrim(tline); % remove white space from each string
                    [aa bb] = size(tline); % check items in struct (x y of file)
                    if bb >= 4 % if 4, means is time, x,y,pupil size.
                       
                        
                        for i = 1:4
                                   
                           if tline{i}== '.';
                                new_matrix(d,i) = -9; % write lost signal',' as -9.
                            else
                                new_matrix(d,i) = str2num(strtok(tline{i})) ;%otherwise, write value.
                       
                         end  % write trial number in col 5.
                        end,  new_matrix(d,5) = trial;...
                            new_matrix(d,6) = fixation_period ;...
                            new_matrix(d,7) = fixation_target; ...
                            new_matrix(d,8) = imperative_target; ...
                            new_matrix(d,9) = isi_period; ...
                            d=d+1; %lengthen matrix index by 1.
                           'still working';
                    end
                end
            end
        end
    end
    
    
    if  isnumeric(tline)==1 & tline == -1 % if there are no more lines to read in the file,
        break % program closes.
    end
end


