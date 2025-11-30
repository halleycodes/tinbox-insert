function start_point(space, span, index, count) =
  (((space - (span * count)) / (count + 1)) * (index + 1)) + (index * span);

function center_circle_diameter(position, diameter) =
  position - (diameter / 2);

function static_vector(i) = [i, i, i];

function pen_positions(box, dims, z_offset) = [for (i = [0:1]) [
  start_point(box[0], dims[0], 0, 1),
  start_point(box[1], dims[1], i, 2),
  z_offset
  ]];

function map(x, in_min, in_max, out_min, out_max) =
      (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;

function loop_increment_vars(start, steps, stop) =
  [start, 1 / (steps + 1), stop];

function p0p1_to_dxyn(p0, p1) =
let (
  // vector
  dx = p1[0] - p0[0],
  dy = p1[1] - p0[1],

  // length of D is L
  L = sqrt(dx * dx + dy * dy),
  // direction vector
  d = [dx / L, dy / L],
  // normal vector. Perpendicular
  n = [-d[1], d[0]]
)
  [dx, dy, n];

function sine_path(p0, p1, A = 5, N = 0.5, t = 0) =
let(
  dxyn = p0p1_to_dxyn(p0, p1),
  dx = dxyn[0],
  dy = dxyn[1],
  n = dxyn[2],

  // move it along the vector
  base = [p0[0] + t * dx, p0[1] + t * dy],
  // move it along the normal
  bump = A * sin(360 * N * t) * n
)
  [base[0] + bump[0], base[1] + bump[1]];