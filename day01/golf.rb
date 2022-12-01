$/*=2
x=$<.map{_1.split.sum &:to_i}.max 3
p x[0],x.sum