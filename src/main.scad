use <functions.scad>
use <shapes.scad>

// params
param_box = [161, 49.5, 22];
param_box_allow = 0;
param_wall_size = 1;
param_minow_size = 10;
param_slot_dims = [152, 18];

// dims
box = param_box - static_vector(param_box_allow);
pen_slot_dims = param_slot_dims;
pen_hull_dims = pen_slot_dims + [0, 0];

// positions
pen_slot_pos = pen_positions(box, pen_slot_dims, param_wall_size);
// Position the ghost hull at the top, right in the middle
pen_hull_z = box[2] - (pen_hull_dims[1] / 2);
pen_hull_pos = pen_positions(box, pen_hull_dims, pen_hull_z);

// macaroni code. This will hull out the divider between the two slots
A = 5;
mac_loop_vars = loop_increment_vars(0, 15, 1);
mac_offset = [0, (pen_slot_dims[1] / 2), 0];
mac_start = pen_slot_pos[0] + mac_offset;
mac_end = pen_slot_pos[1] + mac_offset;

difference() {
  translate([
    param_minow_size,
    param_minow_size,
    0
    ])
    rounded_box(box, param_minow_size);

  union() {
    // hull out above
    for (i = [0:1]) {
      hull() {
        translate(pen_slot_pos[i])
          cigar_pen(pen_slot_dims);
        translate(pen_hull_pos[i])
          cigar_pen(pen_hull_dims);
      }
    }

    // hull out across
    hull() {
      translate(pen_hull_pos[0])
        cigar_pen(pen_hull_dims);
      translate(pen_hull_pos[1])
        cigar_pen(pen_hull_dims);
    }

    // hull out (in macaroni shape) between the slots.
    for (i = [mac_loop_vars[0] : mac_loop_vars[1] : mac_loop_vars[2] - mac_loop_vars[1]]) {
      a_pos = sine_path([mac_start[1], mac_start[2]], [mac_end[1], mac_end[2]], A=A, t = i);
      b_pos = sine_path([mac_start[1], mac_start[2]], [mac_end[1], mac_end[2]], A=A, t = i + mac_loop_vars[1]);
      hull() {
        translate([mac_start[0], a_pos[0], a_pos[1]] - mac_offset)
          cigar_pen(pen_slot_dims);
        translate([mac_start[0], b_pos[0], b_pos[1]] - mac_offset)
          cigar_pen(pen_slot_dims);
      }
    }
  }
};