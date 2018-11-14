use <Common.scad>
use <RocketLauncher.scad>




n=8;


for (i=[0:n]) mov(y=i*15)
{
	mov(y=0) RocketLauncher();
	mov(x=-1.5, y=-2, z=-14.5) cube([1,17,1]);
}