function [solution,i_profiles]=solver_ECatalysis(ReactionParameters,ElectricalParameters,Ctrl,Const,x,t)
    m = 0;
     options = odeset('AbsTol',Const.AbsTol);
   solution = pdepe(m,@pdex4pde,@pdex4ic,@pdex4bc,x,t,options);
    % i_profiles
    sizes=size(solution);
    for i=1:sizes(1)
   [u0(i) ,derivitive(i)]=pdeval(0,x,solution(i,:,1),0);
    end
%Faraday current
i_profiles=-ReactionParameters.n*Const.Faraday*Const.DiffusionCo*derivitive;
   function [c,f,s] = pdex4pde(x,t,u,DuDx)
   c = ones(3,1);
   f = Const.DiffusionCo*ones(3,1).*DuDx;
   s = [ReactionParameters.k_ECata*u(2)*u(3);-ReactionParameters.k_ECata*u(2)*u(3);-ReactionParameters.k_ECata*u(2)*u(3)];
   end
   function u0 = pdex4ic(x)
  u0 = [ReactionParameters.Concentration_Re_mmolPerLiter; ReactionParameters.Concentration_Ox_mmolPerLiter;ReactionParameters.Y_mmolPerLiter]; 
% --------------------------------------------------------------
   end
   function [pl,ql,pr,qr] = pdex4bc(xl,ul,xr,ur,t)
% constants and variables
 % over potential
 eta=PotentialGeneration(Ctrl,ElectricalParameters,t)-ReactionParameters.E0_V;
  pl = [ReactionParameters.k0*(ul(1)*exp(ReactionParameters.n*Const.Faraday*.5*eta/(Const.R*Const.Temperature))-ul(2)*exp(-ReactionParameters.n*Const.Faraday*.5*eta/(Const.R*Const.Temperature)));ReactionParameters.k0*(ul(1)*exp(ReactionParameters.n*Const.Faraday*.5*eta/(Const.R*Const.Temperature))-ul(2)*exp(-ReactionParameters.n*Const.Faraday*.5*eta/(Const.R*Const.Temperature)));0]; 
  ql = [-1;1; 1]; 
  pr=[0;0;0];
  qr=[1;1;1];
%   pr = [ur(1)-ReactionParameters.Concentration_Re_mmolPerLiter;ur(2)-ReactionParameters.Concentration_Ox_mmolPerLiter;ur(3)-ReactionParameters.Y_mmolPerLiter ]; 
%   qr = [0; 0;0];
   end


end
 

