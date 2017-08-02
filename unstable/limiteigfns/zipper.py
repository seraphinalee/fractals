import os


for m in ['1','2','3']:
    for p in ['1','2','3','4','5','6','7','8']:
        tozip = ''
        index = 1
        while os.path.isfile('./'+m+'/'+p+'/'+str(index)+'.fig'):
            tozip = tozip + ' ./'+m+'/'+p+'/'+str(index)+'.fig' 
            index = index + 1
        os.system('zip output/m'+m+'p'+p+'.zip '+ tozip)

