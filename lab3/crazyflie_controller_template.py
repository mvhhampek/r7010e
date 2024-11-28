 #!/usr/bin/env python
 # license removed for brevity
import rospy
from std_msgs.msg import String
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist
from geometry_msgs.msg import PoseStamped
import time 
import numpy 
import math
xpos = 0
ypos = 0
zpos = 0
xref = 0
yref = 0
zref = 0
yawref = 0
qx = 0
qy = 0
qz = 0
qw = 0
d_yaw = 0
vx = 0
vy = 0
vz = 0
roll = 0
pitch = 0
yaw = 0
u_p = 0
u_r = 0
u_t = 0
u_y = 0




def quaternion_to_euler(x, y, z, w):

    t0 = +2.0 * (w * x + y * z)
    t1 = +1.0 - 2.0 * (x * x + y * y)
    roll = math.atan2(t0, t1)
    t2 = +2.0 * (w * y - z * x)
    t2 = +1.0 if t2 > +1.0 else t2
    t2 = -1.0 if t2 < -1.0 else t2
    pitch = math.asin(t2)
    t3 = +2.0 * (w * z + x * y)
    t4 = +1.0 - 2.0 * (y * y + z * z)
    yaw = math.atan2(t3, t4)
    return [roll, pitch, yaw]

####We read the odometry message from the motion capture system
def callback(data):
    global xpos, ypos, zpos, vx, vy, vz,roll, pitch, yaw, d_yaw
    xpos = data.pose.pose.position.x
    ypos = data.pose.pose.position.y
    zpos = data.pose.pose.position.z
    qx = data.pose.pose.orientation.x
    qy = data.pose.pose.orientation.y
    qz = data.pose.pose.orientation.z
    qw = data.pose.pose.orientation.w
    d_yaw = data.twist.twist.angular.z ##angular rate around the z-axis
    [roll, pitch, yaw] = quaternion_to_euler(qx,qy,qz,qw) ###Euler angles are easier to use than quaternions :) 

    vx = data.twist.twist.linear.x
    vy = data.twist.twist.linear.y
    vz = data.twist.twist.linear.z  



def controller():
    rospy.init_node('controller', anonymous=True)
    pub = rospy.Publisher('demo_crazyflie6/cmd_vel', Twist, queue_size=1) #Publisher to send control signals to the Crazyflie
    sub = rospy.Subscriber('/pixy/vicon/demo_crazyflie6/demo_crazyflie6/odom', Odometry, callback) ##Subscriber to get Vicon Data. The variables of the states are in the callback function.
    
    
    rate = rospy.Rate(20) # 20hz controller rate
    global xref, yref, zref, yawref
    xref = 0 ##This is a center-point in the aerial lab
    yref = 4
    zref = 1
    yawref = 0
    to_thrust = 0.6 #the take-off thrust, the ammount of thrust it takes to hover


    while not rospy.is_shutdown():

        
        ###Implement your controller. Use the data from Vicon, formulate a controller to reach your desired x,y,z,yaw references
        ------------------------------------
        
        
        
        
        
        ------------------------------------       
        ###Publish the Control Signals
        cmd_vel = Twist()
        cmd_vel.linear.x = u_p #pitch
        cmd_vel.linear.y = u_r #roll
        cmd_vel.linear.z = u_t #thrust
        cmd_vel.angular.z = u_y #yawrate
        pub.publish(cmd_vel)
        rate.sleep()
 
if __name__ == '__main__':
     try:
         controller()
     except rospy.ROSInterruptException:
         pass

