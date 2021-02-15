// Generate spur, helical, and herringbone gears with user-friendly inputs.
//
// In order for general spur gears to mesh, they must have identical pressure
// angles and diametral pitches (as well as a few other conditions, but the
// library takes care of those). These modules interface with the core library
// involute_gears, hiding parameters that result in incompatible gears if set
// without proper background knowledge. Specifying the number of teeth sounds
// like a helpful setting, but it's actually not a very useful place to start,
// as it affects many other parameters that one wouldn't expect.
//
// Generate three types of gears sitting on the xy plane, centered on the
// z-axis. All inputs are optional, and their meaning is explained in the
// comments of each module.
//  spur_gear(pitch_diameter,
//            bore_diameter,
//            thickness,
//            pressure_angle,
//            diametral_pitch
//            )
//  herringbone_gear(pitch_diameter,
//                    bore_diameter,
//                    helix_angle,
//                    thickness,
//                    pressure_angle,
//                    diametral_pitch
//                    )
//  helical_gear(pitch_diameter,
//                bore_diameter,
//                helix_angle,
//                thickness,
//                pressure_angle,
//                diametral_pitch
//                )
//
// The core library allows more inputs, such as hub size, rim size, etc.
// These were left out for brevity of the input list, but can be exposed by
// adding them to the modules below. To see the full list of input options,
// go to `~\OpenSCAD\libraries\MCAD\involute_gears.scad` and check the
// argument list of the module `gear`.
//
// As always user friendliness limits functionality. For more information on
// gear design, see `Kinematics, Dynamics, and Design of Machinery` by
// K. J. Waldron, Chapters 10 and 11.
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

include <MCAD/involute_gears.scad>

herringbone_gear();

module spur_gear(pitch_diameter=100,
                    bore_diameter=10,
                    thickness=10,
                    pressure_angle=20,
                    diametral_pitch=1
                    ){
  // Generate a classic spur gear.
  //
  // Inputs
  // ------
  //  pitch_diameter -- effective diameter in mm of the gear when meshed with
  //                    another gear, as though the two gears were cylinders
  //                    rolling against each other. dp in math notation.
  //  bore_diameter -- diameter of the hole in the center of the gear in mm.
  //  thickness -- thickness of the gear in mm.
  //  pressure_angle -- angle of contact between the gear teeth. 20 and 25
  //                    degrees are standard angles.
  //  diametral_pitch -- normalized measure of pitch in number of teeth per
  //                     pitch diameter. Coarse gears range from 1 to 20, fine
  //                     gears from 20 to 200. Pd in math notation.
  helical_gear(pitch_diameter=pitch_diameter,
                bore_diameter=bore_diameter,
                helix_angle=0,
                thickness=thickness,
                pressure_angle=pressure_angle,
                diametral_pitch=diametral_pitch
              );
}


module herringbone_gear(pitch_diameter=100,
                        bore_diameter=10,
                        helix_angle=15,
                        thickness=10,
                        pressure_angle=20,
                        diametral_pitch=1
                        ){
  // Generate a herringbone gear.
  //
  // Inputs
  // ------
  //  pitch_diameter -- effective diameter in mm of the gear when meshed with
  //                    another gear, as though the two gears were cylinders
  //                    rolling against each other. dp in math notation.
  //  bore_diameter -- diameter of the hole in the center of the gear in mm.
  //  helix_angle -- angle of the gear teeth, measured from parallel with the
  //                 shaft on which the gear would ride. psi in math notation.
  //                 An angle of 90 results in infinite twist, which OpenSCAD
  //                 will just ignore. An angle greater than 90 results in
  //                 the gear twisting in the opposite direction.
  //  thickness -- thickness of the gear in mm.
  //  pressure_angle -- angle of contact between the gear teeth. 20 and 25
  //                    degrees are standard angles.
  //  diametral_pitch -- normalized measure of pitch in number of teeth per
  //                     pitch diameter. Coarse gears range from 1 to 20, fine
  //                     gears from 20 to 200. Pd in math notation.

  // Generate two helical gears at half thickness, mirrored together to form
  // a herringbone.
  helical_gear(pitch_diameter=pitch_diameter,
                bore_diameter=bore_diameter,
                helix_angle=helix_angle,
                thickness=thickness/2,
                pressure_angle=pressure_angle,
                diametral_pitch=diametral_pitch
              );
  // Generate a copy, mirrored about the z axis.
  mirror([0, 0, 1])
  helical_gear(pitch_diameter=pitch_diameter,
                bore_diameter=bore_diameter,
                helix_angle=helix_angle,
                thickness=thickness/2,
                pressure_angle=pressure_angle,
                diametral_pitch=diametral_pitch
              );
}


