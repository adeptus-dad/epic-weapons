use <Common.scad>

$fs = 0.1;
main_width = 6;
main_height = 8;

barrel_radius = 1.2;

module LaserBarrel(length=17)
{
	cylinder(h=length, d=2*radius);
}

module LaserAssembly()
{
	mov(x=-main_height*0.25) 					LaserBarrel();
	mov(x=main_height*0.2, y=main_width*0.25) 	LaserBarrel();
	mov(x=main_height*0.2, y=-main_width*0.25) 	LaserBarrel();
}

mov(x=-4) Attachment();
Attachment(bottom=true);
rot(y=90) WeaponBody();
rot(y=90) mov(z=0.5) LaserAssembly();
