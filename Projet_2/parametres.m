
% Message
Minfo = 90;         % Taille message a  transmettre [en bits]
Mseq = 10;          % Taille de la sequence de synchronisation 
M = Minfo + Mseq;   % Taille des messages envoyes 

% Systeme 
K = 2;           % Nombre de modules 
N = 2;           % Nombre de canaux
R = 10;          % debit binaire [en bits / s]
Tb = 1 / R;      % La duree d'un seul bit [en s / bit]

% Emetteur
rolloff = 0.40;  % Facteur de rolloff (varie entre 0 et 1)
beta = 4*N;      % Facteur de surechantillonnage
Tn = Tb/beta;    % Cadence Tn de la séquence d?échantillons en sortie du FIR
span = 20;       % rcos span for thinner bandwidth consumption
%pwr = 200;       % channel power in mW

% Canal 
Eb_No = 10;
random_delay = randi([0 Tb/Tn],1,K); % delais aleatoire
random_alphaN = (rand(1,1));         % facteur d'affaiblissement aleatoire (>1)
shift = 4;

% Recepteur
impulseL = 128;
startSeq = [1 0 1 0 1 0 1 0 ... % test the channel response
            1 1 1 1 1 1 1 1];   % set an unique sequence