module helical_gear(pitch_diameter=100,
                    bore_diameter=10,
                    helix_angle=15,
                    thickness=10,
                    pressure_angle=25,
                    diametral_pitch=1
                    ){
  // Generate a helical gear.
  //
  // This is the most general case, as a herringbone is simply two helical
  // gears, and a spur gear is a helical gear with 0 helix angle. Thus, the
  // actual interfacing to the core library is done here.
  //
  // Inputs
  // ------
  //  pitch_diameter -- effective diameter in mm of the gear when meshed with
  //                    another gear, as though the two gears were cylinders
  //                    rolling against each other. dp in math notation.
  //  bore_diameter -- diameter of the hole in the center of the gear in mm.
  //  helix_angle -- angle of the gear teeth, measured from parallel with the
  //                 shaft on which the gear would ride. psi in math notation.
  //                 An angle of 90 results in infinite twist, which OpenSCAD
  //                 will just ignore. An angle greater than 90 results in
  //                 the gear twisting in the opposite direction.
  //  thickness -- thickness of the gear in mm.
  //  pressure_angle -- angle of contact between the gear teeth. 20 and 25
  //                    degrees are standard angles. 25 is a standard pressure
  //                    angle for coarse and fine gears (Pd = 1 to 200).
  //  diametral_pitch -- normalized measure of pitch in number of teeth per
  //                     pitch diameter. Coarse gears range from 1 to 20, fine
  //                     gears from 20 to 200. Pd in math notation.

  // Calculate the number of teeth.
  // N = dp * Pd
  //  N -- number of teeth.
  //  dp -- pitch diameter (approximate effective diameter of gear if it were a
  //        cylinder rolling against another cylinder (as opposed to meshed with
  //        another gear)).
  //  Pd -- diametral pitch, the number of teeth per unit of pitch diameter.
  //        This normalizes the pitch so that coarseness can be assessed for any
  //        gear diameter. This can be translated to curvilinear distance between
  //        teeth on the pitch circle (circule with radius dp) by pc = pi/Pd.

  // We need N to be an integer, and cp to be a constant.
  // Gears are more commonly spec'd by Pd, the diametral pitch, where Pd = N/dp
  // It is convenient to follow this standard, because we can then specify a
  // diametral pitch, Pd, such that N = Pd*dp is an integer for all gears.
  N = diametral_pitch * pitch_diameter;
  // Non-integer N will lead to a gap on the gear, which won't work.
  assert(floor(N)==N, "Number of teeth (N = Pd * dp) is not an integer. Try
    making pitch diameter (dp) and diametral pitch (Pd) both integers.");

  // Calculate the `twist` parameter which defines the angle of the teeth.
  // twist is used in a linear_extrude, which is the degrees of rotation
  // that the part goes through during extrusion. This means a `twist` of 45
  // will result in a tooth whose top surface will be 90 degrees around the
  // gear from where its bottom surface begins.
  //
  // For small angles of twist, the arc along which that twist occurs can be
  // approximated as a straight line with length twist*radius, making a regular
  // triangle where the helix angle, psi, can be related to the degree of twist
  // and the vertical displacement along that twist in an approximation:
  //    tan(psi) = twist * pi/180 * pitch_diameter/2 / thickness
  //
  // This can be broken down into infinitesimal pieces by taking a fraction of
  // the total twist and a fraction of the total thickness. I'm pretty sure
  // this approach shows that the approximation apples for all angles, as
  // the triangle can be stretched out and flattened without changing the base
  // angle. This is, however, still an approximation as the angle changes
  // with radius, meaning the helix angle is only correct at the radius used
  // to calculate twist.. in this case, the pitch radius.
  twist = tan(helix_angle) * thickness * 180 / pi / (pitch_diameter/2);
  echo("Degree of twist: ", twist);

  gear(number_of_teeth=N,
        diametral_pitch=diametral_pitch,
        hub_diameter=0,
        bore_diameter=bore_diameter,
        pressure_angle=pressure_angle,
        twist=twist,
        gear_thickness = thickness,
        rim_thickness = thickness
      );
}
