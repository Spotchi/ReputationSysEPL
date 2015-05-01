function [] = latex_tab(filename,a,headings,leftdiv)

%Copy the matrix a in a tab

% Check the lengths

[nLINES,nCOLUMNS] = size(a);

if length(headings) ~= nCOLUMNS+1
	error('Invalid heading length');
end

if length(leftdiv) ~= nLINES
	error('Invalid leftdiv length');
end

fid = fopen(filename,'w');
fprintf(fid,'\\begin{tabular}{|');
for i = 1:nCOLUMNS+1
	fprintf(fid,'c|');
end
fprintf(fid,'}\n\\hline \n');
for i = 1:nCOLUMNS
	fprintf(fid,' %s &',headings{i});
end
fprintf(fid,' %s \\\\',headings{nCOLUMNS+1});
fprintf(fid,'\n\\hline \n \\hline \n');
for i=1:nLINES
	fprintf(fid,'%s & ',leftdiv{i});
	for j = 1 : nCOLUMNS
		if j ==nCOLUMNS
			fprintf(fid,'$%g$ \\\\ \n \\hline \n',a(i,j));
		else
			fprintf(fid,'$%g$ & ',a(i,j));
		end
	end
end
fprintf(fid,' \n \\end{tabular}');
fclose(fid);
