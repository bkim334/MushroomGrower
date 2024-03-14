cube_x = 52; //Width of the base
cube_y = 52; //Length of the base
cube_z = 5; //Height of the base
hole_size = 49.5;  //The diameter of the hole on the box itself
fan_diameter = 47; //The diameter of the fan blade

cone_height = 5; //Height of the cone part
cylinder_height = 30; //Height of the straight pipe part
screw_z_offset = -1*(cube_z+1)/2; //Z offset for the screw holes
slit_length = 3; //Lmao

post_width = 8;
post_lwh = [post_width, post_width,10]; //The dimensions of the corner posts

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
        translate([hole_size/2,0,cube_z + 2]){
            rotate([0,90,0]){
                cylinder(5,d = 7, center = true, $fn = 200);
            }
        }
        
        translate([0,hole_size/2,cube_z + 2]){
            rotate([90,0,0]){
                cylinder(5,d = 7, center = true, $fn = 200);
            }
        }
        
        //groove
        translate([0,0,cylinder_height - 8]){
            cylinder(2,d = fan_diameter + 0.5,center = true, $fn=200);
        }
            
    }
    
    //Corner posts
    //+x+y
    translate([cube_x/2,cube_y/2 - post_width,cube_z/2]){
        rotate([0,0,90]){
            difference(){   
                rotate([0,0,0]){
                    cube(post_lwh);
                }
                translate([0,0,-1]){
                    rotate([0,0,45]){
                        cube(16);
                    }
                }
                    
            }
        }
    }
    //-x-y
    translate([-cube_x/2,-cube_y/2 + post_width,cube_z/2]){
        rotate([0,0,-90]){
            difference(){   
                rotate([0,0,0]){
                    cube(post_lwh);
                }
                translate([0,0,-1]){
                    rotate([0,0,45]){
                        cube(16);
                    }
                }
                    
            }
        }
    }
    //-x+y
    translate([-cube_x/2+post_width,cube_y/2,cube_z/2]){
        rotate([0,0,180]){
            difference(){   
                rotate([0,0,0]){
                    cube(post_lwh);
                }
                translate([0,0,-1]){
                    rotate([0,0,45]){
                        cube(16);
                    }
                }
                    
            }
        }
    }
    //+x-y
    translate([cube_x/2-post_width,-cube_y/2,cube_z/2]){
        rotate([0,0,0]){
            difference(){   
                rotate([0,0,0]){
                    cube(post_lwh);
                }
                translate([0,0,-1]){
                    rotate([0,0,45]){
                        cube(16);
                    }
                }
                    
            }
        }
    }
    
}
