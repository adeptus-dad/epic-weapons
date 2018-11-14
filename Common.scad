$fs = 0.1;
main_width = 6;
main_height = 8;
sprue=true;


module mov(x=0, y=0, z=0)
{
    translate([x, y, z])
    children();
}

module rot(x=0, y=0, z=0)
{
    rotate([x, y, z])
    children();
}

module CylinderCog(length=10, r=5, n=6)
{
	difference()
	{
		cylinder(h=length, r=r, center=true);
		for (i = [0:n]) rot(z=i*360/n)
		difference()
		{
			rot(z=-90/n) cube(length+2*r);
			rot(z=+90/n) cube(length+2*r);
		}
	}
}


module Attachment(depth=6.5, angle=25, bottom=false)
{
    rot(y=-angle+(bottom?180:0))
    {
        difference()
        {
            union() 
            {
                mov(z=depth) cylinder(h=4, d1=3, d2=2.36);
                cylinder(h=depth, d=5.36);
            }
            mov(z=depth-2) rotate_extrude(convexity = 10)
                translate([3, 0, 0])
                circle(r = 0.6);
        }
		if (sprue)
		{
			cylinder(h=15, d=1);
		}
    }
}


module WeaponBody(length=17)
{
    chamf = 1.5;
    tank = 8;
    difference()
    {
        union()
        {
            linear_extrude(height=length, center=true) offset(delta=chamf, chamfer=true) 
                square(size=[main_height-2*chamf, main_width-2*chamf], center=true);
            cube(size=[main_height+1, 2, length-3], center=true);
        }
        mov(x=-10, z=8) intersection()
        {
            cube(size=[20, 20, 20], center=true);
            rot(y=45) cube(size=[20, 20, 20], center=true);
        }
    }
    
    mov(z=-length/2-2) intersection() 
    {
        cylinder(h=tank, d1=main_width+2, d2=main_width+2); 
        mov(z=tank) rot(x=90) sphere(r=tank, $fn=96);
        sphere(r=tank);
    }
	
	minkowski()
	{
		sphere(0.3);
		mov(z=-10.6) cylinder(h=2, d=1.5);	
	}
	
	mov(z=-9.8) for (i=[0:30:360]) rot(z=i) mov(y=3) sphere(0.3);
    
	mov(x=-0.8,z=-2.5) for (i=[0:1:3]) mov(z=i) cube([2,main_width+1,0.6], center=true);
	
    module vents()
    {
        for (advance=[0:2:length-8])
            mov(z=advance) 
            rot(x=120) rot(y=30)
            difference() { cylinder(h=4.5,d=1.5); cylinder(h=12,d=1, center=true); }
    }
    
    vents();
    mirror([0,1,0]) vents();
}

mov(x=-4) Attachment();
Attachment(bottom=true);
rot(y=90) WeaponBody();
