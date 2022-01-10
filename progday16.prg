function Start()
cdir := "C:\prog\Adventofcode2021\day16"
ninput := 1
macrofunc("Read")
macrofunc("Decode")
macrofunc("getvalueall")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ""
cx := ffileread(cfile)
if ninput == 0
//cx := "D2FE28"
//cx := "38006F45291200"
//cx := "C0015000016115A2E0802F182340"
//cx := "8A004A801A8002F478"
//cx := "C0015000016115A2E0802F182340"
//cx := "620080001611562C8802118E34"
//cx := "EE00D40C823060" 
//cx := "A0016C880162017C3686B18A3D4780"
cx := "9C0141080250320F1802104A08"
endif
for i := 1 upto len(cx)
	c1 := substr(cx, i, 1)
	if c1 == "0"
		c += "0000"
	elseif c1 == "1"
		c += "0001"
	elseif c1 == "2"
		c += "0010"
	elseif c1 == "3"
		c += "0011"
	elseif c1 == "4"
		c += "0100"
	elseif c1 == "5"
		c += "0101"
	elseif c1 == "6"
		c += "0110"
	elseif c1 == "7"
		c += "0111"
	elseif c1 == "8"
		c += "1000"
	elseif c1 == "9"
		c += "1001"
	elseif c1 == "A"
		c += "1010"
	elseif c1 == "B"
		c += "1011"
	elseif c1 == "C"
		c += "1100"
	elseif c1 == "D"
		c += "1101"
	elseif c1 == "E"
		c += "1110"
	elseif c1 == "F"
		c += "1111"
	endif 
next
nc := len(c)
return

function decode()
npos := 1
a := {}
nlevel := 1
do while npos <= nc
   macrofunc("Readcommand", {})	
enddo
return

function Readcommand()
nposstart := npos
cx := substr(c, npos, 3)
nversion := macrofunc("bittonum", cx)
npos += 3
cx := substr(c, npos, 3)
ncommand := macrofunc("bittonum", cx)
npos += 3
if ncommand == 4 // literal
	cnum := ""
	lgoon := true 
	nposstartnum := npos
	do while lgoon 
		c1 := substr(c, npos, 1)
		c5 := substr(c, npos, 5)
		cnum += substr(c, npos+1, 4)
		if c1 == "0"
			lgoon := false
		elseif c1 == "1"
			nop()
		else 
			lgoon := false
		endif
		npos += 5
	enddo
	ndiff := npos-nposstartnum
	nnum := macrofunc("bittonum", cnum)
	aadd (a, {nversion, ncommand, nposstart, npos, nnum, nil})
//	msginfo ("lit"+typevalue2string(nversion, ncommand, nposstart, nlevel, cnum))
else 
    //If the length type ID is 0, then the next 15 bits are a number that represents the total length in bits of the sub-packets contained by this packet.
    //If the length type ID is 1, then the next 11 bits are a number that represents the number of sub-packets immediately contained by this packet.
	c1 := substr(c, npos, 1)
	npos += 1
	if c1 =="0"
		cnum := substr(c, npos, 15)
		npos += 15
	else
		cnum := substr(c, npos, 11)
		npos += 11
	endif
	nnum := macrofunc("bittonum", cnum)
	aadd (a, {nversion, ncommand, nposstart, npos, nnum, c1=="0"})
//	msginfo ("op"+typevalue2string(nversion, ncommand, nposstart, nlevel, cnum))
endif
return

function getvalueall()
cprot := ""
n := macrofunc("getvalueop", {1})
msginfo (typevalue2string(n)+crlf+cprot)
return

function getvalueop(nastart)
//aadd (a, {nversion, ncommand, nposstart, npos, nnum, c1=="0"})
nversion := a[nastart,1]
ncommand := a[nastart,2]
npos := a[nastart,4]
nnum := a[nastart,5]
nastartmax := nastart
asubs := {}
lbitlength := a[nastart,6]
cprot += "startop: "+ typevalue2string(nastart, nversion, ncommand, nnum)+crlf
n := 0
if ncommand == 4
	n := nnum
