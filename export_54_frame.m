% export the figure at 54 frames
figure
i=44;
x=handles.data.x;
t=handles.data.t;
solution=handles.data.solution;
sizes=size(solution);
X=x'*ones(1,sizes(3));
Y=squeeze(solution(i,:,:));
plot(X,Y)
title(['t=',num2str(t(i)),'s'])
xlabel('Distance to electrode m')
ylabel('Concentration mmol/L')
legend('R','O');

 