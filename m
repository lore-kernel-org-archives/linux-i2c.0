From: Pete Flugstad <pete.flugstad-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: exclusive access to I2C device
Date: Thu, 4 Mar 2010 12:06:23 -0600
Message-ID: <84d4a6d51003041006i1b619d2l942d21ce1a9a069e@mail.gmail.com>
Reply-To: pete.flugstad-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!  We're running Linux 2.6.27 with i2c tools 3.0.2.

We have a number of userspace program using the raw i2c_smbus interface
to talk to a variety of devices. Right now, it seems like every program can open
up the device and issue commands, which interferes with an already running
command.

I see the code in open_i2c_bus using:

    	sprintf(filename, "/dev/i2c/%d", i2cbus);
	file = open(filename, O_RDWR);

Would adding O_EXCL to this open help to make things exclusive?  Or is there a
better way to do what I want.

Right now we're going to set up a daemon to arbitrate access to the I2C bus,
but it would be nice if we had something simpler, since now all apps have to
talk to the daemon.  I was thinking something along the lines of just telling
userspace to loop opening the device exclusively until that succeeds, run the
command,  then close the device.

Thanks,
Pete
