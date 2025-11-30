function start_point(space, span, index, count) =
  (((space - (span * count)) / (count + 1)) * (index + 1)) + (index * span);

function center_circle_diameter(position, diameter) =
  position - (diameter / 2);
