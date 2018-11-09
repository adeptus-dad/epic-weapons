use <Common.scad>

$fs = 0.1;
main_width = 6;
main_height = 8;

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
