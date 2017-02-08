function  reverse_plot( varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if length(varargin)==2
    plot(varargin{1},varargin{2});
    set(gca,'xDir','reverse');
    set(gca,'color','none')
else
    plot(varargin{1},varargin{2},varargin{3});
    set(gca,'xDir','reverse');
    set(gca,'color','none')
end

