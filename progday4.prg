function Start()
cdir := "C:\prog\Adventofcode2021\day4"
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
c := a[1]
anumbers := string2array(c, ",")
aboards := {}
i := 2
do while i <= alen(a)
	j := 1 
	aboard := {}
	do while j <= 5 .and. i <= alen(a)
		c := alltrim(a[i])
		ax := string2array(c, " ")
		for ix := 1 upto alen(ax)
			nnumber := val(ax[ix])
			aputone (ax, ix, nnumber)
		next
		aadd (aboard, ax)
		j += 1
		i += 1
	enddo
	aadd (aboards, aboard)
enddo 
nboards := alen(aboards)
return

function putnum(nnumber)
for iboard := 1 upto nboards 
	if !aboardswon[iboard]
		aboard := aboards[iboard]
		lfound := false
		for j := 1 upto 5
			for i := 1 upto 5
				if aboard[j,i] == nnumber 
					aputtwo (aboard, j, i, -1-nnumber)
					lfound := true
					if aboard[j, 1] < 0 .and. aboard[j, 2] < 0 .and. aboard[j, 3] < 0 .and. aboard[j, 4] < 0 .and. aboard[j, 5] < 0
						nwin := iboard 
						//msginfo ("Won! col " + typevalue2string(iboard, nwin, j, nnumber))
						nlastnumber := nnumber
						aputone (aboardswon, iboard, true)
					endif
					if aboard[1, i] < 0 .and. aboard[2, i] < 0 .and. aboard[3, i] < 0 .and. aboard[4, i] < 0 .and. aboard[5, i] < 0
						nwin := iboard 
						//msginfo ("Won! col " + typevalue2string(iboard, nwin, j, nnumber))
						nlastnumber := nnumber
						aputone (aboardswon, iboard, true)
					endif
				endif
				if lfound 
					exit
				endif
			next
			if lfound 
				exit
			endif
		next
		if nwin > 0 
			nsumwin += 1 
			if nsumwin == nboards 
				msginfo ("Won last!  " + typevalue2string(nwin, nnumber))
			else
				nwin := 0
			endif
		endif
	endif
next
return



function putall()
nwin  := 0
nsumwin := 0
aboardswon := acreateone(nboards, false)
for inumber := 1 upto alen(anumbers)
	nnumber := val(anumbers[inumber])
	macrofunc ("putnum", {nnumber})
	if nwin > 0 
		exit
	endif
next
return 

function calcresult()
aboard := aboards[nwin]
nsum := 0
for j := 1 upto 5
	for i := 1 upto 5
		if aboard[j,i] > 0
			nsum += aboard[j,i] 
		endif
	next 
next
					msginfo ("sum " + typevalue2string(nsum, nsum*nlastnumber))
return
export a

export cdir
export ninput 
export anumbers
export aboards
export nboards
export nwin 
export nsumwin 
export nlastnumber
export aboardswon
export inumber 