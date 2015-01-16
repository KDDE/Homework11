A = load '$input' using PigStorage('[') as (b:chararray, c: chararray, f:chararray);
B = foreach A generate f as word;
C = foreach B generate REPLACE(word, '].*$', '') as word;
D = foreach C generate FLATTEN(STRSPLITTOBAG(word, ',', 30)) as word;
E = foreach D generate REPLACE(word, '^ *','') as word;
F = group E by word;
G = foreach F generate COUNT(E) as counts, group;
H = order G by counts desc;
I = LIMIT H 101;
store I into '$output';
