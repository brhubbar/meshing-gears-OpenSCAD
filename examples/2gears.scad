// Generate two gears at a specified center-to-center distance.
//
// This is an example use of spur_helical_herringbone_gear.scad.
//
// Revisions:
//  v0.0.1: First release.
//
// Copyright (C) 2021  Ben Hubbard
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//
// Ben Hubbard / v0.0.1

include <../src/meshing_gears.scad>


/* [Global] */
// Gear type.
gear_type = 3; // [1:spur, 2:helical, 3:herringbone]

// Which gear would you like to see?
part = 0; // [0:both, 1:first gear, 2:second gear]

/* [Gear Ratio] */
// Gear ratio (d1 / d2).
gear_ratio = 0.5;

// Center-to-center distance, mm.
center_to_center = 75;

/* [Gear Specs] */
// Gear pitch (diametral picth, teeth/diameter; larger is finer).
diametral_pitch = 1; // [1:1:20]

// Bore diameter of gear 1, mm.
bore1 = 10;

// Bore diameter of gear 2, mm.
bore2 = 10;

// Gear thickness, mm.
thickness = 20;

// Helix angle, deg (for helical and herringbone gears).
helix_angle = 15;

/* [Hidden] */
print_part();

// gear_ratio = pitch_diameter1 / pitch_diameter2.
// center_to_center = (pitch_diameter1 + pitch_diameter2)/2.
pitch_diameter2 = (2*center_to_center) / (gear_ratio + 1);
pitch_diameter1 = 2*center_to_center - pitch_diameter2;

module print_part() {
  if (part == 1) {
    gear_1();
  }
  if (part == 2) {
    gear_2();
  }
  if (part == 0) {
    gear_1();
    translate([center_to_center, 0, 0]) gear_2();
  }
}

module gear_1() {
  if (gear_type == 1) {
    spur_gear(pitch_diameter=pitch_diameter1,
              bore_diameter=bore1,
              thickness=thickness,
              diametral_pitch=diametral_pitch
            );
  }

  else if (gear_type == 2) {
    helical_gear(pitch_diameter=pitch_diameter1,
              bore_diameter=bore1,
              thickness=thickness,
              helix_angle=helix_angle,
              diametral_pitch=diametral_pitch
            );
  }

  else if (gear_type == 3) {
    herringbone_gear(pitch_diameter=pitch_diameter1,
              bore_diameter=bore1,
              thickness=thickness,
              helix_angle=helix_angle,
              diametral_pitch=diametral_pitch
            );
  }
}

module gear_2() {
  if (gear_type == 1) {
    spur_gear(pitch_diameter=pitch_diameter2,
              bore_diameter=bore2,
              thickness=thickness,
              diametral_pitch=diametral_pitch
            );
  }

  else if (gear_type == 2) {
    helical_gear(pitch_diameter=pitch_diameter2,
              bore_diameter=bore2,
              thickness=thickness,
              helix_angle=helix_angle,
              diametral_pitch=diametral_pitch
            );
  }

  else if (gear_type == 3) {
    herringbone_gear(pitch_diameter=pitch_diameter2,
              bore_diameter=bore2,
              thickness=thickness,
              helix_angle=helix_angle,
              diametral_pitch=diametral_pitch
            );
  }
}
