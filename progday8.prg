function Start()
cdir := "C:\prog\Adventofcode2021\day8"
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
nmax := 0
af := {}
al := {}
for i := 1 upto alen(a)
	c := a[i]
	a2 := string2array(c, "|")
	c1 := a2[1]
	c1 := alltrim(c1)
	c2 := a2[2]
	c2 := alltrim(c2)
	a1 := string2array(c1, " ")
	a2 := string2array(c2, " ")
	aadd (af, a1)
	aadd (al, a2)
next
na := len(af)

return

function decodelenths(iline)
c2 := ""
c3 := ""
c4 := ""
c5a := ""
c5b := ""
c5c := ""
c6a := ""
c6b := ""
c6c:= ""
a := af[iline]
for j := 1 upto alen(a)
	c := a[j]
	nlen := len(c)
	if nlen == 2
		c2 := c 
	elseif nlen == 3
		c3 := c 
	elseif nlen == 4
		c4 := c 
	elseif nlen == 5
		if empty(c5a)
			c5a := c
		elseif empty(c5b)
			c5b := c
		else 
			c5c := c 
		endif
	elseif nlen == 6
		if empty(c6a)
			c6a := c
		elseif empty(c6b)
			c6b := c
		else 
			c6c := c 
		endif
	endif
next
return

function decodes()
crest := "abcdefg"

//c2 c3 c4 c5a c5b c5c c6a c6b c6c
// S6: Teil von Länge 2 und immer in Länge 6 
// s6: 1.Zeichen von c2 in  c6a und c6b und c6c? ja, ansonsten das zweite Zeichen
s6 := substr(c2, 1,1)
if !instr(s6, c6a) .or. !instr(s6, c6b) .or. !instr(s6, c6c) 
	s6 := substr(c2, 2,1)
endif
crest := strtran(crest, s6, "")

// S3: Teil von Länge 2 und nicht S6 
c := c2 
c := strtran(c, s6, "")
s3 := c
crest := strtran(crest, s3, "")

// S1: Teil von Länge 3 und nicht S3 und nicht S6 
c := c3
c := strtran(c, s6, "")
c := strtran(c, s3, "")
s1 := c
crest := strtran(crest, s1, "")

// S2: Teil von Länge 4 ohne S3, S6 und immer in Länge 6
c := c4 
c := strtran(c, s6, "")
c := strtran(c, s1, "")
c := strtran(c, s3, "")
s2 := substr(c, 1,1)
if !instr(s2, c6a) .or. !instr(s2, c6b) .or. !instr(s2, c6c) 
	s2 := substr(c, 2,1)
endif
crest := strtran(crest, s2, "")

// s4: Teil von Länge 4 ohne S3, S6, s2 
c := c4
c := strtran(c, s6, "")
c := strtran(c, s3, "")
c := strtran(c, s2, "")
s4 := c
crest := strtran(crest, s4, "")

// S7: Immer Teil von Länge 6 und nicht die anderen
s7 := substr(crest, 1,1)
s5 := substr(crest, 2,1)
if !instr(s7, c6a) .or. !instr(s7, c6b) .or. !instr(s7, c6c) 
	s7 := substr(crest, 2,1)
	s5 := substr(crest, 1,1)
endif
// S5: rest
return 

function decodenumber (c)
if len(c) == 2
	nnum := 1
elseif len(c) == 3
	nnum := 7
elseif len(c) == 4
	nnum := 4
elseif len(c) == 7
	nnum := 8
elseif len(c) == 5 // 2, 3, 5
	if instr(s2, c)
		nnum := 5
	elseif instr(s5, c)
		nnum := 2
	else 
		nnum := 3
	endif
elseif len(c) == 6 // 0, 6, 9
	if !instr(s5, c)
		nnum := 9
	elseif instr(s3, c)
		nnum := 0
	else 
		nnum := 6
	endif
endif
return nnum

function decodel (iline)
a := al[iline]
nnum := 0
for j := 1 upto alen(a)
	c := a[j]
	nnum := nnum * 10
	nnuma := macrofunc ("decodenumber", {c})
	nnum += nnuma
next 
return nnum

function sumall ()
nsum := 0
for i := 1 upto na 
	macrofunc("decodelenths", {i})
	macrofunc("decodes", {})
	nnum := macrofunc("decodel", {i})
	nsum += nnum 
next
return

export cdir
export ninput 
export af
export al
export na
export nsum
export c2 
export c3 
export c4 
export c5a 
export c5b 
export c5c 
export c6a 
export c6b 
export c6c
export s1
export s2
export s3
export s4
export s5
export s6
export s7