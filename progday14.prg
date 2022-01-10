function Start()
cdir := "C:\prog\Adventofcode2021\day14"
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
arules := {}
ar := string2array(c, crlf)
c := ar[1]
for i := 1 upto len(c)
aadd (a, {substr(c, i, 1), false})
next
for i := 2 upto alen(ar)
	c := ar[i]
	c := alltrim(c)
	//CH -> B
	a2 := string2array(c,  " -> ")
	aadd (arules, {substr(a2[1], 1, 1), substr(a2[1], 2, 1), a2[2]})
next
return

function add()
i := 1
do while i < alen(a)
	if !a[i,2] .and. !a[i+1,2]
		for irules := 1 upto alen(arules)
			if a[i,1] == arules[irules,1] .and. a[i+1,1] == arules[irules,2]
				aein(a, i+1, {arules[irules,3], true})
				exit
			endif
		next
	endif
	i += 1
enddo
for i := 1 upto alen(a)
	aputtwo(a, i, 2, false)
next
return
function addall()
nadd := 0
for i := 1 upto 10
	nadd += 1
	macrofunc("Add", {})
next
return

function count()
ac := {}
for i := 1 upto alen(a)
	c := a[i,1] 
	npos := ascanmacro (ac, c, 1)
	if npos > 0
		n := ac[npos,2]
		aputtwo (ac, npos, 2, n+1)
	else 
		aadd (ac, {c, 1})
	endif
next
asorttwodim(ac, 2, false)
n := ac[1,2]-ac[alen(ac),2]
return

function display()
cd := ""
for i := 1 upto alen(a)
	c := a[i,1] 
	cd += c 
next 
return
export cdir
export ninput 
export a
export arules 
export ac
export nadd
export cd
export n