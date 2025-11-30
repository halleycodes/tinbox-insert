use <functions.scad>
use <shapes.scad>

r = 5;
distance = 100;
height = 25;

middle_hops = 15;

start = 0;
increment = distance / (1 + middle_hops);
stop = distance - increment;

function map(x, in_min, in_max, out_min, out_max) =
      (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;

for (i = [0 : increment : stop]) {
  z1 = sin(map(i, 0, distance, 0, 180)) * height;
  z2 = sin(map(i + increment, 0, distance, 0, 180)) * height;

  hull() {
    translate([i, 0, z1])
      sphere(r);
    translate([i + increment, 0, z2])
      sphere(r);
  }
}
