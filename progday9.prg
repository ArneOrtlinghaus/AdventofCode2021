function Start()
cdir := "C:\prog\Adventofcode2021\day9"
ninput := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := {}
ar := string2array(c, crlf)
for i := 1 upto alen(ar)
	c := ar[i]
	c := alltrim(c)
	nx := len(c)
	a2 := {}
	for j := 1 upto nx
		c1 := substr(c, j, 1)
		aadd (a2, val(c1))
	next
	aadd (a, a2)
next
ny := len(a)

return

function findlows()
nsum := 0
nsumrisk := 0
abasins := {}
for iy := 1 upto ny 
   for ix := 1 upto nx 
		llow := true
		n := a[iy, ix]
		iyy := iy-1
		if iyy >= 1
			if a[iyy, ix] <= n 
				llow := false 
			endif
		endif
		iyy := iy+1
		if iyy <= ny
			if a[iyy, ix] <= n 
				llow := false 
			endif
		endif
		ixx := ix-1
		if ixx >= 1
			if a[iy, ixx] <= n 
				llow := false 
			endif
		endif
		ixx := ix+1
		if ixx <= nx
			if a[iy, ixx] <= n 
				llow := false 
			endif
		endif
		if llow 
			nsum += 1
			nsumrisk += n+1
			macrofunc ("startcalcbasin", {ix, iy})
			//msginfo ("!!! " + typevalue2string(ix, iy, n, nsum, nsumrisk))
		endif
   next
next
return

function checknextfield (ix, iy, ixdiff, iydiff) 

c := "*"+ntrim(ix)+","+ntrim(iy)+"%"
//cprot += c + typevalue2string(ixdiff, iydiff)+crlf
if instr(c, ctestedthis)
//	cprot += "allready tested"+crlf
	return 
endif

if a[iy, ix] == 9 
//	cprot += "9"+crlf
	return 
endif 


nbasinthis += 1
ctestedthis += c
if ix > 1 .and. ixdiff <> 1
	macrofunc ("checknextfield", {ix-1, iy, -1, 0})
endif	
if ix < nx .and. ixdiff <> -1
	macrofunc ("checknextfield", {ix+1, iy, +1, 0})
endif	
if iy > 1 .and. iydiff <> 1
	macrofunc ("checknextfield", {ix, iy-1, 0, -1})
endif	
if iy < ny .and. iydiff <> -1
	macrofunc ("checknextfield", {ix, iy+1, 0, +1})
endif	


return 

function startcalcbasin (ix, iy) 
ctestedthis := ""
nbasinthis := 1
cprot := ""
ctestedthis += "*"+ntrim(ix)+","+ntrim(iy)+"%"
if ix > 1 
	macrofunc ("checknextfield", {ix-1, iy, -1, 0})
endif	
if ix < nx
	macrofunc ("checknextfield", {ix+1, iy, +1, 0})
endif	
if iy > 1 
	macrofunc ("checknextfield", {ix, iy-1, 0, -1})
endif	
if iy < ny
	macrofunc ("checknextfield", {ix, iy+1, 0, +1})
endif	
AAdd (abasins, nbasinthis)
return 

export cdir
export ninput 
export a
export nx 
export ny 
export nsum
export nsumrisk
export ctestedthis
export nbasinthis
export cprot
export abasins

manual calculation:
//macrofunc("startcalcbasin",{10, 1})
ASortTwoDim(abasins, 0, false)
n := 121 *116 *114
