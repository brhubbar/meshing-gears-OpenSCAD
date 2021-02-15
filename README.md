# Meshing Gears OpenSCAD Library

Generate spur, helical, and herringbone gears with user-friendly inputs.

![3 meshed herringbone gears](./examples/3%20Gears.png)

## Motivation

Existing gear libraries require parameters that, while inherent to gear design,
make the design of gears that will properly mesh challenging for an unknowing
user.

In order for general spur gears to mesh, they must have identical pressure
angles and diametral pitches (as well as a few other conditions, but the
library takes care of those). If you're not sure what you just read, this
library may be right for you.

## Resolution

These modules interface with the core library involute_gears, hiding parameters 
that result in incompatible gears if set without proper background knowledge. 
Specifying the number of teeth sounds like a helpful setting, but it's actually 
not a very useful place to start, as it affects many other parameters that one 
wouldn't expect.

## Capabilities

Generate three types of gears sitting on the xy plane, centered on the
z-axis. All inputs are optional, and their meaning is explained in the
comments of each module.
```openscad
 spur_gear(pitch_diameter,
           bore_diameter,
           thickness,
           pressure_angle,
           diametral_pitch
           )
```

![Spur gear](./examples/Spur%20Gear.png)

```openscad
 herringbone_gear(pitch_diameter,
                   bore_diameter,
                   helix_angle,
                   thickness,
                   pressure_angle,
                   diametral_pitch
                   )
```

![Herringbone Gear](./examples/Herringbone%20Gear.png)

```openscad                   
 helical_gear(pitch_diameter,
               bore_diameter,
               helix_angle,
               thickness,
               pressure_angle,
               diametral_pitch
               )
```

![Helical Gear](./examples/Helical%20Gear.png)

The core library allows more inputs, such as hub size, rim size, etc., which
allow you to make prettier and more functional gears. 
These were left out for brevity of the input list, but can be exposed by
adding them to the modules below. To see the full list of input options,
go to `~\OpenSCAD\libraries\MCAD\involute_gears.scad` and check the
argument list of the module `gear`.

As always user friendliness limits functionality. For more information on
gear design, see *Kinematics, Dynamics, and Design of Machinery* by
K. J. Waldron, Chapters 10 and 11.

