Table table;
PFont font;
float lonp[] = new float[49];             //longitude position while marching
float latp[] = new float[49];             //latitude position while marching
int survive[] = new int[49];              //survivors
String dir[] = new String[49];            //direction of march
float div[] = new float[49];              //army division
float long_city[] = new float[22];        //longitude of city
float lat_city[] = new float[22];         //latitude of city
String city[] = new String[22];           //City Names
float temp_long[] = new float[11];        //Temperature Longitudes
float temp_lat[] = new float[11];         
float temp[] = new float[11];             //temperature
String month[] = new String[11];          //month
int days_spent[] = new int[11];           //Days spent
int day[] = new int[11];                  //Date
float mapLeftTop   = 22.578;              //map Image top left longitude
float mapRightBottom= 40.868;             //map Image Bottom Right Longitude
float mapRightTop    = 57.251;            //map Image Top Right Latitude
float mapLeftBottom = 51.880;             //map Image Bottom Left Latitude
int row=1;
int row1 = 1;
int row2 = 1;
int row3 =1;
int row4 = 1;
int i=0;
int j=0;
int k=0;
int l=0;
int m=0;
int q=0;
int r=0;


PImage backgroundImage; 
float mapWidth,mapHeight;
PFont Font;

void setup()
{
 size(2538,1228); //Dimensions of the Background Image
 smooth();
 noLoop();
 
 backgroundImage   = loadImage("map2.png");
 mapWidth  = 2538;
 mapHeight = 1228;
 table = loadTable("minard.csv");
 println("minard.csv");
 println(table.getRowCount() + " total rows in table"); 
}

