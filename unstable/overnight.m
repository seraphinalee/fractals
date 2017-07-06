rvals = [0.01 0.05 0.1 0.5 0.641677 1 2 5 10 100];

for i=1:length(rvals)
    printout3(rvals(i),num2str(i))
    printout3(twin(rvals(i)),strcat(num2str(i),'twin'))
end