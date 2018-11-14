use <Common.scad>

$fs = 0.1;
main_width = 6;
main_height = 8;

barrel_radius = 1.2;

module LaserBarrel(length=24)
{
	difference()
	{
		union()
		{
			cylinder(h=length, r1=barrel_radius+0.2, r2=barrel_radius);
			mov(z=length-2) CylinderCog(length=2.5, r=barrel_radius+0.3);
			mov(z=6) CylinderCog(length=12, r=barrel_radius+0.5, n=3);
		}
		mov(z=length-2) cylinder(h=3, d=1.1);
	}
}

module LaserAssembly()
{
	cylinder(h=9, d=2.5);
	for (adv=[0:1:8]) mov(z=adv) cylinder(h=0.5, d=4.2);
	mov(x=-main_height*0.25) 					LaserBarrel();
	mov(x=main_height*0.2, y=main_width*0.25) 	LaserBarrel();
	mov(x=main_height*0.2, y=-main_width*0.25) 	LaserBarrel();
}



module Multilaser()
{
	mov(x=-4) Attachment();
	Attachment(bottom=true);
	rot(y=90) WeaponBody();
	rot(y=90) mov(z=0.5) LaserAssembly();
}

Multilaser();