epsilon = 0.01;

module rounded_box(box_size, minow) {
  minkowski() {
    cube([
        box_size[0] - (minow * 2),
        box_size[1] - (minow * 2),
        box_size[2] - (epsilon * 2)
      ]);
    cylinder(r = minow, h = epsilon);
  }
}

module cigar_pen(pen_slot) {
  translate([
      pen_slot[1] / 2,
      pen_slot[1] / 2,
      pen_slot[1] / 2
    ])
    rotate([0, 90, 0])
      hull()
        union() {
          sphere(d = pen_slot[1]);
          translate([
            0, 0,
              pen_slot[0] - pen_slot[1]
            ])
            sphere(d = pen_slot[1]);
        }
}