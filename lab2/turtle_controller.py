import rospy
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist
import math
import numpy
#Above are the required imports to run the script. "math" is a python module, while the others are ROS-related. Each message type used has to be imported (from your workspace) 

######INITIALIZING VARIABLES######
x_pos = 0 #x-pos, y-pos, and heading are the three "measurements" / variables you will use for the feedback in your controller
y_pos = 0
heading = 0

qx = 0
qy = 0
qz = 0
qw = 0



def quaternion_to_euler(x, y, z, w):
    ######NOT IMPORTANT. This function simply converts quaternions (how orientation is described by the simulator) to Euler angles where the yaw = the heading###### 
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


#The main loop (starting at line 66) will jump to this "callback function" whenever new odometry data is published by the gazebo simulator
def callback_odom(data):
    ######FROM THE GAZEBO SIMULATOR WE TAKE THE X,Y AND HEADING DATA######
    global x_pos, y_pos, heading
    x_pos = data.pose.pose.position.x 
    y_pos = data.pose.pose.position.y

    qx = data.pose.pose.orientation.x
    qy = data.pose.pose.orientation.y
    qz = data.pose.pose.orientation.z
    qw = data.pose.pose.orientation.w
    [roll, pitch, heading] = quaternion_to_euler(qx,qy,qz,qw) #convert quaternions to Euler angles 
    
    
def callback_scan(data):
    ranges = data.ranges


def controller():
    ######INITIALIZE THE ROS SUBSCRIBERS AND PUBLISHERS######
    rospy.init_node('controller', anonymous=True) #initiates the ROS-python node 
    sub = rospy.Subscriber('/odom', Odometry, callback_odom) #this is the "odometry" topic from the gazebo simulator using the "Odometry" message type
    sub = rospy.Subscriber('/scan', LaserScan, callback_scan)
    pub = rospy.Publisher('/cmd_vel', Twist, queue_size = 1) #this is the "command velocity" topic used for the turtlebot3 model, defined as a "Twist" message type
    rate = rospy.Rate(20) #this parameters specifies the loop-time of the controller in hz


    
    while not rospy.is_shutdown():  #The main loop starts here. From this point on the code is repeated at a loop time defined by the rospy.Rate() 

       #####IMPLEMENT YOUR CONTROLLER HERE#########
       
      #############################################

        ######SET UP AND PUBLISH THE ROS-MESSAGE CONTAINING THE CONTROL INPUTS######
        control_signal = Twist()
        control_signal.linear.x = u_d #linear.x is the forward velocity
        control_signal.angular.z = u_h #angular.z is the angular velocity around the z-axis, which controls the heading
        pub.publish(control_signal)  #publish the message


        rate.sleep()


if __name__ == '__main__':
     try:
         controller()
     except rospy.ROSInterruptException:
         pass
