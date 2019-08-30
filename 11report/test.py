


def predicate(rule,env) :
	 


if __name__ == "__main__"
env = []

#ここでruleの取り込み
print ("?:-")
p = input()
l = input()
for rule in l:
	env.append(p,l)	

#探索アルゴリズム
while(1):
	print("?:-")
	p = input()
	l = input()
	for rule in l:
		predicate(rule,env)


