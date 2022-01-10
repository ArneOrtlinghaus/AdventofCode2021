function Start()
cdir := "C:\prog\Adventofcode2021\day1"
npart := 1
macrofunc("Read")
return

function read()
nincrease := 0
nsumbefore := 999999999
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(npart)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2array(c, crlf)
nmax := alen(a)
for i := 1 upto nmax
c := alltrim(a[i])
n := val(c)
APutone (a, i, n)

if i <= nmax-2
   n2 := val(alltrim(a[i+1]))
   n3 := val(alltrim(a[i+2]))
	nsum := n + n2 + n3
	if nsum > nsumbefore 
		nincrease+=1
	endif
	nsumbefore := nsum
endif
next
msginfo (typevalue2string(nincrease))
return 



export a

export cdir
export npart
export ninput 