function [solution,i_profiles]=solver(ReactionParameters,ElectricalParameters,Ctrl,Const,x,t,potential)
 switch Ctrl.Mechanism
     case 'E'
         [solution,i_profiles]=solver_E(ReactionParameters,ElectricalParameters,Ctrl,Const,x,t);
     case 'EC'
         [solution,i_profiles]=solver_EC(ReactionParameters,ElectricalParameters,Ctrl,Const,x,t);
     case 'ECE'
         [solution,i_profiles]=solver_ECE(ReactionParameters,ElectricalParameters,Ctrl,Const,x,t);
     case 'ECatalysis'
         [solution,i_profiles]=solver_ECatalysis(ReactionParameters,ElectricalParameters,Ctrl,Const,x,t);
 end
 
 


end

