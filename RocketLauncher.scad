use <Common.scad>

module DoubleCylinder(h=10, d1=10, d2=9, separation=6)
{
	hull()
	{
		cylinder(h=h, d=d1, center=true);
		mov(x=-separation) cylinder(h=h, d=d2, center=true);
	}
}

module OuterShell(h=10, d1=10, d2=9, separation=6)
{
	difference()
	{
		DoubleCylinder(h=h, d1=d1, d2=d2, separation=separation);
		DoubleCylinder(h=h+20, d1=d1-1, d2=d2-1, separation=separation);
		mov(x=-3,z=4) cube([3,20,4], center=true);
	}
}

module Core(h=12, d1=9.5, d2=8.5, separation=6)
{
	vy=2.3;
	difference()
	{
		DoubleCylinder(h=h, d1=d1, d2=d2);
		mov(z=h/2) for (i=[d1/2-2:-vy:-separation-d2/2+2]) mov(x=i) cylinder(h=2, d=1, center=true);
		mov(y=-1.6, z=h/2) for (i=[d1/2-3:-vy:-separation-d2/2+2]) mov(x=i) cylinder(h=2, d=1, center=true);
		mov(y=-3.2, z=h/2) for (i=[d1/2-2-vy:-vy:-d1/2]) mov(x=i) cylinder(h=2, d=1, center=true);
		mov(y=+1.6, z=h/2) for (i=[d1/2-3:-vy:-separation-d2/2+2]) mov(x=i) cylinder(h=2, d=1, center=true);
		mov(y=+3.2, z=h/2) for (i=[d1/2-2-vy:-vy:-d1/2]) mov(x=i) cylinder(h=2, d=1, center=true);
	}
	
}

module vents(length=15)
{
    for (advance=[0:2:length-8])
        mov(z=advance) 
        rot(x=60) rot(y=-30)
        difference() { cylinder(h=5.5,d=1.5); mov(z=3) cylinder(h=4,d=1); }
}

module RocketLauncher(h=10, d1=11, d2=9, separation=6)
{
	mov(x=-5) Attachment(angle=15, bottom=true);
	rot(y=90) OuterShell(h=h, d1=d1, d2=d2, separation=separation);
	rot(y=90) mov(z=-1.5) Core(h=h+2, d1=d1-0.5, d2=d2-0.5, separation=separation);
	mov(x=-6, z=-2) union()
	{
		vents();
		mirror([0,1,0]) vents();
	}
	rot(y=5) mov(x=-7, z=-4) 
	{
		cylinder(h=12, d1=d1*0.5, d2=d2*0.5);
		for (i=[1:1:10]) mov(z=i) cylinder(h=0.5, d=d1*0.6);
	}
}

RocketLauncher();