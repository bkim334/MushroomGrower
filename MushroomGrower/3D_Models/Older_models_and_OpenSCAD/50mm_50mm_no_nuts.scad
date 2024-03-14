cube_x = 52; //Width of the base
cube_y = 52; //Length of the base
cube_z = 5; //Height of the base
hole_size = 49.5;  //The diameter of the hole on the box itself
fan_diameter = 47; //The diameter of the fan blade

cone_height = 5; //Height of the cone part
cylinder_height = 30; //Height of the straight pipe part
screw_z_offset = -1*(cube_z+1)/2; //Z offset for the screw holes
slit_length = 3; //Lmao

union() {
    //The cube base and the screw holes
    difference() {
        cube([cube_x,cube_y,cube_z], center=true); //Base cube
        cylinder(cube_z+1,d=fan_diameter, center = true, $fn=200); //Fan cutout
        
        //Screw cutouts
        translate([20,20,screw_z_offset]){
            cylinder(cube_z+1,d=5, $fn=200);
        }
        translate([20,-20,screw_z_offset]){
            cylinder(cube_z+1,d=5, $fn=200);
        }
        translate([-20,20,screw_z_offset]){
            cylinder(cube_z+1,d=5, $fn=200);
        }
        translate([-20,-20,screw_z_offset]){
            cylinder(cube_z+1,d=5, $fn=200);
        }
    }
    //Straight pipe section
    difference(){
        translate([0, 0, cube_z/2 - 0.05]){
            cylinder(cylinder_height, d = hole_size, $fn=200);
        }
        
        translate([0, 0, cube_z/2 - 0.15]){
            cylinder(cylinder_height + 0.2, d = fan_diameter, $fn=200);
        }
        
        //Wire cutout
        translate([hole_size/2,0,cube_z]){
            cube([1,slit_length,2*cylinder_height + 0.1], center = true);
        }
        translate([0,hole_size/2,cube_z]){
            cube([slit_length,1,2*cylinder_height + 0.1], center = true);
        }
    }
    
    //Wire cutout
    
}
