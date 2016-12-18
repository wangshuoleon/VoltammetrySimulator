function [solution,i_profiles]=solver_ECE(ReactionParameters,ElectricalParameters,Ctrl,Const,x,t)
    m = 0;
     options = odeset('AbsTol',Const.AbsTol);
   solution = pdepe(m,@pdex4pde,@pdex4ic,@pdex4bc,x,t,options);
    % i_profiles
    sizes=size(solution);
    for i=1:sizes(1)
   [u0(i) ,derivitive(i)]=pdeval(0,x,solution(i,:,1),0);
   [u0(i),derivitive2(i)]=pdeval(0,x,solution(i,:,3),0);
    end
%Faraday current
i_profiles=Const.Faraday*Const.DiffusionCo*(derivitive+derivitive2);
   function [c,f,s] = pdex4pde(x,t,u,DuDx)
   c = ones(4,1);
   f = Const.DiffusionCo*ones(4,1).*DuDx;
   s = [0;-ReactionParameters.k_C*u(2);ReactionParameters.k_C*u(2);0];
   end
   function u0 = pdex4ic(x)
  u0 = [ReactionParameters.Concentration_Re_mmolPerLiter; ReactionParameters.Concentration_Ox_mmolPerLiter;0;0]; 
% --------------------------------------------------------------
   end
   function [pl,ql,pr,qr] = pdex4bc(xl,ul,xr,ur,t)
% constants and variables
 % over potential
 eta1=PotentialGeneration(Ctrl,ElectricalParameters,t)-ReactionParameters.E1_V;
 eta2=PotentialGeneration(Ctrl,ElectricalParameters,t)-ReactionParameters.E2_V;
  pl = [ReactionParameters.k1*(ul(1)*exp(Const.Faraday*.5*eta1/(Const.R*Const.Temperature))-ul(2)*exp(-Const.Faraday*.5*eta1/(Const.R*Const.Temperature)));ReactionParameters.k1*(ul(1)*exp(Const.Faraday*.5*eta1/(Const.R*Const.Temperature))-ul(2)*exp(-Const.Faraday*.5*eta1/(Const.R*Const.Temperature)));ReactionParameters.k2*(ul(3)*exp(Const.Faraday*.5*eta2/(Const.R*Const.Temperature))-ul(4)*exp(-Const.Faraday*.5*eta2/(Const.R*Const.Temperature)));ReactionParameters.k2*(ul(3)*exp(Const.Faraday*.5*eta2/(Const.R*Const.Temperature))-ul(4)*exp(-Const.Faraday*.5*eta2/(Const.R*Const.Temperature)))]; 
  ql = [-1;1; -1;1]; 
  pr=[0;0;0;0];
  qr=[1;1;1;1];
%   pr = [ur(1)-ReactionParameters.Concentration_Re_mmolPerLiter;ur(2)-ReactionParameters.Concentration_Ox_mmolPerLiter;ur(3);ur(4)]; 
%   qr = [0; 0;0;0];
   end


end
 

