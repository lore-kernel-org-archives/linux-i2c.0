From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [patch 2/8] I2C: S3C2410: Add MODULE_ALIAS() for s3c2440
	device.
Date: Sun, 1 Jun 2008 22:51:02 +0100
Message-ID: <20080601215102.GJ7334@trinity.fluff.org>
References: <20080529132244.818543231@fluff.org.uk>
	<20080529132406.186957190@fluff.org.uk>
	<20080530215452.2ee3d4a7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080530215452.2ee3d4a7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 30, 2008 at 09:54:52PM +0200, Jean Delvare wrote:
> Hi Ben,
> 
> On Thu, 29 May 2008 14:22:46 +0100, Ben Dooks wrote:
> > Add a MODULE_ALIAS() statement for the i2c-s3c2410 controller
> > to ensure that it can be autoloaded on the S3C2440 systems that
> > we support.
> > 
> > Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > 
> > Index: linux-2.6.26-rc4-quilt1/drivers/i2c/busses/i2c-s3c2410.c
> > ===================================================================
> > --- linux-2.6.26-rc4-quilt1.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-05-28 11:56:54.000000000 +0100
> > +++ linux-2.6.26-rc4-quilt1/drivers/i2c/busses/i2c-s3c2410.c	2008-05-28 11:57:12.000000000 +0100
> > @@ -947,3 +947,4 @@ MODULE_DESCRIPTION("S3C24XX I2C Bus driv
> >  MODULE_AUTHOR("Ben Dooks, <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>");
> >  MODULE_LICENSE("GPL");
> >  MODULE_ALIAS("platform:s3c2410-i2c");
> > +MODULE_ALIAS("platform:s3c2440-i2c");
> 
> With the current driver code, that's correct.
> 
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> That being said, I think the approach is wrong. You shouldn't register
> two different platform drivers just to be able to differentiate between
> device types. You have platform_data for that, it's cleaner and cheaper.

Actually, there are down sides to doing it via platform data, and a few
upsides to using the driver model. I do agree that >1 driver does mean
that you end up allocating more space to the drivers, but I hope that
I can convince you that this isn't without merit. 

The following are downsides:

1) using platform data means that not only do all the boards that have
   i2c busses on (or other peripherals using this method) need to carry[1]
   and register platform data even if they do not need to.

2) We currently change the name of the platform device in the cpu specific
   architecture initialisation, which would mean either moving this to each
   machine or have some form of sharing between the arch code and the board
   init. 

3) Some boards can have more than one cpu type on them, which makes life
   even worse for the above.

The advantage of changing the name of the platform device means that the
type of device is shown in the /sys/devices/platform heirachy without any
need for code to add a new attribute to show it within the device itself.


[1] Even if this is __initdata, it means the kernel has to carry it to
    load it even if it gets dumped at startup, and we have a number of
    boards that are available.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
