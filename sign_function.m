function [ plus_minus ] = sign_function( segment )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
  if mod(segment,2)==0
      plus_minus=-1;
  else
      plus_minus=1;
  end

end

