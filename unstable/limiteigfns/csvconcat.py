for p in ['1','2','3','4','5','6','7','8']:
    a = open('./1/'+p+'/eigvals.csv')
    b = open('./2/'+p+'/eigvals.csv')
    c = open('./3/'+p+'/eigvals.csv')
    d = open('./4/'+p+'/eigvals.csv')
    e = open('./5/'+p+'/eigvals.csv')
    output = open('./output/'+p+'.csv','a')
    output.write('m=1,m=2,m=3,m=4,m=5,p='+str(10^-int(p)))
    for i in range(0,1092):
        output.write(a.readline()+','+b.readline()+','+c.readline()+','+d.readline()+','+e.readline())
    output.close()
    
