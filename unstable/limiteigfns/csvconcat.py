for p in ['1','2','3','4','5','6','7','8']:
    a = open('./1/'+p+'/eigvals.csv')
    b = open('./2/'+p+'/eigvals.csv')
    c = open('./3/'+p+'/eigvals.csv')
#    d = open('./4/'+p+'/eigvals.csv')
#    e = open('./5/'+p+'/eigvals.csv')
    output = open('./output/'+p+'.csv','w+')
    output.write('m=1,m=2,m=3,p='+str(pow(10,-int(p)))+'\n')
    for i in range(0,1092):
        output.write(a.readline()[:-1]+','+b.readline()[:-1]+','+c.readline()[:-1]+'\n')
    output.close()
    
