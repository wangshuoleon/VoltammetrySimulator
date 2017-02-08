function [ ip,Ep,locs ] = EC_findpeaks( i_profiles, t ,potential,ElectricalParameters)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%  Determination of the peak sensitivity
s=(max(i_profiles)-min(i_profiles))/10000;
%% scan direction
direction=sign(ElectricalParameters.StartPotential_V-ElectricalParameters. SwitchingPotential_V);
segment_length=length(t)/(ElectricalParameters.NumberOfScans*2);
% create the direction vector
direction_vector=zeros(1,length(t));
for segment =1 :2*ElectricalParameters.NumberOfScans
    direction_vector((segment-1)*segment_length+1:segment*segment_length)=ones(segment_length,1)*direction^segment;
end

% prepare the i profiles for peak finding
i_profiles_transfer=i_profiles.*direction_vector;

%% locating the peaks

    
    
 [~,locs1] = findpeaks(i_profiles_transfer);
 for i=1:length(locs1)
     if abs(i_profiles(locs1(i))-i_profiles(locs1(i)-1))>s
           locs(i)=locs1(i);
     end
 end

 %% prepare the curve fitting
 [t,i_profiles]=prepareCurveData(t,i_profiles);
 
 %% retrieve the ip
 ip(1)=i_profiles(locs(1));
 Ep(1)=potential(locs(1));
 
 
 for i=1:length(locs)-1
     fitmin_indice=locs(i)+1;
     fitmax_indice=fix((locs(i)+locs(i+1))/2);
     
     fitobject= fit( t(fitmin_indice:fitmax_indice),i_profiles(fitmin_indice:fitmax_indice),'power2' );
     ip(i+1)=i_profiles(locs(i+1))-fitobject(locs(i+1));
     Ep(i+1)=potential(locs(i+1));
 end
     
 
 
end

