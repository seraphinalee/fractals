import os


for m in ['1','2','3','4','5']:
    for p in ['1','2','3','4','5','6','7','8']:
        pdfs = ''
        index = 1
        while os.path.isfile('./'+m+'/'+p+'/'+str(index)+'.pdf'):
            pdfs = pdfs + './'+m+'/'+p+'/'+str(index)+'.pdf ' 
            index = index + 1
        os.system('pdfunite ' + pdfs + 'output/m'+m+'p'+p+'.pdf')

