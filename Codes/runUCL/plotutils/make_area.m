function [] = make_area(M,nUNITS,nTIMES)

qgen = zeros(nUNITS,nTIMES); % data for each generator on one row
for i = 1:nUNITS
	qgen(i,1:end) = (M((i-1)*nTIMES+1:i*nTIMES,2))';
end
qgen_by_type = zeros(3,nTIMES);
qgen_by_type(1,1:end) = sum(qgen(1:7,1:end));
qgen_by_type(2,1:end) = sum(qgen(8:14,1:end));
qgen_by_type(3,1:end) = sum(qgen(15:19,1:end));

day = (1:nTIMES)*5/60;

figure()
APLOT = area(day,qgen_by_type');
set(APLOT(1),'FaceColor',[186/255 171/255 108/255]);
set(APLOT(2),'FaceColor',[249/255 211/255 61/255]);
set(APLOT(3),'FaceColor',[0.75 0 0.15]);

grid;
xlim([0 24]);

legend('Coal','Gas','Oil');

