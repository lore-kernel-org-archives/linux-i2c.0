From: Lars Michael <lh_post-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: How to use one I2C device from two modules?
Date: Fri, 6 May 2011 04:30:33 -0700 (PDT)
Message-ID: <842687.69100.qm@web30208.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On our custom board we have an I2C GPIO port expander. This is used for different things like power supply control and button control. Hence I wrote two modules; pscontrol and button. 

In the modules I use i2c_new_device to create the device and to get the i2c_client struct that I later use in the smbus calls. This works fine, one module at the time. Together the last insmod fails, because the device at that address is already created.

But how do I access the same I2C device from several modules? Ideally I want to specify the adapter and slave address. If a client is found, I get the i2c_client otherwise I have to create it by i2c_new_device (or probe it). Is it possible?

Since I know the I2C bus and slave addresses in advance, would it be better to predeclare them by i2c_register_board_info? And in that case, how do I get the i2c_client struct in the module?

Kernel version 2.6.29
Target is m68k (Coldfire)

Thanks and regards,
- Lars
