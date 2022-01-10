function Start()
cdir := "C:\prog\Adventofcode2021\day10"
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
	aadd (a, c)
next

return
//    If a chunk opens with (, it must close with ).
//    If a chunk opens with [, it must close with ].
//    If a chunk opens with {, it must close with }.
//    If a chunk opens with <, it must close with >.

function checksyntax(c)
astack := {}
for i := 1 upto len(c)
	c1 := substr(c, i, 1)
	if instr (c1, "([{<" )
		AAdd (astack, c1)
	elseif instr (c1, ")]}>")
		nlen := len(astack)
		clast := astack[nlen]
		if   (c1 == ")" .and. clast == "(");
		.or. (c1 == "]" .and. clast == "[");
		.or. (c1 == "}" .and. clast == "{");
		.or. (c1 == ">" .and. clast == "<") 
			AAus (astack, nlen)
		else 
			return c1
		endif
	endif
next 
return ""

function checkall()
cres := ""
nnum := 0
for i := alen(a) downto 1 
	c := a[i]
	c1 := macrofunc ("checksyntax", {c})
	cres += c1
	if c1 == ")"
		nnum += 3
   elseif c1 == "]"
		nnum += 57
   elseif c1 == "}"
		nnum += 1197
   elseif c1 == ">"
		nnum += 25137
	endif
	if !Empty(c1)
		AAus (a, i)
	endif
next 
return 

function completeall()
cres := ""
nnum := 0
acomplete := {}
for i := 1 upto alen(a) 
	c := a[i]
	macrofunc ("checksyntax", {c})
	macrofunc ("complete", {})
	aadd (acomplete, ccomplete)
next 
return 

function complete()
ccomplete := ""
for i := alen(astack) downto 1
	clast := astack[i]
	if   clast == "("
		ccomplete +=")" 
	elseif clast == "["
		ccomplete += "]"
	elseif clast == "{"
		ccomplete += "}"
	elseif clast == "<"
		ccomplete += ">"
	endif
next 
return 

// ): 1 point.
//    ]: 2 points.
//    }: 3 points.
//    >: 4 points.
//    Multiply the total score by 5 to get 0, then add the value of ] (2) to get a new total score of 2.
//    Multiply the total score by 5 to get 10, then add the value of ) (1) to get a new total score of 11.
//    Multiply the total score by 5 to get 55, then add the value of } (3) to get a new total score of 58.
//    Multiply the total score by 5 to get 290, then add the value of > (4) to get a new total score of 294.

function getcompletescore(c)
n := 0.0
for i := 1 upto len(c)
	n := n * 5+0.0
	c1 := substr(c, i, 1)
	if c1 == ")"
		n += 1.0
	elseif c1 == "]"
		n += 2.0
	elseif c1 == "}"
		n += 3.0
	elseif c1 == ">"
		n += 4
	endif
next 
return n

function Getcompletescoresall()
acompletescore := {}
for i := 1 upto alen(acomplete) 
	c := acomplete[i]
	n := macrofunc ("getcompletescore", {c})
	aadd (acompletescore, n)
next 

return 

export cdir
export ninput 
export a
export na
export astack
export cres 
export num 
export ccomplete
export acomplete
export acompletescore

function resul()
ASortTwoDim(ACOMPLETESCORE, 0, true)
n := alen(ACOMPLETESCORE) -1
n := n /2 + 1
u := ACOMPLETESCORE[n]
return
