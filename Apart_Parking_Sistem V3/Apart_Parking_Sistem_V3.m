clear; clc; close all;
imPark=imread('park.png');
imRed=imread('red.png');
imRedR=imread('redR.png');
imBlue=imread('blue.png');
imBlueR=imread('blueR.png');
imGreen=imread('green.png');
imGreenR=imread('greenR.png');
imYellow=imread('yellow.png');
imYellowR=imread('yellowR.png');
imbey=imread('beykoz.jpg');


f = figure('WindowState','maximized');

image(imPark)
axis off

Park=zeros(1,40);

plakalar = ["26AR394" "35F4125" "26EH589" "34AF149" "43PT936" "35S8484" "26EH589"];
A=text(10, 50, " ", 'Color', 'g', 'FontSize', 15, 'FontWeight', 'bold');
B=text(-350, 800, " ", 'Color', 'b', 'FontSize', 10, 'FontWeight', 'bold');
C=text(-350, 900, " ", 'Color', 'b', 'FontSize', 10, 'FontWeight', 'bold');
D=text(-300, 400, " ", 'Color', 'k', 'FontSize', 10, 'FontWeight', 'bold');
count=0;
%arduino tanimla
a=arduino();
clear a;
a = arduino('COM3', 'Uno', 'Libraries', 'Servo');
s = servo(a, 'D4')
clear s;
s = servo(a, 'D4', 'MinPulseDuration', 700*10^-6, 'MaxPulseDuration', 2300*10^-6)

 writeDigitalPin(a, 'D7', 0);
 writeDigitalPin(a, 'D8', 1);

camList = webcamlist;
cam = webcam(1);
H=axes('position',[0.02, 0.93, 0.1,0.07,]);
image(imbey);
H.YAxis.Visible = 'off';
H.XAxis.Visible = 'off';
    
while 1
    


    flag=1;
   
     
    while flag==1
        
        img=snapshot(cam);
        
        H=axes('position',[0.02, 0.81, 0.1,0.11,]);
        image(img)
        H.YAxis.Visible = 'off';
        H.XAxis.Visible = 'off';
        
        text('String',"INSIDE CAR LIST",'position',[11500,0]);
        text('String',">--DEVELOPED BY HILAL SARAR©--<",'FontSize', 25,'position',[4100,5500],'Color', 'r');
        text('String',"APART PARKING LOT v3.0",'FontSize', 35,'position',[4200,-250],'Color', 'k','FontWeight', 'bold');
        set(B,'String',"REMAINIG   SLOT= "+(40-count));
        set(C,'String',"OCCUPIED   SLOT= "+count);
        
       % np="26AR394";
       
        
        np=number_plate(img);
        
        if length(np) == 0
            np="x";
        end
        
        np=convertCharsToStrings(np)
        set(D,'String',np);
        
        % strlength(np);
        if strlength(np)==7
            for i=1:length(plakalar);

                if strcmp(np,plakalar(i))
                    flag=0;
                end
            end
        end
        pause(0.2);
    end
    


    count=count+1;
    pos=count*150;
    text('String',count+" > "+np,'position',[11500,pos]);
    
    
    %servo aç cont ba??
    
for angle = 0.5:-0.01:0
    writePosition(s, angle);
    current_pos = readPosition(s);
    current_pos = current_pos*180;
    %fprintf('Current motor position is %d degrees\n', current_pos);
    pause(0.01);
