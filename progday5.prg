function Start()
cdir := "C:\prog\Adventofcode2021\day5"
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
for i := 1 upto alen(a)
	c := a[i]
	c := strtran(c, " ", "")
	a2 := string2array(c, "->")
   a3 := string2array(a2[1], ",")
	c := a3[1]
	x1 := val(c)
	c := a3[2]
	y1 := val(c)
   a3 := string2array(a2[2], ",")
	c := a3[1]
	x2 := val(c)
	c := a3[2]
	y2 := val(c)
	//if x1 == x2 .or. y1 == y2 
	aadd (ac, {x1, y1, x2, y2})
	//endif
next
return

function makearray()
oacf := Dictionarycreate("SH")
nsame := 0
n := alen(ac)
for i := 1 upto n
	x1 := ac[i,1]
	y1 := ac[i,2]
	x2 := ac[i,3]
	y2 := ac[i,4]
	if x1 > x2
		ix := -1
	elseif x1 < x2
		ix := 1
	else 
		ix := 0
	endif
	if y1 > y2
		iy := -1
	elseif y1 < y2
		iy := 1
	else 
		iy := 0
	endif
	macrofunc ("Checksame", {x1, y1})
	do while x1 <> x2 .or. y1 <> y2 
		x1 += ix 
		y1 += iy 
		macrofunc ("Checksame", {x1, y1})
	enddo
   
next 
msginfo ("!!! " + typevalue2string(nsame, oacf:count))
return

function Checksame (x1, y1)
ckey := str(x1, 3, 0)+str(y1, 3, 0)
c := oacf:getvalue(ckey, "")
lfound := !Empty(c)
if lfound 
	n := val(c)
	n += 1
	if n == 2
	nsame += 1
	endif
else 	
	n := 1
endif
oacf:Addorupdate(ckey, ntrim(n))
return lfound
return 

export cdir
export ninput 
export ac 
export nsame 
export oacf