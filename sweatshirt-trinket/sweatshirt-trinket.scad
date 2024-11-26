trim = 6.5;

resize([19.4,25.4,1.42*3]){
        intersection(){
            import("sweatshirt.stl");
            translate([0,0,trim/2]){
                cube([150,200,trim], center=true);
            }
    }
}