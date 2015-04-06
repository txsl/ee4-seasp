
% Breakpoint saving thanks to http://stackoverflow.com/questions/12657219/how-to-restore-breakpoints-in-matlab-after-clear-all
tmp = dbstatus;
save('tmp.mat','tmp')

close all; clear all; clc;

load('tmp.mat')
dbstop(tmp)

clear tmp
delete('tmp.mat')

addpath('../libs')
% addpath('../libs/voicebox')

set(0,'DefaultTextInterpreter','latex'); 
set(groot, 'DefaultLegendInterpreter', 'latex')