end
 writeDigitalPin(a, 'D7', 1);
 writeDigitalPin(a, 'D8', 0);
    %servo son
    
    
    % closePreview(cam);
     
     
    H=axes('position',[0.02, 0.81, 0.1,0.11,]);
    image(img)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    
    
    
    
    
    %ans='Red';
    
    
    
    sec = randi([1 40],1,1);
    
    while (Park(sec)==1)
        sec = randi([1 40],1,1);
    end
    
    sira=ceil(sec/10);
    r=rem(sec,10)
    if r==0;r=10;end
     
    Park(sec)=1;
    %set(A,'String',np+" Plakali aracinizi "+ans+"  Kolonundaki, "+r+". Siraya Park Edin.");
    
    switch sira
        case 1
            
            set(A,'String',np+" Plakali aracinizi RED  Kolonundaki, "+r+". Siraya Park Edin.", 'color','red');
            addCar(r,sira, imRed,imRedR)
         
        case 2
            
            set(A,'String',np+" Plakali aracinizi GREEN  Kolonundaki, "+r+". Siraya Park Edin.", 'color','Green');
            addCar(r,sira, imGreen,imGreenR)
          
        case 3
            
            set(A,'String',np+" Plakali aracinizi YELLOW  Kolonundaki, "+r+". Siraya Park Edin.", 'color','Yellow');
            addCar(r,sira, imYellow,imYellowR)
            
        case 4
            
            set(A,'String',np+" Plakali aracinizi BLUE  Kolonundaki, "+r+". Siraya Park Edin.", 'color','Cyan');
            addCar(r,sira, imBlue,imBlueR)
            
    end
    
    
    
    
    text(1, 145, np, 'Color', 'w', 'FontSize', 12, 'FontWeight', 'bold');
    
    % pause(3);
    
    
    %clear('cam');
    clear('img');
    
    %servo kapatba?
    writeDigitalPin(a, 'D7', 0);
    writeDigitalPin(a, 'D8', 1);
    for angle = 0:0.01:0.5
        writePosition(s, angle);
        current_pos = readPosition(s);
        current_pos = current_pos*180;
        % fprintf('Current motor position is %d degrees\n', current_pos);
        pause(0.01);
    end
    
end






function addCar(n,nn,im,imR)
x=[0.275,0.3365,0.3950,0.4576,0.5168,0.570,0.6352,0.6964,0.7536,0.8128];
Y=[0.72 0.57 0.35 0.2];
hiz=0.02;
if nn==1
    H=axes('position',[0.05, 0.46, 0.04,0.10,]);
    image(imR)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.05:0.005:0.2
        H.Position(1)= v;
        pause(hiz)
    end
    H.Position(1)= H.Position(1) +1000;
    H=axes('position',[0.2, 0.46, 0.04,0.10,]);
    image(im)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.46:0.01:0.82
        H.Position(2)= v;
        pause(hiz)
    end
    H.Position(1)= H.Position(1) +1000;
    H=axes('position',[0.2, 0.82, 0.04,0.10,]);
    image(imR)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.2:0.005:x(n)
        H.Position(1)= v;
        pause(hiz)
    end
    H.Position(1)= H.Position(1) +1000;
    H=axes('position',[x(n), 0.82, 0.04,0.10,]);
    image(im)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.82:-0.01:Y(nn)
        H.Position(2)= v;
        pause(hiz)
    end
end


if nn==2
    
    H=axes('position',[0.05, 0.46, 0.04,0.10,]);
    image(imR)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.05:0.005:x(n)
        H.Position(1)= v;
        pause(hiz)
    end
    
    H.Position(1)= H.Position(1) +1000;
    H=axes('position',[x(n), 0.46, 0.04,0.10,]);
    image(im)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.46:0.01:Y(nn)
        H.Position(2)= v;
        pause(hiz)
    end
    
    
end

if nn==3
    
    H=axes('position',[0.05, 0.46, 0.04,0.10,]);
    image(imR)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.05:0.005:x(n)
        H.Position(1)= v;
        pause(hiz)
    end
    
    H.Position(1)= H.Position(1) +1000;
    H=axes('position',[x(n), 0.46, 0.04,0.10,]);
    image(im)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.46:-0.01:Y(nn)
        H.Position(2)= v;
        pause(hiz)
    end
end





if nn==4
    H=axes('position',[0.05, 0.46, 0.04,0.10,]);
    image(imR)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.05:0.005:0.2
        H.Position(1)= v;
        pause(hiz)
    end
    H.Position(1)= H.Position(1) +1000;
    H=axes('position',[0.2, 0.46, 0.04,0.10,]);
    image(im)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.46:-0.01:0.109
        H.Position(2)= v;
        pause(hiz)
    end
    H.Position(1)= H.Position(1) +1000;
    H=axes('position',[0.2, 0.109, 0.04,0.10,]);
    image(imR)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.2:0.005:x(n)
        H.Position(1)= v;
        pause(hiz)
    end
    H.Position(1)= H.Position(1) +1000;
    H=axes('position',[x(n), 0.109, 0.04,0.10,]);
    image(im)
    H.YAxis.Visible = 'off';
    H.XAxis.Visible = 'off';
    
    for v=0.115:0.01:Y(nn)
        H.Position(2)= v;
        pause(hiz)
    end
end

end
















