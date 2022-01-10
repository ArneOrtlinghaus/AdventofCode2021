function Start()
cdir := "C:\prog\Adventofcode2021\day3"
ninput := 1
if ninput == 0
nbits := 5  
else 
nbits := 12
endif 
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2array(c, crlf)
nlena := alen(a)
return 

function calc()

ao2 := acreateone (nlena, true)
no2 := nlena
aco2 := acreateone (nlena, true)
nco2 := nlena
for j := 1 upto nbits 
	no2bit := 0
	nco2bit := 0
	for i := 1 upto alen(a)
		c := a[i]
		cb := substr(c, j, 1)
		if ao2[i]
			if cb == "1"
				no2bit += 1
			endif
		endif
		if aco2[i]
			if cb == "1"
				nco2bit += 1
			endif
		endif
	next
   lo2 := no2bit >= no2 - no2bit
	lco2 := nco2bit <	nco2 - nco2bit

	for i := 1 upto nlena 
		c := a[i]
		c := substr(c, j, 1) 
		
		if no2 > 1 .and. ao2[i] .and. ((lo2 .and. c == "0") .or. (!lo2 .and. c == "1"))
			aputone (ao2, i, false)
			no2 -= 1
		endif
		if nco2 > 1 .and. aco2[i] .and. ((lco2 .and. c == "0") .or. (!lco2 .and. c == "1"))
			aputone (aco2, i, false)
			nco2 -= 1
		endif
	next
	//msginfo (typevalue2string(j, lco2, nco2bit, aco2))
next

for i := 1 upto nlena 
	if ao2[i]
		co2 := a[i]
	endif
	if aco2[i]
		cco2 := a[i]
	endif
next
msginfo (typevalue2string(co2, cco2))  // "101011011101", "001110010111"   2781  919  2555739
return



export a
export nlena

export cdir
export ninput 

export nbits 
export abits 
export ao2
export aco2
export no2
export nco2