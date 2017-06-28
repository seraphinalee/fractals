import scipy.io as sio

#Crude but effective


#swap these three out with the necessary adjustments
#ideally all running in the same folder but you can adjust if needed
myfilename = 'mymatrix.mat'
outfilename = 'mylatex.tex'
matrixname = 'unique_eigvals'

output = open(outfilename,'w')
output.write('\\begin{tabular}{c |c} \nEigenvalue & Multiplicity \\\ \n\\hline\\hline')
matrix = sio.loadmat(myfilename)
matrix = matrix[matrixname]
for i in range(0,len(matrix)):
    row = ''
    for j in matrix[i]:
        row = row + str(j) + ' & '
    row = row[0:-3]
    row = row + '\\\ \n\\hline\n'
    output.write(row)
output.write('\\end{tabular}')
output.close()



