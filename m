From: Srikanth Krishnamachary <srikanth.krishnamachary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ability to activate i2c-mux-gpio from user-space
Date: Tue, 16 Sep 2014 03:15:43 +0000 (UTC)
Message-ID: <loom.20140916T051449-372@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,
   I was looking at the i2c-mux-gpio driver (http://lxr.free-
electrons.com/source/drivers/i2c/muxes/i2c-mux-gpio.c) which which 
provides the ability to i2c segments behind an i2c adapter where the 
specific segment is selectable via gpio mux.

    It appears that the driver/instances have to be instantiated based on 
either a device-tree or ACPI and that we can' add this from user-space.

   I am having a system where I have i2c segments selectable via gpio.  I 
was wondering if there is any way that I could just use sysfs and 
instanitate the gpio-mux just like the way one can add an i2c-device.

   Example, a new i2c device can be attached  by writing to 
/sys/bus/i2c/devices/i2c-0/new_device.
   Similarly is there a way I can do something like\"echo "
(<gpio_pin1>,value1),..." <parent_i2c-bus>" and then have the i2c-mux-gpio 
instantiate an instance of this driver?

   Any pointers would be greatly appreciated.

Thanks
Srikanth
