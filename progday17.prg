function Start()
cdir := "C:\prog\Adventofcode2021\day17"
ninput := 1
if ninput == 0
xtmin :=20
xtmax := 30
ytmin :=-10
ytmax := -5
else
//target area: x=29..73, y=-248..-194
xtmin :=29
xtmax := 73
ytmin :=-248
ytmax := -194
endif
atries := {}
return

function calc(vx0, vy0)
ymax := -9999999
x := 0
y := 0
vx := vx0
vy := vy0
lfound := false
do while x < xtmax .and. y > ytmin
	x += vx 
	y += vy 
	ymax := max(ymax, y)
	if vx > 0
		vx-= 1
	endif
	vy -= 1
	if between (x, xtmin, xtmax) .and. between (y, ytmin, ytmax)
		lfound := true
	endif
enddo
if !lfound 
	ymax := -9999999
endif
return ymax

function calcstartgrid()
n := 0
atries := {}
vxp := 1
for ix := 1 upto 73
	vyp := -248
	for iy := 1 upto 700
		ymaxp := macrofunc("calc",{vxp, vyp})
		if ymaxp > -999999
			n += 1
		endif
		//AAdd (atries, {vxp, vyp, ymaxp})
		vyp += 1
	next
	vxp += 1
next 
//ymaxmax := macrofunc("calcnum")
msginfo (typevalue2string(n))
return n // ymaxmax

function calcmax ()
ymaxmax := -99999999
for i := 1 upto alen(atries)
	ymaxmax := max(ymaxmax, atries[i,3])
next
return ymaxmax

function calcnum ()
n := 0
for i := 1 upto alen(atries)
	if atries[i,3]  > -9999999
		n += 1
	endif
next
return n

export cdir
export ninput 

export x
export y
export vx
export vy
export xtmin
export xtmax
export ytmin
export ytmax
export atries