void draw()
{
  font = loadFont("Georgia-BoldItalic-30.vlw");
  textFont(font, 20);
 
  tint(255, 30);   //blurring the background
  image(backgroundImage,0,0,mapWidth,mapHeight);
  
  while(table.getFloat(row,8) != -99 && table.getFloat(row,9) != -99){
  PVector p = Lat_Long_ToCordinate(new PVector(table.getFloat(row,8),table.getFloat(row,9)));
  float x1 = p.x;
  float y1 = p.y;
  lonp[j] = x1; 
  j++;
  latp[i] = y1; 
  i++;
survive[k] = table.getInt(row,10);
dir[k] = table.getString(row,11);
div[k] = table.getFloat(row,12);
k++;
row++;
}

while(table.getFloat(row1,0) !=-99){  
 PVector p = Lat_Long_ToCordinate(new PVector(table.getFloat(row1,0),table.getFloat(row1,1)));
  float x2 = p.x;
  float y2 = p.y;
  
 long_city[l] = x2;
 lat_city[l] = y2;
 city[l] = table.getString(row1,2);
 l++;
 row1++;
  
}  
  
for(i=0;i<latp.length-2;i++){
  ellipse(lonp[i],latp[i],5,10);
}

  
strokeWeight(110); 
for(i=0;i<latp.length-2;i++){  //for Drawing the map
  if(dir[i].equals("A") && div[i] == 1){
    stroke(#FFAF00);
  }
  else if(dir[i].equals("R") && div[i] == 1){
    stroke(#FFED93);
  }
    
  
  
  if(dir[i].equals("A") && div[i] == 2){
    stroke(#0089AD);
 }
  else if(dir[i].equals("R") && div[i] == 2){
   stroke(#A4E8FA);
  }
  
  if(dir[i].equals("A") && div[i] == 3){
    stroke(#007101);
  }
  else if(dir[i].equals("R") && div[i] == 3){
   stroke(#B1F766);
 }
  
  
  strokeWeight(survive[i]/3600);   //adjusting width according to number of survivors
  if(div[i] == div[i+1]){
  line(lonp[i],latp[i],lonp[i+1],latp[i+1]);    //Line Drawing for Co-ordinates

  }
}  //end map rough sketch
for(i=0;i<city.length-2;i++) {   // plotting city names
  fill(#0E0F03);
  ellipse(long_city[i], lat_city[i],9,9);
  fill(50);
  textSize(15); 
text(city[i], long_city[i], lat_city[i]);
} //end city names



for(i=0;i<latp.length-2;i = i+2){   //plotting survivors
   fill(50);
 textSize(10.5);
   pushMatrix();
  translate((lonp[i]+lonp[i+1])/2,(latp[i]+latp[i+1])/2);
  rotate(HALF_PI);
  translate(-(lonp[i]+lonp[i+1])/2,-(latp[i]+latp[i+1])/2);
  text(survive[i],(lonp[i]+lonp[i+1])/2,(latp[i]+latp[i+1])/2);
  popMatrix();
   
}  //end survivors

//temperature
while(table.getFloat(row4,3) !=-99){
 PVector p = Lat_Long_ToCordinate(new PVector(table.getFloat(row4,3),54));
  float x4 = p.x;
  float y4 = p.y;
 
  temp_long[r] = x4;
  temp_lat[r] = y4;
temp[r] = table.getFloat(row4,4);
days_spent[r] = table.getInt(row4,5);
month[r] = table.getString(row4,6);
day[r] = table.getInt(row4,7);

  
  r++;
  row4++;
}
stroke(50);
strokeWeight(4);
float y5 = temp_lat[0]+30; 
for(i=0;i<temp_long.length-2;i++){
  ellipse(temp_long[i],y5,5,5);
  
  y5 = temp_lat[0]+30+abs(temp[i+1]*10);
  
}

line(temp_long[0],y5,temp_long[1],y5+abs(temp[1]*10)); //first temp line
for(i=1;i<temp.length-3;i++){   // temp line loop
line(temp_long[i],y5+abs(temp[i]*10),temp_long[i+1],y5+abs(temp[i+1]*10));  
} ///temp end


line(temp_long[0]+100,1150,temp_long[0]+100,temp_lat[0]); // Y-axis
line(temp_long[8],1150,temp_long[0]+100,1150); //x-axis
textSize(20);
stroke(10);
text("Temperature During Retreat", temp_long[8]+690, 890);
for(i=0;i<temp.length-2;i++){
  ellipse(temp_long[i],1150,5,10);                    // x-axis ellipse
  ellipse(temp_long[0]+100,y5+abs(temp[i]*10),10,5); //Y-axis ellipse
  textSize(20);
  
  pushMatrix();
  translate(temp_long[0]+190,830);
  rotate(HALF_PI);
  translate(-(temp_long[0]+190),-830);
  text("Degrees Celcius", temp_long[0]+190,830); //Temp label
  popMatrix();
  text("Date",temp_long[8]+800,1200);  // Date label
  textSize(14);
  text(month[i]+" "+day[i],temp_long[i],1180); //month values
  text(int(temp[i]), temp_long[0]+120,y5+abs(temp[i]*10)); //temp Values
}

for(int i=0;i<6;i++){   //labelling the colors
if(i==0){
fill(#FFAF00);
rect(1600,50,20,20);
stroke(0);
fill(50);
textSize(20);
text("Army Advancing (Division 1) ", 1650, 65);

}
if(i==1){
  fill(#FFED93);
rect(1600,80,20,20);
stroke(0);
fill(50);
textSize(20);
text("Army Retreating (Division 1)", 1650, 95);
}

if(i==2){
  fill(#0089AD);
rect(1600,110,20,20);
stroke(0);
fill(50);
textSize(20);
text("Army Advancing (Division 2)", 1650, 125);
}

if(i==3){
  fill(#A4E8FA);
rect(1600,140,20,20);
stroke(0);
fill(50);
textSize(20);
text("Army Retreating (Division 2)", 1650, 155);
}

if(i==4){
  fill(#007101);
rect(1600,170,20,20);
stroke(0);
fill(50);
textSize(20);
text("Army Advancing (Division 3) ", 1650, 185);
}

if(i==5){
  fill(#B1F766);
rect(1600,200,20,20);
stroke(0);
fill(50);
textSize(20);
text("Army Retreating (Division 3) ", 1650, 215);
}

}  //end labelling
save("minard_visualization.jpg");
} //end draw

public PVector Lat_Long_ToCordinate(PVector mapLocation)
{
    return new PVector(mapWidth*(mapLocation.x-mapLeftTop)/(mapRightBottom-mapLeftTop),
                       mapHeight - mapHeight*(mapLocation.y-mapLeftBottom)/(mapRightTop-mapLeftBottom));
}
