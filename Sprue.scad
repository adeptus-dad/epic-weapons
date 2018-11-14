use <Common.scad>
use <Plasma.scad>
use <Multilaser.scad>

n=4;


for (i=[0:n]) mov(y=i*20)
{
	mov(y=0) PlasmaCannon();
	mov(y=10) Multilaser();
	mov(x=-11, y=-2, z=13) cube([1,22,1]);
	mov(x=6, y=-2, z=-14) cube([1,22,1]);
}
