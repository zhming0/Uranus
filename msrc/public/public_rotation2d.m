function coor = Rotation(scr, a)
    RM = [cos(deg2rad(a)), -sin(deg2rad(a));
          sin(deg2rad(a)), cos(deg2rad(a))];
      
    coor = scr * RM;
end