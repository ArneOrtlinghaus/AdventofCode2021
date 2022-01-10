function Start()
cdir := "C:\prog\Adventofcode2021\day6"
ninput := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
oacf := Dictionarycreate("SH")
c := ffileread(cfile)
c := trimcrlf(c)
a := {}
for i := 0 upto 8
AAdd (a, float(0))
next
ar := string2array(c, ",")
for i := 1 upto alen(ar)
	c := ar[i]
	nd := val(c)
	n := a[nd+1]
	n += 1
	APutOne (a, nd+1, float(n))
next
return

function cycle()
// position 1 entspricht 0 Tagen 
nzero := a[1] 
aputone (a, 1,float(0))

for i := 2 upto 9
	nfrom := a[i]
	aputone (a, i, 0)
	nto := a[i-1]
	aputone (a, i-1, float(nto)+float(nfrom))
next

nto := a[6+1] 
aputone (a, 6+1,float(nto)+float(nzero))

nto := a[8+1] 
aputone (a, 8+1,float(nto)+float(nzero))

return 

function cycles()
dlgprogressinit (getshell(), "...")
for ic := 1 upto 256
	macrofunc ("cycle", {})
	dlgprogressupdatetext (getshell(), ntrim(ic) + " " + ntrim(na))
next
dlgprogressclose(getshell())
return

function sum ()
nsum := 0
for i := 1 upto 9 
	nsum += a[i]
next	
return 

export cdir
export ninput 
export a
export nsum