$fs = 0.1;
main_width = 6;
main_height = 8;



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

module Attachment (depth=6.5, angle=25, bottom=false)
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
