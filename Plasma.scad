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



module PlasmaBarrel(length=20)
{
    mink = 2;
    difference()
    {
        union()
        {
            mov(x=-main_height/2+main_width/2) 
                mov(z=length-3) cylinder(h=3.3, d=2.5);
            minkowski()
            {
                hull()
                {
                    mov(x=-main_height/2+main_width/2) cylinder(h=length-2*mink, d=main_width-2*mink);
                    mov(x=main_height/2-mink-1) cylinder(h=length-2*mink, d=1);
                }
                scale([1, 1, 2]) sphere(r=mink);
            }
            
        }
        hull()
        {
            mov(x=-main_height/2, z=main_width/2+1) rot(x=90) 
                cylinder(h=main_width+2, d=main_width, center=true);
            mov(x=-main_height/2, z=length-main_width/2-4.2) rot(x=90) 
                cylinder(h=main_width+2, d=main_width, center=true);
        }
        for (angle = [0, 60, 120, 180]) mov(x=-main_height/2+main_width/2) rot(z=angle) mov(y=2.3) 
             mov(z=length-3) cylinder(h=4, d=0.8); 
        mov(x=-main_height/2+main_width/2) 
             mov(z=length-3) cylinder(h=4, d=1.5);
    }
    mov(x=-main_height/2+main_width/2) 
        for (advance=[0:0.8:length-3])
            mov(z=advance)
            minkowski()
            {
                union()
                {
                    cylinder(h=0.5, d1=main_width-1, d2=0);
                    rot(x=180) cylinder(h=0.5, d1=main_width-1, d2=0);
                }
                sphere(r=0.2, center=true);
            }
}

mov(x=-4) Attachment();
Attachment(bottom=true);
rot(y=90) WeaponBody();
rot(y=90) mov(z=0.5) PlasmaBarrel();
