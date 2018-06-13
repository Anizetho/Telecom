%%%%%%%%%%%%%%%%%%%% Canal %%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;

%Ajout du délais
for i = 1:K
    Msg_Channel_delayed(i,:) = [zeros(1,random_delay(i)) Msg_Channel(i,:) zeros(1,Tb/Tn - random_delay(i))]; %Shift
end 

%Ajout de l'atténuation au signal décallé
Msg_Channel_dimmed =  Msg_Channel_delayed .* random_alphaN;

%Ajout du bruit blanc gaussien 
AWGN = awgn(Msg_Channel_dimmed,Eb_No);

%Addition du bruit blanc et signal atténué-décallé
Msg_Channel_Noised = Msg_Channel_dimmed + AWGN;

%Sommation des quatres canaux 
Msg_Channel_sent= sum(Msg_Channel_Noised,1)

%figure
plot(Msg_Channel_sent)