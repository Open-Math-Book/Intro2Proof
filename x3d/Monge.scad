$fn=50;

module planar_circle(rd=50) {
  color(c=[0,0,0,1]) {
    difference() {
      cylinder(h=.1, r=rd+.5);
      translate([0,0,-.1]) cylinder(h=.3, r=rd-.5);
    };
  };
};

module segment(p,q) {
    dx=q[0]-p[0];
    dy=q[1]-p[1];
  rp = sqrt( pow( dx, 2) + pow(dy , 2));
  //  off = dx < 0 ? 180 : 0;
  long = atan2((q[1]-p[1]),(q[0]-p[0]));
    echo(rp, dx, dy, long);
  color(c=[0,0,0,1]) translate([p[0],p[1],0])  rotate([0,0,long]) rotate([0,90,0])  translate([0,0,rp/2]) cube([.1,1,rp], true);
}


//translate([100,40,0]) planar_circle(rad=30);

module hemisphere(x=0,y=0,rad=50) {
  translate([x,y,0]) {
    planar_circle(rd=rad);
    /*color(c=[1,0,0,.75]) {
      intersection() {
        sphere(r=rad);
        translate([0,0,2*rad-.1]) cube(4*rad, true);
      }
    }*/
  }
};

module tangent_cone(x1=0,y1=0,x2=100,y2=40,b=60, a=30) {
    dx=x2-x1;
    dy=y2-y1;
    d=sqrt(dx*dx+dy*dy);
    ux=dx/d;
    uy=dy/d;
    l=d*a/(b-a);
    s=(b-a)/d;
    c=cos(asin(s));
    t=s/c;
    segment(p=[x1-b*ux-uy*(b/c+b*t),y1-b*uy+ux*(b/c+b*t) ], q=[x2+l*ux,y2+l*uy]);
    segment(p=[x1-b*ux+uy*(b/c+b*t),y1-b*uy-ux*(b/c+b*t) ], q=[x2+l*ux,y2+l*uy]);
    color(c=[1,1,0,.5]) {
      translate([x1,y1,0]) {
        rotate([0,0,atan2((y2-y1),(x2-x1))]) {
          intersection() {
            rotate([0,90,0]) translate([0,0,-b]) cylinder(r1=b/c+b*t, r2=0, h=b+l+d);
            translate([0,0,2*(l+d)]) cube(4*(l+d), true);
          }
        }
      }
    }
  }
  
//hemisphere(x=0, y=0, rad=60);

hemisphere(x=120, y=40, rad=30);
  
//hemisphere(x=50, y=150, rad=15);

//tangent_cone(x1=0,y1=0, x2=120, y2=40, b=60, a=30);

//tangent_cone(x1=0,y1=0, x2=50, y2=150, b=60, a=15);
  
//tangent_cone(x1=120,y1=40, x2=50, y2=150, b=30, a=15);



  
/* translate([100,40,0]) color(c=[1,0,0,.75]) {
    intersection() {
        sphere(r=30);
        translate([-100,-100,0]) cube([200,200,200], false);
    }
}

a=30;
b=60;
d=sqrt(100*100 + 40*40);
l=d*a/(b-a);
c=cos(asin((b-a)/d));
s=(b-a)/d;

echo(a,b,d,l,c,s);

color(c=[1,1,0,.5]) {
    rotate([0,0,atan(.4)]) intersection() {
        rotate([0,90,0]) cylinder(r1=b/c, r2=0, h=l+d);
        translate([0,0,2*(l+d)]) cube(4*(l+d), true);
    }
}
*/