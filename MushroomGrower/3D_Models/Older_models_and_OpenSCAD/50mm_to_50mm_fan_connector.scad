cube_x = 52; //Width of the base
cube_y = 52; //Length of the base
cube_z = 10; //Height of the base
hole_size = 49.5;  //The diameter of the hole on the box itself
fan_diameter = 48; //The diameter of the fan blade

cone_height = 5; //Height of the cone part
cylinder_height = 30; //Height of the straight pipe part
screw_z_offset = -1*(cube_z+1)/2; //Z offset for the screw holes
edge_length_hex = 4; //The intended length from the center to an edge
adjusted_radius = edge_length_hex * 2 / sqrt(3); //The adjusted 'cylinder' radius so the center to edge will be the edge_length_hex
nut_height = 4; //The height of the nut
wall_thickness = 2;

union() {
    //The cube base and the screw holes
    difference() {
        cube([cube_x,cube_y,cube_z], center=true); //Base cube
        cylinder(cube_z+1,d=fan_diameter, center = true, $fn=100); //Fan cutout
        
        //Screw cutouts
        translate([20,20,screw_z_offset]){
            cylinder(cube_z+1,d=5);
        }
        translate([20,-20,screw_z_offset]){
            cylinder(cube_z+1,d=5);
        }
        translate([-20,20,screw_z_offset]){
            cylinder(cube_z+1,d=5);
        }
        translate([-20,-20,screw_z_offset]){
            cylinder(cube_z+1,d=5);
        }
        
        //The nut holes
        translate([20, 20,cube_z/2 - nut_height]){
            rotate([0,0,15]){
                cylinder(r=adjusted_radius, h=nut_height + 0.1, $fn=6);
            }
        }
        translate([20, -20,cube_z/2 - nut_height]){
            rotate([0,0,45]){
                cylinder(r=adjusted_radius, h=nut_height + 0.1, $fn=6);
            }
        }
        translate([-20, 20,cube_z/2 - nut_height]){
            rotate([0,0,45]){
                cylinder(r=adjusted_radius, h=nut_height + 0.1, $fn=6);
            }
        }
        translate([-20, -20,cube_z/2 - nut_height]){
            rotate([0,0,15]){
                cylinder(r=adjusted_radius, h=nut_height + 0.1, $fn=6);
            }
        }
    }
    //Inverse cone section
    //We only have this section because without it, the nut holes would be partially covered 
    difference(){
        translate([0, 0, cube_z/2]){
            cylinder(cone_height, r1 = 24, r2 = hole_size/2, $fn=100);
        }
        
        translate([0, 0, cube_z/2 - 0.1]){
            cylinder(cone_height + 1, d = hole_size - wall_thickness+0.5, $fn=100);
        }
    }
    
    //Straight pipe section
    difference(){
        translate([0, 0, cone_height + cube_z/2 - 0.05]){
            cylinder(cylinder_height, d = hole_size, $fn=100);
        }
        
        translate([0, 0, cone_height + cube_z/2 - 0.15]){
            cylinder(cylinder_height + 0.2, d = hole_size - wall_thickness+0.5, $fn=100);
        }
    }
}
