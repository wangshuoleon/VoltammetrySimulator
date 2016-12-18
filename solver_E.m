function [solution,i_profiles]=solver_E(ReactionParameters,ElectricalParameters,Ctrl,Const,x,t)
   m = 0;
   options = odeset('AbsTol',Const.AbsTol);
   solution = pdepe(m,@pdex4pde,@pdex4ic,@pdex4bc,x,t,options);
   % i_profiles
   sizes=size(solution);
   for i=1:sizes(1)
   [u0(i) ,derivitive(i)]=pdeval(0,x,solution(i,:,1),0);
    end
%Faraday current
i_profiles=Const.Faraday*Const.DiffusionCo*derivitive;
   function [c,f,s] = pdex4pde(x,t,u,DuDx)
   c = ones(2,1);
   f = Const.DiffusionCo*ones(2,1).*DuDx;
   s = zeros(2,1);
   end
   function u0 = pdex4ic(x)
  u0 = [ReactionParameters.Concentration_Re_mmolPerLiter; ReactionParameters.Concentration_Ox_mmolPerLiter]; 
% --------------------------------------------------------------
   end
   function [pl,ql,pr,qr] = pdex4bc(xl,ul,xr,ur,t)
% constants and variables
 % over potential
 eta=PotentialGeneration(Ctrl,ElectricalParameters,t)-ReactionParameters.E0_V;
  pl = ones(2,1)*ReactionParameters.k0_MeterPerSec*(ul(1)*exp(Const.Faraday*.5*eta/(Const.R*Const.Temperature))-ul(2)*exp(-Const.Faraday*.5*eta/(Const.R*Const.Temperature))); 
  ql = [-1; 1]; 
  pr=[0;0];
  qr=[1;1];
  % pr = [ur(1)-ReactionParameters.Concentration_Re_mmolPerLiter;ur(2)-ReactionParameters.Concentration_Ox_mmolPerLiter ]; 
  %qr = [0; 0];
   end
end
 