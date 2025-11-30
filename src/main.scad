use <functions.scad>
use <shapes.scad>

param_box_x = 161;
param_box_y = 49.5;
param_box_z = 22;
param_box_allow = 0;

param_wall_size = 1;
param_minow_size = 10;

box_dimensions = [param_box_x, param_box_y, param_box_z];
bd_allow = [
  for (i = box_dimensions) i - param_box_allow
  ];

pen_slot_dims = [152, 18];
pen_hull_dims = [152, 22];

pen_slot_transformation = [for (i = [0:1]) [
  start_point(bd_allow[0], pen_slot_dims[0], 0, 1),
  start_point(bd_allow[1], pen_slot_dims[1], i, 2),
  param_wall_size
  ]];

// Hull
pen_hull_z = center_circle_diameter(bd_allow[2], pen_hull_dims[1]);

pen_hull_transformation = [for (i = [0:1]) [
  start_point(bd_allow[0], pen_hull_dims[0], 0, 1),
  start_point(bd_allow[1], pen_hull_dims[1], i, 2),
  pen_hull_z
  ]];

difference() {
  translate([
    param_minow_size,
    param_minow_size,
    0
    ])
    rounded_box(bd_allow, param_minow_size);

  union() {
    for (i = [0:1]) {
      hull() {
        translate(pen_slot_transformation[i])
          cigar_pen(pen_slot_dims);
        translate(pen_hull_transformation[i])
          cigar_pen(pen_hull_dims);
      }
    }
  }
};