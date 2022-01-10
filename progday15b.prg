function Start()
cdir := "C:\prog\Adventofcode2021\day15"
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
	c := alltrim(c)
	if empty(c)
		Nop()
	else
		a2 := {}
		nx := len(c)
		for j := 1 upto len(c)
			aadd (a2, val(substr(c, j, 1)))
		next
		aadd (ac, a2)
	endif
next
ny := alen(ac)
nx := nx 
return

function redim()
for i := 1 upto 4
	for iy := 1 upto ny 
		ax := ac[iy] 
		for ix := 1 upto nx 
			n := ax[ix] 
			n+=i 
			if n > 9
				n -= 9
			endif
			AAdd (ax, n)
		next
	next
next
nx := 5*nx
for i := 1 upto 4
	for iy := 1 upto ny 
		ax := {}
		for ix := 1 upto nx 
			n := ac[iy, ix] 
			n+=i 
			if n > 9
				n -= 9
			endif
			AAdd (ax, n)
		next
		AAdd (ac, ax)
	next
next
ny := 5*ny
return 

function calcrisksums()
arisksum := acreatetwo (ny, nx, 0)
aputtwo (arisksum, 1, 1, 0)
for i := 2 upto ny // nx ist gleich
	ix := i
	for iy := 1 upto i-1
		nrisk1 := arisksum[iy, ix-1]
		nrisk2 := 99999999
		if iy > 1
			nrisk2 := arisksum[iy-1, ix]
		endif
		nrisk := min(nrisk1, nrisk2)
		nrisk += ac[iy, ix]
		aputtwo (arisksum, iy, ix, nrisk)
	next 
	iy := i
	for ix := 1 upto i-1
		nrisk1 := 99999999
		if ix > 1
			nrisk1 := arisksum[iy, ix-1]
		endif
		nrisk2 := arisksum[iy-1, ix]
		nrisk := min(nrisk1, nrisk2)
		nrisk += ac[iy, ix]
		aputtwo (arisksum, iy, ix, nrisk)
	next 
	ix := i 
	iy := i 
	nrisk1 := arisksum[iy, ix-1]
	nrisk2 := arisksum[iy-1, ix]
	nrisk := min(nrisk1, nrisk2)
	nrisk += ac[iy, ix]
	aputtwo (arisksum, iy, ix, nrisk)

	ix := i
	for iy := i-1 downto 1
		n := arisksum[iy+1, ix]  + ac[iy, ix]
		if arisksum[iy, ix] > n
			aputtwo (arisksum, iy, ix, n)
		endif
	next
	iy := i
	for ix := i-1 downto 1
		n := arisksum[iy, ix+1] + ac[iy, ix]
		if arisksum[iy, ix] > n 
			aputtwo (arisksum, iy, ix, n)
		endif
	next
next 

return

function reducerisks()
nsum := 0
for ir := 1 upto 20
	nsum := 0
	for iy := 1 upto ny 
		for ix := 1 upto nx 
			if iy < ny
				n := arisksum[iy+1, ix]  + ac[iy, ix]
				if arisksum[iy, ix] > n
					aputtwo (arisksum, iy, ix, n)
					nsum += 1
				endif
			endif 
			if iy > 1
				n := arisksum[iy-1, ix]  + ac[iy, ix]
				if arisksum[iy, ix] > n
					aputtwo (arisksum, iy, ix, n)
					nsum += 1
				endif
			endif 
			if ix < nx
				n := arisksum[iy, ix+1] + ac[iy, ix]
				if arisksum[iy, ix] > n 
					aputtwo (arisksum, iy, ix, n)
					nsum += 1
				endif
			endif
			if ix > 1
				n := arisksum[iy, ix-1] + ac[iy, ix]
				if arisksum[iy, ix] > n 
					aputtwo (arisksum, iy, ix, n)
					nsum += 1
				endif
			endif
		next
	next 
	if nsum == 0
		exit
	endif
next
msginfo (typevalue2string(nsum))
return


function display()
c := ""
for iy := 1 upto ny 
	for ix := 1 upto nx 
		c2 := str(arisksum[iy, ix], 4, 0)
		c += c2
		if ix < nx .and. arisksum[iy, ix+1] < arisksum[iy, ix]-ac[iy, ix]
			c2 := "*"
		else 
			c2 := " "
		endif
		c += c2
		if iy < ny .and. arisksum[iy+1, ix] < arisksum[iy, ix]-ac[iy, ix]
			c2 := "+"
		else 
			c2 := " "
		endif
		c += c2
	next 
	c += crlf
next
ffilewrite (faddbackslash(cdir)+"prot.txt", c)
execdocument (nil, nil, faddbackslash(cdir)+"prot.txt")
return 

function displayac()
c := ""
for iy := 1 upto ny 
	for ix := 1 upto nx 
		c2 := str(ac[iy, ix], 2, 0)
		c += c2
	next 
	c += crlf
next
msginfo (c)
return 

export cdir
export ninput 
export ac 
export nx 
export ny
export arisksum
