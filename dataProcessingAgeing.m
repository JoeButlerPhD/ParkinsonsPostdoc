% load data
 

%  find repeat RT; find premature;

for i = 1:length(RT)
    
  if RT(i) == RT(i-1)   
     no_response(i) == 1;
  else
     no_response(i) == 0;  
  end
   
end

%  for each subject, find average electrode x current fp x time point.

for iSub = 1:(sub)

  dataInd =  find( ub == iSub & RT < 1000 & RT > 100)
    

  % Fz
  Fz_2100_700_late    = mean(Fp_late_2100_700)
  Fz_2100_2100_late = mean(Fp_late_2100_2100)
  
  Fz_2100_700_early   = mean(Fp_late_2100_700)
  Fz_2100_2100_early = mean(Fp_late_2100_2100)
    
  Fz_700_700          = mean(Fp_late_2100_700)
  Fz_700_2100         = mean(Fp_late_2100_700)

  % Cz
  Cz_2100_700_late  = mean(Fp_late_2100_700)
  Cz_2100_2100_late = mean(Fp_late_2100_700)
  
  Cz_2100_700_early  = mean(Fp_late_2100_700)
  Cz_2100_2100_early = mean(Fp_late_2100_2100)
    
  Cz_700_700 = mean(Fp_late_2100_700)
  Cz_700_2100 = mean(Fp_late_2100_700)
  
  
  % Pz
  Pz_2100_700_late  = mean(Fp_late_2100_700)
  Pz_2100_2100_late = mean(Fp_late_2100_2100)
  
  Pz_2100_700_early
  Pz_2100_2100_early = mean(Fp_late_2100_2100)
    
  Cz_700_700        = mean(Fp_late_2100_700)
  Cz_700_2100       = mean(Fp_late_2100_2100)

end



