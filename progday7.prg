function Start()
cdir := "C:\prog\Adventofcode2021\day7"
ninput := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2array(c, ",")
nmax := 0
for i := 1 upto alen(a)
	c := a[i]
	n := val(c)
	nmax := max(n, nmax)
	APutOne (a, i, n)
next
na := len(a)

afuelcosts := {}
nsum := 0
for i := 1 to nmax
	nsum += i
	AAdd (afuelcosts, nsum)
next	

return



function sum ()
nsum := 0
for i := 1 upto na
	nsum += a[i]
next	
return 

function calcfuel(npos)
nf:= 0
for i := 1 upto na
	ndiff := abs(a[i]-npos)
	if ndiff > 0
		nfp := afuelcosts[ndiff]
	else 
		nfp := 0
	endif
	nf += nfp
next	
return nf 

function calcbest()
dlgprogressinit (getshell(), "...")

nfbest := macrofunc ("calcfuel", {0})
nposbest := 0
for ipos := 1 upto na 
	dlgprogressupdatetext (getshell(), ntrim(ipos))

	nf := macrofunc ("calcfuel", {ipos})
	if nf < nfbest 
		nfbest := nf 
		nposbest := ipos 
	endif
next
dlgprogressclose(getshell())

return

export cdir
export ninput 
export a
export na
export nsum
export nmax 
export nfbest 
export nposbest
export afuelcosts
