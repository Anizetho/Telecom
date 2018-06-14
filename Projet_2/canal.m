%----------------------------- CANAL -----------------------------------

%Transposition de la matrice pour avoir k colonnes et M colonnes
Msg_Channel = s1High.';

%figure('Name', 'Représentation_canal', 'NumberTitle', 'off', 'rend','painters','pos',[10 200 1200 200]);

% % plot visual representation of the transmission (emetteur)
% subplot(2,1,1)
% stem(linspace(0, len1*Tn, len1,Msg_Channel));
% title('Representation temporelle du signal envoye dans le canal')
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend(strcat('Canal ', num2str((1:N)')), 'Location', 'NorthEast')
% grid
% title('transpo')


%Ajout du délais dans chaque canal
for i = 1:K
    Msg_Channel_delayed(i,:) = [zeros(1,random_delay(i)) Msg_Channel(i,:) zeros(1,Tb/Tn - random_delay(i))];
end 

% % plot visual representation of the transmission with delay
% subplot(2,1,2)
% plot(Msg_Channel_delayed);
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend(strcat('Canal ', num2str((1:N)')), 'Location', 'NorthEast')
% grid
% title('délais')

%Ajout de l'atténuation au signal décallé
Msg_Channel_dimmed =  Msg_Channel_delayed .* random_alphaN;

% % plot visual representation of the transmission with shift
% subplot(2,1,3)
% plot(Msg_Channel_dimmed);
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend(strcat('Canal ', num2str((1:N)')), 'Location', 'NorthEast')
% grid
% title('atténuation')

% figure;
% plot(Msg_Channel_dimmed(1,:));
% title('atténuation');

%Ajout du bruit blanc gaussien 
%AWGN = awgn(Msg_Channel_dimmed,Eb_No);

%Addition du bruit blanc et signal atténué-décallé
Msg_Channel_Noised = Msg_Channel_dimmed; %+ AWGN;

% % plot visual representation of the transmission with AWGN
% subplot(2,1,4)
% plot(Msg_Channel_Noised);
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend(strcat('Canal ', num2str((1:N)')), 'Location', 'NorthEast')
% grid
% title('addition du bruit blanc')

%Sommation des quatres canaux 
Msg_Channel_sent= sum(Msg_Channel_Noised,1);
%Msg_Channel_sent= [zeros(shift,1); Msg_Channel_sent];


% % plot visual representation of the transmission with sum of all channels
% subplot(2,1,5)
% plot(Msg_Channel_sent);
% ylabel('Amplitude (v)'), xlabel('Times (s)')
% legend(strcat('Canal ', num2str((1:N)')), 'Location', 'NorthEast')
% grid
% title('Sommation des quatres canaux')