else 
	if lbitlength
		asubs := macrofunc("getvaluessubbitlength", {nastart+1, a[nastart,4], nnum})
	else 
		asubs := macrofunc("getvaluessubnumpack", {nastart+1, a[nastart,4], nnum})
	endif
    //Packets with type ID 0 are sum packets 
    //Packets with type ID 1 are product packets  
    //Packets with type ID 2 are minimum packets 
    //Packets with type ID 3 are maximum packets - 
    //Packets with type ID 5 are greater than packets - their value is 1 if the value of the 
	 // first sub-packet is greater than the value of the second sub-packet; 
	 // otherwise, their value is 0. These packets always have exactly two sub-packets.
    //Packets with type ID 6 are less than packets - their value is 1 if the value 
	 // of the first sub-packet is less than the value of the second sub-packet; 
	 // otherwise, their value is 0. These packets always have exactly two sub-packets.
    //Packets with type ID 7 are equal to packets - their value is 1 if 
	 // the value of the first sub-packet is equal to the value of the second 
	 // sub-packet; otherwise, their value is 0. These packets always have exactly two sub-packets.
	if alen(asubs) >= 1
		if ncommand == 0
			n := asubs[1][1]
			for isub := 2 upto alen(asubs) 
				n += asubs[isub][1]
			next
		elseif ncommand == 1 
			n := asubs[1][1]
			for isub := 2 upto alen(asubs) 
				n := n * asubs[isub][1]
			next
		elseif ncommand == 2
			n := asubs[1][1]
			for isub := 2 upto alen(asubs) 
				n := min (n, asubs[isub][1])
			next
		elseif ncommand == 3
			n := asubs[1][1]
			for isub := 2 upto alen(asubs) 
				n := max (n, asubs[isub][1])
			next
		elseif ncommand == 5
			if asubs[1][1] > asubs[2][1]
				n := 1
			else 
				n := 0
			endif
		elseif ncommand == 6
			if asubs[1][1] < asubs[2][1]
				n := 1
			else 
				n := 0
			endif
		elseif ncommand == 7
			if asubs[1][1] == asubs[2][1]
				n := 1
			else 
				n := 0
			endif
		endif
		for isub := 1 upto alen(asubs) 
			nastartmax := max(nastartmax, asubs[isub,2])
		next
	endif
endif
cprot += "return: " + typevalue2string(nastart, nversion, ncommand, nnum, n, asubs, nastartmax)+crlf
n := n * 1.0
return {n, nastartmax}

function getvaluessubbitlength(nastartsubs, nposstartsubs, nnum)
asub := {} 
npos := 0
cprot += "getvaluessubbitlength "+typevalue2string(nastartsubs, nposstartsubs, nnum, nposstartsubs+nnum)+crlf
for i := 1 upto 9999
	an := macrofunc("getvalueop", {nastartsubs})
	AAdd (asub, an)
	nastartsubs := an[2]
	cprot += "getvaluessubbitlength b "+typevalue2string(nastartsubs)+crlf
	if a[nastartsubs,4] == nposstartsubs+nnum 
		exit
	endif
	nastartsubs +=1
next
return asub 

function getvaluessubnumpack(nastartsubs, nposstartsubs, nnum)
asub := {} 
for i := 1 upto nnum 
	an := macrofunc("getvalueop", {nastartsubs})
	AAdd (asub, an)
	nastartsubs := an[2]+1
next
return asub 

function bittonum (cnum)
nnum := 0
n := 1
do while n <= len(cnum)
	nnum := nnum * 2.0
	c1 := substr(cnum, n, 1)
	if c1 == "1"
		nnum += 1.0
	endif
	n += 1
enddo
return nnum

function sum()
nsum := 0
for i := 1 upto alen(a)
	nsum += a[i,1]
next 
return nsum

export cdir
export ninput 
export c
export nc
export npos 
export a
export cprot
