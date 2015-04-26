close all;
clear all;

data_dir = '../results/';
images_dir = '../report/images/';
tex_dir = '../report/texmatlab/';

f = csvread(strcat(data_dir,'f_1.csv'),0,0);
%fig = createFigure('Flows on the lines','Lines','flow');
%bar(f(:,3));
%print(strcat(images_dir,'flows1.eps	'),'-depsc');

p = csvread(strcat(data_dir,'p_1.csv'),0,0);
%fig = createFigure('Production on the units','Generators','Production(MW/h)');
%bar(p(:,3));
%print(strcat(images_dir,'prod1.eps	'),'-depsc');

r = csvread(strcat(data_dir,'r_1.csv'),0,0);
%fig = createFigure('Net injections','Bus','Injection');
%bar(r(:,2));
%print(strcat(images_dir,'injec1.eps	'),'-depsc');

rho = csvread(strcat(data_dir,'rho_1.csv'),0,0);
%fig = createFigure('Prices','Bus','Price');
%bar(rho(:,2));
%print(strcat(images_dir,'rho1.eps	'),'-depsc');

headings{4} = [];
headings{1} = 'Bus';
headings{2} = '1st bus';
headings{3} = '2nd bus';
headings{4} = '3rd bus';
leftdiv{3} = [];
leftdiv{1} = 'Production';
leftdiv{2} = 'Net injection';
leftdiv{3} = 'Prices';

headings2 = {'Lines','Line 1-2','Line 2-3','Line 3-1'};
leftdiv2 = {'Flows'};


latex_tab(strcat(tex_dir,'resBus1.tex'),[p(:,3)';r(:,2)';rho(:,2)'],headings,leftdiv);
latex_tab(strcat(tex_dir,'resLines1.tex'),[f(:,3)'],headings2,leftdiv2);


% 200MW 2-3
f = csvread(strcat(data_dir,'f_2.csv'),0,0);
%fig = createFigure('Flows on the lines','Lines','flow');
%bar(f(:,3));
%print(strcat(images_dir,'flows2.eps	'),'-depsc');

p = csvread(strcat(data_dir,'p_2.csv'),0,0);
%fig = createFigure('Production on the units','Generators','Production(MW/h)');
%bar(p(:,3));
%print(strcat(images_dir,'prod2.eps	'),'-depsc');


r = csvread(strcat(data_dir,'r_2.csv'),0,0);
%fig = createFigure('Net injections','Bus','Injection');
%bar(r(:,2));
%print(strcat(images_dir,'injec2.eps	'),'-depsc');


rho = csvread(strcat(data_dir,'rho_2.csv'),0,0);
%fig = createFigure('Prices','Bus','Price');
%bar(rho(:,2));
%print(strcat(images_dir,'rho2.eps	'),'-depsc');

latex_tab(strcat(tex_dir,'resBus2.tex'),[p(:,3)';r(:,2)';rho(:,2)'],headings,leftdiv);

latex_tab(strcat(tex_dir,'resLines2.tex'),[f(:,3)'],headings2,leftdiv2);

welfare1 = csvread(strcat(data_dir,'welfare_1.csv'));
fid = fopen(strcat(tex_dir,'welfare1.tex'),'w');
fprintf(fid,'%g',welfare1);
fclose(fid);
welfare2 = csvread(strcat(data_dir,'welfare_2.csv'));
fid = fopen(strcat(tex_dir,'welfare2.tex'),'w');
fprintf(fid,'%g',welfare2);
fclose(fid);

close all
