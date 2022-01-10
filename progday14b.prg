function Start()
cdir := "C:\prog\Adventofcode2021\day14"
ninput := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
acombi := {}
acomp := {}
arules := {}
ar := string2array(c, crlf)
c := ar[1]
for i := 1 upto len(c)-1
macrofunc ("checkaddcombitemp", {substr(c, i, 2), 1})
next
for i := 1 upto len(c)
macrofunc ("checkaddcomp", {substr(c, i, 1), 1})
next

for i := 2 upto alen(ar)
	c := ar[i]
	c := alltrim(c)
	//CH -> B
	a2 := string2array(c,  " -> ")
	aadd (arules, {a2[1], a2[2]})
next
macrofunc("setcombifix", {})

return

function checkaddcomp (ccomp, naddx)
npos := AScanstring(acomp, ccomp, 1)
if npos > 0 
	n := acomp[npos,2]
	aputtwo (acomp, npos, 2, n+naddx+0.0)
else 
	AAdd (acomp, {ccomp, naddx+0.0})
endif	
return

function checkaddcombitemp (ccombi, naddx)
npos := AScanstring(acombi, ccombi, 1)
if npos > 0 
	n := acombi[npos,3]
	aputtwo (acombi, npos, 3, n+naddx+0.0)
else 
	AAdd (acombi, {ccombi, 0, naddx+0.0})
endif	
return 

function setcombifix()
for i := 1 upto alen(acombi)
	n := acombi[i,3]
	n2 := acombi[i,2]
	aputtwo (acombi, i, 2, n+n2+0.0)
	aputtwo (acombi, i, 3, 0.0)
next


function add()
for i := 1 upto alen(acombi)
	for irules := 1 upto alen(arules)
		ccombi := acombi[i,1]
		if ccombi == arules[irules,1] 
			cnew := arules[irules,2]
			c1 := substr(ccombi, 1, 1)
			c2 := substr(ccombi, 2, 1)
			ncombi := acombi[i,2]
			macrofunc ("checkaddcombitemp", {c1+cnew, ncombi})
			macrofunc ("checkaddcombitemp", {cnew+c2, ncombi})
			macrofunc ("checkaddcombitemp", {c1+c2, -ncombi})
			macrofunc ("checkaddcomp", {cnew, ncombi})
			exit
		endif
	next
next
macrofunc("setcombifix", {})
return

function addall()
nadd := 0
for i := 1 upto 40
	nadd += 1
	macrofunc("Add", {})
next
asorttwodim(acomp, 2, false)
return


export cdir
export ninput 
export acombi
export arules 
export acomp
