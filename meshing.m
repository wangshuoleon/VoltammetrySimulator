function [ x,t] = meshing(ElectricalParameters, Ctrl,Const)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 switch Ctrl.Tech
     case 'CV'
       Length=6*sqrt(2*abs(ElectricalParameters.StartPotential_V-ElectricalParameters.SwitchingPotential_V)/ElectricalParameters.ScanRate_V_per_sec*Const.DiffusionCo);
       x1= linspace(0,Length/30,30);
       x2=linspace(1.1/30*Length,Length,30);
       x=[x1,x2];
       % 100 points for each cycle plot
       t = linspace(0,abs(ElectricalParameters.StartPotential_V-ElectricalParameters.SwitchingPotential_V)/ElectricalParameters.ScanRate_V_per_sec*ElectricalParameters.NumberOfScans*2,200*ElectricalParameters.NumberOfScans*abs(ElectricalParameters.StartPotential_V-ElectricalParameters.SwitchingPotential_V));
     case 'CA'
       Length=6*sqrt(2*abs(max(ElectricalParameters.FirstStepTime_s,ElectricalParameters.SecondStepTime_s))*Const.DiffusionCo);
        x1= linspace(0,Length/100,100);
       x2=linspace(2/100*Length,Length,30);
       x=[x1,x2];
       t1=linspace(0,ElectricalParameters.FirstStepTime_s,100);
       t2=linspace(ElectricalParameters.FirstStepTime_s*1.01,ElectricalParameters.SecondStepTime_s+ElectricalParameters.FirstStepTime_s,100);
       t=[t1,t2];
 end
%   potential=SweepPotential(ElectriElectricalParameterslParameters.StartPotential,ElectriElectricalParameterslParameters.SwitchingPotential,ElectriElectricalParameterslParameters.SElectricalParametersnRate,t);
%   function Potential=SweepPotential(start,end1,v,t)
%         Potential=sawtooth(t*pi/abs(ElectriElectricalParameterslParameters.SwitchingPotential-ElectriElectricalParameterslParameters.StartPotential)*ElectriElectricalParameterslParameters.SElectricalParametersnRate,.5)*(ElectriElectricalParameterslParameters.SwitchingPotential-ElectriElectricalParameterslParameters.StartPotential)/2+(ElectriElectricalParameterslParameters.SwitchingPotential+ElectriElectricalParameterslParameters.StartPotential)/2;
% end
end

