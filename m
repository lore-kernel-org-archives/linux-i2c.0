From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I2C library and tools (lsi2c) for linux
Date: Fri, 20 Feb 2015 23:09:17 -0800
Message-ID: <CAAVjN7fv1f10j8S8Z23vN9eJ5vBy-jtMTjLKTKyBu9UdZgsvOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I published lsi2c and libi2cdev on github if anyone is interested in
trying out the new i2c bus tools.

https://github.com/costad2/i2cdev

Any feedback and contribution is greatly appreciated


EXAMPLE:

[root@linux ~]# lsi2c
I2C Adapters:
bus: i2c-0 path: 0               type: i2c name: MPC adapter at 0xffe03000
bus: i2c-2 path: 0:0.0           type: mux name: i2c-0-mux (chan_id 0)
bus: i2c-3 path: 0:0.1           type: mux name: i2c-0-mux (chan_id 1)
bus: i2c-4 path: 0:0.2           type: mux name: i2c-0-mux (chan_id 2)
bus: i2c-5 path: 0:0.3           type: mux name: i2c-0-mux (chan_id 3)
bus: i2c-6 path: 0:0.4           type: mux name: i2c-0-mux (chan_id 4)
bus: i2c-7 path: 0:0.5           type: mux name: i2c-0-mux (chan_id 5)
bus: i2c-8 path: 0:0.6           type: mux name: i2c-0-mux (chan_id 6)
bus: i2c-9 path: 0:0.7           type: mux name: i2c-0-mux (chan_id 7)
bus: i2c-1 path: 1               type: i2c name: MPC adapter at 0xffe03100
bus: i2c-10 path: 1:0.0           type: mux name: i2c-1-mux (chan_id 0)
bus: i2c-11 path: 1:0.1           type: mux name: i2c-1-mux (chan_id 1)
bus: i2c-18 path: 1:0.1:0.0       type: mux name: i2c-11-mux (chan_id 0)
bus: i2c-12 path: 1:0.2           type: mux name: i2c-1-mux (chan_id 2)
bus: i2c-32 path: 1:0.2:0.0       type: mux name: i2c-12-mux (chan_id 0)
bus: i2c-33 path: 1:0.2:0.0:0.0   type: mux name: i2c-32-mux (chan_id 0)
bus: i2c-34 path: 1:0.2:0.0:0.1   type: mux name: i2c-32-mux (chan_id 1)
bus: i2c-35 path: 1:0.2:0.0:0.2   type: mux name: i2c-32-mux (chan_id 2)
bus: i2c-36 path: 1:0.2:0.0:0.3   type: mux name: i2c-32-mux (chan_id 3)
bus: i2c-37 path: 1:0.2:0.0:0.4   type: mux name: i2c-32-mux (chan_id 4)
bus: i2c-38 path: 1:0.2:0.0:0.5   type: mux name: i2c-32-mux (chan_id 5)
bus: i2c-39 path: 1:0.2:0.0:0.6   type: mux name: i2c-32-mux (chan_id 6)
bus: i2c-40 path: 1:0.2:0.0:0.7   type: mux name: i2c-32-mux (chan_id 7)
bus: i2c-13 path: 1:0.3           type: mux name: i2c-1-mux (chan_id 3)
bus: i2c-23 path: 1:0.3:0.0       type: mux name: i2c-13-mux (chan_id 0)
bus: i2c-24 path: 1:0.3:0.0:0.0   type: mux name: i2c-23-mux (chan_id 0)
bus: i2c-25 path: 1:0.3:0.0:0.1   type: mux name: i2c-23-mux (chan_id 1)
bus: i2c-26 path: 1:0.3:0.0:0.2   type: mux name: i2c-23-mux (chan_id 2)
bus: i2c-27 path: 1:0.3:0.0:0.3   type: mux name: i2c-23-mux (chan_id 3)
bus: i2c-28 path: 1:0.3:0.0:0.4   type: mux name: i2c-23-mux (chan_id 4)
bus: i2c-29 path: 1:0.3:0.0:0.5   type: mux name: i2c-23-mux (chan_id 5)
bus: i2c-30 path: 1:0.3:0.0:0.6   type: mux name: i2c-23-mux (chan_id 6)
bus: i2c-31 path: 1:0.3:0.0:0.7   type: mux name: i2c-23-mux (chan_id 7)
bus: i2c-14 path: 1:0.4           type: mux name: i2c-1-mux (chan_id 4)
bus: i2c-19 path: 1:0.4:0.0       type: mux name: i2c-14-mux (chan_id 0)
bus: i2c-15 path: 1:0.5           type: mux name: i2c-1-mux (chan_id 5)
bus: i2c-20 path: 1:0.5:0.0       type: mux name: i2c-15-mux (chan_id 0)
bus: i2c-16 path: 1:0.6           type: mux name: i2c-1-mux (chan_id 6)
bus: i2c-21 path: 1:0.6:0.0       type: mux name: i2c-16-mux (chan_id 0)
bus: i2c-17 path: 1:0.7           type: mux name: i2c-1-mux (chan_id 7)
bus: i2c-22 path: 1:0.7:0.0       type: mux name: i2c-17-mux (chan_id 0)
Count: 30

[root@linux ]# lsi2c -d
I2C Devices:
bus=0 type=i2c bus_path=0               address=0x70 name=pca9548
driver=pca954x
bus=6 type=mux bus_path=0:0.4           address=0x68 name=ds1339
driver=rtc-ds1307
bus=1 type=i2c bus_path=1               address=0x74 name=pca9548
driver=pca954x
bus=11 type=mux bus_path=1:0.1           address=0x73 name=pca9541
driver=pca9541
bus=12 type=mux bus_path=1:0.2           address=0x7e name=pca9541
driver=pca9541
bus=32 type=mux bus_path=1:0.2:0.0       address=0x71 name=pca9547
driver=pca954x
bus=13 type=mux bus_path=1:0.3           address=0x7e name=pca9541
driver=pca9541
bus=23 type=mux bus_path=1:0.3:0.0       address=0x71 name=pca9547
driver=pca954x
bus=14 type=mux bus_path=1:0.4           address=0x73 name=pca9541
driver=pca9541
bus=15 type=mux bus_path=1:0.5           address=0x73 name=pca9541
driver=pca9541
bus=16 type=mux bus_path=1:0.6           address=0x73 name=pca9541
driver=pca9541
bus=17 type=mux bus_path=1:0.7           address=0x73 name=pca9541
driver=pca9541
Count: 12


-- 
- Danielle Costantino
