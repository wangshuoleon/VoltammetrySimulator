function [ potential ] = PotentialGeneration( Ctrl ,ElectricalParameters,t)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
switch Ctrl.Tech
    case 'CV'
        potential=sawtooth(t*pi/abs(ElectricalParameters.SwitchingPotential_V-ElectricalParameters.StartPotential_V)*ElectricalParameters.ScanRate_V_per_sec,.5)*(ElectricalParameters.SwitchingPotential_V-ElectricalParameters.StartPotential_V)/2+(ElectricalParameters.SwitchingPotential_V+ElectricalParameters.StartPotential_V)/2;
    case 'CA'
        potential=zeros(length(t),1);
        for i=1:length(t)
        if t(i)<=ElectricalParameters.FirstStepTime_s
            potential(i)=ElectricalParameters.FirstPotential_V;
        else 
          
            if t(i)<ElectricalParameters.FirstStepTime_s+ElectricalParameters.StepWidth_s
                potential(i)=ElectricalParameters.FirstPotential_V+(ElectricalParameters.SecondPotential_V-ElectricalParameters.FirstPotential_V)/ElectricalParameters.StepWidth_s*(t(i)-ElectricalParameters.FirstStepTime_s);
            else
                potential(i)=ElectricalParameters.SecondPotential_V;
            end
        end
        end
end

end

