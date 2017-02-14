function  overlap_cv( data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
  if data.Ctrl.Fitting==0
      plot(data.potential,data.i_profiles)
      set(gca,'xDir','reverse');
  else
      
      reverse_plot(data.potential,data.i_profiles)
      hold on
      reverse_plot(data.ExperimentalData(:,1),data.ExperimentalData(:,2),'o')
      hold off
  end
      

end

