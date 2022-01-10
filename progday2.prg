function Start()
cdir := "C:\prog\Adventofcode2021\day2"
ninput := 1
macrofunc("Read")
return

function read()
nincrease := 0
nsumbefore := 999999999
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2array(c, crlf)
nmax := alen(a)
for i := 1 upto nmax
	c := alltrim(a[i])
	if !empty(c)
		a2 := string2Array(c, " ")
		c := alltrim(a2[2])
		n := val(c)
		c := alltrim(a2[1])
		APutone (a, i, {c, n})
	endif
	next
return 

// down X increases your aim by X units.
// up X decreases your aim by X units.
// forward X does two things:
// It increases your horizontal position by X units.
// It increases your depth by your aim multiplied by X.
function calc()
nforward := 0
ndown := 0
naim := 0
for i := 1 upto alen(a)
	c := a[i,1] 
	n := a[i,2] 
	if c == "forward"
		nforward += n
		ndown += naim*n
	elseif c == "up"
		naim -= n
	elseif c == "down"
		naim += n
	else 
		msgerror ("command " + c)
		exit
	endif
next


ntotal := nforward*ndown

msginfo (typevalue2string(nforward, ndown, ntotal))
return



export a

export cdir
export ninput 