%Conexión a Turtlebot a traves de la Jetson

%% Comando para conexión de la Jetson 

 setenv('ROS_IP','192.168.43.100')          %IP de la computadora
 rosinit('http://192.168.43.178:11311');    %Conexión al nodo maestro   
 rostopic list                              % Comando para revisar los topicos

%% Inicializacion de los topicos


%Topico de la velocidad
robotCmd=rospublisher("/cmd_vel_mux/input/navi","DataFormat","struct");
velMsg=rosmessage(robotCmd);

%Velocidad lineal y angular maximas
V_max = 0.18; W_max = 2.5;

%Topico de la odometria
odomSub=rossubscriber("/odom","DataFormat","struct");
reset=rospublisher('/mobile_base/commands/reset_odometry')

%Reset de la odometria
odom_res=rosmessage('std_msgs/Empty')
send(reset,odom_res)

%Lectura del tiempo de la Jetson
startTime=rostime('now');
startTime=startTime.Sec
currentTime=rostime('now');
currentTime=currentTime.Sec
limite=rostime('now');
limite=limite.Sec;
restart=rostime('now');
restart=restart.Sec;

%% Inicializacion de variables

%Inicializacion de variables
Xhd=1;                                  %2m Alfrente 
Yhd=0.5;                                  %0.5 

%Variables para guardar los datos
vectorx=zeros(1,4000);
vectory=zeros(1,4000);
vectorxh=zeros(1,4000);
vectoryh=zeros(1,4000);
i=1;


%% Ejecucion del código durante 60 segundos

while currentTime-startTime < 30

        %Obtencion  de la odometria del robot
        odomMsg=receive(odomSub,3);
        pose=odomMsg.Pose.Pose;
        x=pose.Position.X;
        y=pose.Position.Y;
        z=pose.Position.Z;

        %Guardar la posicion en x y en y
        vectorx(i)=x;
        vectory(i)=y;

        %Obtencion de los angulos
        quat=[pose.Orientation.X,pose.Orientation.Y,pose.Orientation.Z,pose.Orientation.W];
        eulZYX = quat2eul(quat);

        %inicializacion de variables para el control
        k=0.2; a=1; b =0.5;
        h=0.1;
        X0=0;
        Y0=0;
        tetha=eulZYX(3);

        %Punto h
        xh = x+h*cos(tetha)
        yh = y+h*sin(tetha)
        vectorxh(i)=xh;
        vectoryh(i)=yh;

        %Control a un punto
            ex = xh-Xhd;  ey = yh-Yhd;
            Ux = -k*ex;  Uy =-k*ey;
            V= Ux*cos(tetha)+Uy*sin(tetha);
            W=-Ux*sin(tetha)/h+Uy*cos(tetha)/h;


            %Evitar la saturacion en las velocidades
            if (abs(V)>V_max)
                V = V_max*abs(V)/V;
                fprintf("Saturacion en V\t")
            end
            if (abs(W)>W_max)
                W = W_max*abs(W)/W;
                fprintf("Saturacion en W\t")
            end
            velMsg.Linear.X=V;
            velMsg.Angular.Z=W;
            send(robotCmd,velMsg);

        %Obtener tiempos nuevos
        Time=rostime('now');
        currentTime=Time.Sec;
        tiempo=currentTime-startTime;
        restart=rostime('now');
        restart=restart.Sec;
        i=i+1
end
figure(2)

plot(vectorx(1:i-1),vectory(1:i-1),'r','LineWidth',2)
xlim([-1.5,1.5])
ylim([-1.5, 1.5])
grid on
title('Posición')
set(gca, 'FontName','Times New Roman','FontSize', 14,  'FontAngle', 'italic')
set(gcf,'color','w')
xlabel('Posición en x (m)')
ylabel('Posición en y (m)')
