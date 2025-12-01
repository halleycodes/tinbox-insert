use <functions.scad>
use <shapes.scad>

// goemetric params
r = 5;
p0 = [0, 100];
p1 = [100, 50];
amplitude = 25;

// iterative params
middle_hops = 15;
start = 0;
increment = 1 / (1 + middle_hops);
stop = 1;

for (i = [start : increment : stop]) {
  a = sine_path(p0, p1, A=amplitude, t=i);
  b = sine_path(p0, p1, A=amplitude, t=i+increment);

  hull() {
    translate([a[0], 0, a[1]])
      sphere(r);
    translate([b[0], 0, b[1]])
      sphere(r);
  }
}
