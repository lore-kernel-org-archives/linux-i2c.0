From: Simon Lindgren <simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>
Subject: Implementing bus recovery
Date: Fri, 22 Aug 2014 21:14:57 +0200
Message-ID: <53F796B1.2000400@aqwary.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I would like to implement bus recovery support for the at91 driver, but 
there it is not clear how the core support is supposed to be used, and I 
could not find an existing adapter implementation using it.

First off, reading the old mailing list discussion here:
http://thread.gmane.org/gmane.linux.drivers.i2c/10225

It seems a pinctrl state should be used to switch the pins over to gpio 
mode. Now, I need a place to put this state switching. The 
i2c_bus_recovery_info struct looks like this:

struct i2c_bus_recovery_info {
	int (*recover_bus)(struct i2c_adapter *);

	int (*get_scl)(struct i2c_adapter *);
	void (*set_scl)(struct i2c_adapter *, int val);
	int (*get_sda)(struct i2c_adapter *);

	void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
	void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);

	/* gpio recovery */
	int scl_gpio;
	int sda_gpio;
};

There is no usable callback to do this, because {un,}prepare_recovery is 
only passed the bus recovery info and no driver data is reachable from that.

So next up, I thought I'd wrap i2c_generic_gpio_recovery and do the 
state switching there. But then I have to fill in the entire info struct 
by hand which definitely does not seem to be the intention given the 
special case in i2c_register_adapter. What am I missing?
