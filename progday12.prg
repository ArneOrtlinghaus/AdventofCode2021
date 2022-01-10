function Start()
cdir := "C:\prog\Adventofcode2021\day12"
ninput := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
ar := string2array(c, crlf)
ac := {}
for ir := 1 upto 2
	for i := 1 upto alen(ar)
		c := ar[i]
		c := alltrim(c)
		a2 := string2array(c, "-")
		for j := 1 upto 2
			c1 := a2[j]
			if c1 == "start"
				c1 := "@start"
			elseif c1 == "end"
				c1 := "zend"
			endif
			npos := ascanstring(ac, c1, 1)
			if npos == 0
				aadd (ac, {c1, {}, substr(c1,1,1) == lower(substr(c1,1,1))})
				npos := alen(ac)
			endif
			if npos > 0 .and. ir == 2
				c2 := a2[3-j]
				if c2 == "start"
					c2 := "@start"
				elseif c2 == "end"
					c2 := "zend"
				endif
				ax := ac[npos,2]
				aadd (ax, c2)
			endif
		next
	next
next
nac := len(ac)
ASortTwoDim (ac, 1)
return

function findall()
dlgprogressinit (nil, "x")
nways := 0
ncalls := 0
cprot := ""
avisited := acreateone (nac, 0)
npos := 1
macrofunc ("findsingle", {avisited, npos, 1, "", false})
dlgprogressclose(nil)
return

function findsingle (avisited, npos, ncallsrec, cprotsingle, onesinglevisitedtwice)
ncalls += 1
//c := ntrim(npos) + " " + ntrim(ncallsrec) + " " + ntrim(ncalls) + crlf 
cprotsingle += ac[npos,1]+","

//dlgprogressupdatetext(nil, c)
if npos == 1 .and. avisited[npos] > 0 // start
	cprotsingle += " start again"+crlf
	ffileappend (faddbackslash(cdir)+"prot.txt", cprotsingle)
	return false
endif
if npos == nac  // ende
	cprotsingle += " end ok"+crlf
	ffileappend (faddbackslash(cdir)+"prot.txt", cprotsingle)
	nways += 1
	return true
endif
if ac[npos,3] // small cave
	if avisited[npos] > 1
		cprotsingle += " small cave already twice"+crlf
		return false
	endif
	if avisited[npos] > 0
		if onesinglevisitedtwice 
			cprotsingle += " already one small cave twice"+crlf
			return false
		else 
			onesinglevisitedtwice  := true 
		endif
	endif
endif
if avisited[npos] > 5 // big cave
	cprotsingle += " big cave too often"+crlf
	return false
endif
aputone (avisited, npos, avisited[npos]+1)

ax := ac[npos,2]
for ix := 1 upto alen(ax)
	c2 := ax[ix]
	nposx := ascanstring(ac, c2, 1)
	macrofunc ("findsingle", {aclonemacro(avisited), nposx, ncallsrec+1, cprotsingle, onesinglevisitedtwice})
next
return true


export cdir
export ninput 
export ac
export nac
export nways
export cprot 
export ncalls