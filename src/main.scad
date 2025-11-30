use <functions.scad>
use <shapes.scad>

param_box_x = 161;
param_box_y = 49.5;
param_box_z = 22;
param_box_allow = 0;

param_wall_size = 1;
param_minow_size = 10;

box = [param_box_x, param_box_y, param_box_z] - static_vector(param_box_allow);

pen_slot_dims = [152, 18];
pen_hull_dims = pen_slot_dims + [0, 4];

pen_slot_pos = pen_positions(box, pen_slot_dims, param_wall_size);

// Position the ghost hull at the top, right in the middle
pen_hull_z = center_circle_diameter(box[2], pen_hull_dims[1]);
pen_hull_pos = pen_positions(box, pen_hull_dims, pen_hull_z);

mac_loop_vars = loop_increment_vars(0, 15, 1);
mac_offset = [0, (pen_slot_dims[1] / 2), 0];
mac_start = pen_slot_pos[0] + mac_offset;
mac_end = pen_slot_pos[1] + mac_offset;

echo(mac_loop_vars);
echo(pen_slot_pos);
echo(mac_start);
echo(mac_end);

difference() {
  translate([
    param_minow_size,
    param_minow_size,
    0
    ])
    rounded_box(box, param_minow_size);

  union() {
    for (i = [0:1]) {
      hull() {
        translate(pen_slot_pos[i])
          cigar_pen(pen_slot_dims);
        translate(pen_hull_pos[i])
          cigar_pen(pen_hull_dims);
      }
    }
  }
};