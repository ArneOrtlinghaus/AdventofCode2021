function Start()
cdir := "C:\prog\Adventofcode2021\day11"
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
nstep := 0
nflash := 0

return

function incrstep()
nstep += 1
for ix := 1 upto nx
	for iy := 1 upto ny
		n := a[iy,ix]
		n += 1
		aputtwo (a, iy, ix, n)
	next 
next
return 

function flashincrother()
for ix := 1 upto nx
	for iy := 1 upto ny
		n := a[iy,ix]
		if n > 9
			for ixx := ix-1 upto ix+1
				for iyy := iy-1 upto iy+1
					if ixx <> ix .or. iyy <> iy 
						if between (ixx, 1, nx) .and. between (iyy, 1, ny)
							n := a[iyy,ixx]
							if n >= 0
								n += 1
								aputtwo (a, iyy, ixx, n)
							endif
						endif
					endif
				next
			next
			aputtwo (a, iy, ix, -1)
		endif
	next 
next
return 

function flashandreset()
for ix := 1 upto nx
	for iy := 1 upto ny
		n := a[iy,ix]
		if n < 0
			nflash += 1
			n := 0
			aputtwo (a, iy, ix, n)
		endif
	next 
next
return 

function checkallreset()
lall := true
for ix := 1 upto nx
	for iy := 1 upto ny
		n := a[iy,ix]
		if n > 0
			lall := false
			exit
		endif
	next 
	if !lall 
		exit 
	endif
next
if lall 
	msginfo (Typevalue2string(nstep))
endif	
return 


function incrall()
for i := 1 upto 10000
	macrofunc ("incrstep", {})
	for j := 1 upto 20
	macrofunc ("flashincrother", {})
	next
	macrofunc ("flashandreset", {})
	macrofunc ("checkallreset", {})
	
next
return 

export cdir
export ninput 
export a
export nx 
export ny 
export nstep 
export nflash