// Customizer script to generate a set of 3 meshing gears. Designed as an
// example of the use of meshing_gears for the creationg of spur, helical,
// or herringbone gears.


include <../src/meshing_gears.scad>

// Distance between the two big gears.
dist_big = 100;
// Distance between the big gear and the smaller drive gear.
dist_small = 70;

// Pitch diameter for each gear. Gear 3 is the smaller drive gear.
dp1 = dist_big;
dp2 = dist_big;
dp3 = (dist_small - dp2/2) * 2;

// Angle of the helix referenced to the shaft.
helix_angle = 15;

// Bore diameters, mm.
bore1 = 20;
bore2 = 20;
bore3 = 15;

// Gear thickness, mm.
thickness = 10;

// Render options
// --------------
//  0 -- generate all three gears, for visualization.
//  1 -- generate the first gear, for printing.
//  2 -- generate the second gear, for printing.
//  3 -- generate the third gear, for printing.
generate = 0;


//==========END OF CUSTOMIZATION CODE==========\\
// Generate the requested model.
if (generate == 0) {
  // Place gear 2 (the intermediate gear) at the origin.
  translate([(dp1+dp2)/2, 0, 0]) gear1();
  gear2();
  translate([0, (dp2+dp3)/2, 0]) gear3();
}
else if (generate == 1) {
  gear1();
}
else if (generate == 2) {
  gear2();
}
else if (generate == 3) {
  gear3();
}


// Store the actual function calls in modules to prevent repeated code.
module gear1(){
  herringbone_gear(pitch_diameter=dp1,
              bore_diameter=bore1,
              helix_angle=helix_angle,
              thickness = thickness
            );
}

module gear2(){
  herringbone_gear(pitch_diameter=dp2,
              bore_diameter=bore2,
              helix_angle=helix_angle,
              thickness = thickness
             );
}

module gear3(){
  herringbone_gear(pitch_diameter=dp3,
              bore_diameter=bore3,
              helix_angle=helix_angle,
              thickness = thickness
             );
}
