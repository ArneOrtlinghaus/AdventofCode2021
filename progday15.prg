function Start()
cdir := "C:\prog\Adventofcode2021\day15"
ninput := 0
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

function Startsteps() 
astack := {}
nriskmin := 999999999
cpathmin := ""
ntry  := 0
nstep := 0
ffilewrite (faddbackslash(cdir)+"prot.txt", "Start" + crlf)

astack := {}
	AAdd (astack, {nstep+1, {1, 1, 0, 1, "", 0, 0, 0, 0, 0}}) 
	AAdd (astack, {nstep+1, {1, 1, 1, 0, "", 0, 0, 0, 0, 0}}) 

return

function execnextstep()
nstep += 1
for istack := alen(astack) downto 1
	if astack[istack, 1] == nstep 
		ast := astack[istack,2]
		macrofunc ("nextstep", {ast[1],ast[2],ast[3],ast[4],ast[5],ast[6],ast[7],ast[8],ast[9],ast[10]})
		aaus (astack, istack)
	endif
next
return

function nextstep (ix, iy, ixstep, iystep, cpath, nrisk, nrecursion, ixsum, iysum, iysumback) 

lgoon := true
creason := ""
ntry += 1
ix += ixstep 
iy += iystep
nrecursion += 1
ixsum += abs(ixstep)
iysum += abs(iystep)
if iystep < 0
	iysumback += 1
endif
nrisk += ac[iy,ix]
cadd := " ("+ntrim(iy)+","+ntrim(ix)+")"+ntrim(ac[iy,ix])

if ix == nx .and. iy == ny 
	if nrisk < nriskmin 
		nriskmin := nrisk 
		cpathmin := cpath
		lgoon := false 
		creason := "End!"
	endif
endif

if lgoon
	if nrisk >= nriskmin 
		lgoon := false 
		creason := "Risk too big"
	endif
endif

if lgoon
	if (ix == 1 .and. iy == 1) .or. instr(cadd, cpath) // Kreiswanderung
		lgoon := false 
		creason := "Kreis"
	endif
endif
if lgoon
	if nrecursion > 2*ny+10
		lgoon := false 
		creason := "Recursionmax"
	endif
endif
if lgoon
	if ixsum > nx+5
		lgoon := false 
		creason := "ixsum max"
	endif
endif
if lgoon
	if iysum > ny+5
		lgoon := false 
		creason := "iysum max"
	endif
endif
if lgoon
	if iysumback > 3
		lgoon := false 
		creason := "iysumback max"
	endif
endif
if lgoon
	if 1==2 .and. ntry > 10000
		lgoon := false 
		creason := "Max try"
	endif
	
endif
cpath += cadd 

//if creason == "End!" .or. mod(ntry, 1000) == 0
	ffileappend (faddbackslash(cdir)+"prot.txt", cpath + " " + ntrim(ntry) + " " + ntrim(nrecursion) + " " + ntrim(nriskmin) + " " + creason + crlf)
//endif

if lgoon
	if iy < ny .and. iystep <> -1
		AAdd (astack, {nstep+1, {ix, iy, 0, 1, cpath, nrisk, nrecursion, ixsum, iysum, iysumback}}) 
	endif
	if ix < nx .and. ixstep <> -1
		AAdd (astack, {nstep+1, {ix, iy, 1, 0, cpath, nrisk, nrecursion, ixsum, iysum, iysumback}}) 
	endif
	if ix > 1 .and. ixstep <> 1
		AAdd (astack, {nstep+1, {ix, iy, -1, 0, cpath, nrisk, nrecursion, ixsum, iysum, iysumback}}) 
	endif
//	if iy > 1 .and. iystep <> 1
//		AAdd (astack, {nstep+1, {ix, iy, 0, -1, cpath, nrisk, nrecursion, ixsum, iysum, iysumback}}) 
//	endif
endif

return 

export cdir
export ninput 
export ac 
export nx 
export ny
export nriskmin 
export cpathmin 
export ntry 
export astack
export nstep