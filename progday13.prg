function Start()
cdir := "C:\prog\Adventofcode2021\day13"
ninput := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2array(c, crlf)
ac := {}
afold := {}
for i := 1 upto alen(a)
	c := a[i]
	c := alltrim(c)
	if empty(c)
		Nop()
	elseif left(c, 2) == "fo"
		c := strtran(c, "fold along ", "")
		a2 := string2array(c, "=")
		aadd (afold, {a2[1]=="x", val(a2[2])})
	else
		a2 := string2array(c, ",")
		c := a2[1]
		x := val(c)
		c := a2[2]
		y := val(c)
		aadd (ac, {x, y})
	endif
next
return

function fold(lx, npos)
for i := 1 upto alen(ac)
	if lx
		nx := ac[i,1]
		if nx>= npos 
			nx := 2*npos - nx
			aputtwo (ac, i, 1, nx)
		endif
	else
		ny := ac[i,2]
		if ny>= npos 
			ny := 2*npos -ny
			aputtwo (ac, i, 2, ny)
		endif
	endif
next
return 

function foldall ()
for ifold := 1 upto alen(afold)
lx := afold[ifold,1]
npos := afold[ifold,2]
macrofunc ("fold", {lx, npos})
next
//asorttwodim(ac, 1, true)
macrofunc ("elimequal", {})

return 

function elimequal()
nsum := 0
for i := alen(ac) downto 1
	for j := 1 upto i-1
		if ac[i,1] == ac[j,1] .and. ac[i,2] == ac[j,2]
			aaus (ac, i)
			exit
		endif
	next
next
nsum := alen(ac)
return 

function display()
cend := ""
for iy := 0 upto 5
	al := acreateone (40, "0")
	for i := 1 upto alen(ac)
		if ac[i,2] == iy 
			ix := ac[i,1] 
			aputone (al, ix+1, "X")
		endif
	next
	for il := 1 upto 40 
		cend += al[il]
	next
	cend += crlf
next
msginfo (cend)
return
export cdir
export ninput 
export ac 
export afold
export nsum