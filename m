From: "Anthony Drake" <agmotorsvc-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: Re: rtc-ds3232 driver
Date: Thu, 1 Mar 2012 19:54:00 +0000 (UTC)
Message-ID: <61_2012_13540_GON@news.gmane.org>
References: <61_2012_11913_GON@news.gmane.org> <20120301191200.GB2538@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 1 Mar 2012 20:12:00 +0100,
Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote 

> 
> Documentation/rtc.txt
> 
> --=20
Thank you.  I am familiar with the /dev/rtc0 character device special 
file interface, and can access it well.  My problem is that there is no
device special file created for rtc-ds3232 module.  I know how to mknod
a character device, but I do not know the major/minor number for
rtc-ds3232.ko, it does not appear in /proc/devices.  I do have
/dev/i2c-1, 2, & 3 in my system.  

I think I just do not know how to access i2c driver services, one that
is added in the following way, from rtc-ds3232.c: 

static int __init ds3232_init(void)
{
	printk("adding ds3232 driver: %s\n", ds3232_driver.driver.name);
	return i2c_add_driver(&ds3232_driver);
}

ds3232_driver defined:
static struct i2c_driver ds3232_driver = {
	.driver = {
		.name = "rtc-ds3232",
		.owner = THIS_MODULE,
	},
	.probe = ds3232_probe,
	.remove = __devexit_p(ds3232_remove),
	.id_table = ds3232_id,
};
