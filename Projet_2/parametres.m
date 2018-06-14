
% Message
Minfo = 90;         % Taille message à transmettre [en bits]
Mseq = 10;          % Taille de la séquence de synchronisation 
M = Minfo + Mseq;   % Taille des messages envoyés 

% Système 
K = 2;           % Nombre de modules 
N = 2;           % Nombre de canaux
R = 10;          % Débit binaire [en bits / s]
Tb = 1 / R;      % La durée d'un seul bit [en s / bit]

% Émetteur
rolloff = 0.40;  % Facteur de rolloff (varie entre 0 et 1)
beta = 4*N;      % Facteur de sur-échantillonnage
Tn = Tb/beta;    % upsample sampling rate
span = 20;       % rcos span for thinner bandwidth consumption
%pwr = 200;       % channel power in mW

% Canal 
Eb_No = 10;
random_delay = randi([0 Tb/Tn],1,K) % Délais aléatoire
random_alphaN = (rand(1,1)) % facteur d’affaiblissement aléatoire (>1)
