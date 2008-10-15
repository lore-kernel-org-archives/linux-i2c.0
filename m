From: Andreas Seidler <tetzlav-bXdiauyh1GQ7K2kJdssfr+TW4wlIGRCZ@public.gmane.org>
Subject: Re: MAX1236 with smbus (CS5536 ACB0)
Date: Wed, 15 Oct 2008 15:06:22 +0200
Message-ID: <gd4psg$dql$1@ger.gmane.org>
References: <48F2A270.8060307@leipzig.freifunk.net>	<20081013092548.3d58a320@hyperion.delvare>	<48F32CE9.8000109@cam.ac.uk>	<gd3g3j$29i$1@ger.gmane.org>
	<48F5CF88.2030500@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48F5CF88.2030500-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jonathan Cameron schrieb:
> Andreas Seidler wrote:
>> Jonathan Cameron schrieb:
>>> A driver that should work with this chip is part of the
>>> iio subsystem, so I have a fair bit of familiarity (though
>>> only via 1238 rather than this exact model)
>> I found this subsystem too and its promising, but it depends on RTC with
>> periodic Interupts - and most of embedded hardware lacks of such RTCs.
> In current code periodic interrupts are only required if you want to use
> a polled ring buffer.  This is now a Kconfig option and if you turn it off
> you'll still have sysfs type interfaces for reading directly from the
> device.

if i disable "timer support within iio" and RTC-support in kernel i get
ERROR: "rtc_irq_set_state" [drivers/industrialio/industrialio.ko] undefined!
ERROR: "rtc_class_open" [drivers/industrialio/industrialio.ko] undefined!
ERROR: "rtc_irq_unregister" [drivers/industrialio/industrialio.ko] undefined!
ERROR: "rtc_irq_register" [drivers/industrialio/industrialio.ko] undefined!
ERROR: "rtc_irq_set_freq" [drivers/industrialio/industrialio.ko] undefined!
ERROR: "rtc_class_close" [drivers/industrialio/industrialio.ko] undefined!

my .config:
CONFIG_INDUSTRIALIO=m
CONFIG_INDUSTRIALIO_PTIMER_BOARDINFO=y
CONFIG_IIO_RING_BUFFER=y
# CONFIG_IIO_TIMERS is not set
CONFIG_IIO_SW_RING=m
#
# Accelerometers
#
CONFIG_LIS3L02DQ=m
#
# Analog to digital convertors
#
CONFIG_MAX1363=m
#
# Inertial Measurement Units
#
# CONFIG_ADIS16350 is not set

or do i get something wrong?


> A direct chrdev access to 'scan' the device is on the todo list,
> but isn't there yet.
> 
> Hopefully (after fighting with git this afternoon) I should shortly have
> a repository up so its easier for people to get the current code and to
> send patches against it.

sounds good!


Regards
Andreas


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
