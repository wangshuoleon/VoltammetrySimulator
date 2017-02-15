function [ video ] = output_avi( i_profiles,solution,x,t,potential,data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure
     sizes=size(solution);

      for i=1:sizes(1)
%          for j=1:sizes(3)
%             plot(x,solution(i,:,j))
%          end
       X=x'*ones(1,sizes(3));
       Y=squeeze(solution(i,:,:));
       subplot(2,2,1:2)
       plot(X,Y)
       title(['t=',num2str(t(i)),'s'])
       xlabel('m')
       ylabel('Concentration mmol/L')
       switch data.Ctrl.Mechanism
           case 'E'
              legend('R','O');
           case 'EC'
               legend('R','O','Products')
           case 'ECE'
               legend('R','O','S','T')
           case 'ECatalysis'
               legend('R','O','Y')
       end
       subplot(2,2,3)
       reverse_plot(potential(1:i),i_profiles(1:i))
       title(['E=',num2str(potential(i)),'V,i=',num2str(i_profiles(i)),'A/m^2'])
       xlabel('Potential (V)')
       ylabel('Current density A/m^2')
       subplot(2,2,4)
       plot(t(1:i),i_profiles(1:i))
       title(['Time=',num2str(t(i)),'s,i=',num2str(i_profiles(i)),'A/m^2'])
       xlabel('Time (s)')
       ylabel('Current density A/m^2')
       moviedata(i)=getframe(gcf);
      
      end
   video=moviedata;
   % movie2avi(moviedata, 'concentration_profiles.avi');

end

