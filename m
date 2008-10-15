From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: MAX1236 with smbus (CS5536 ACB0)
Date: Wed, 15 Oct 2008 16:14:47 +0100
Message-ID: <48F608E7.9040309@cam.ac.uk>
References: <48F2A270.8060307@leipzig.freifunk.net>	<20081013092548.3d58a320@hyperion.delvare>	<48F32CE9.8000109@cam.ac.uk>	<gd3g3j$29i$1@ger.gmane.org>	<48F5CF88.2030500@cam.ac.uk>
	<gd4psg$dql$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <gd4psg$dql$1@ger.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Andreas Seidler <tetzlav-bXdiauyh1GQ7K2kJdssfr+TW4wlIGRCZ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Andreas Seidler wrote:

> 
> if i disable "timer support within iio" and RTC-support in kernel i get
> ERROR: "rtc_irq_set_state" [drivers/industrialio/industrialio.ko] undefined!
> ERROR: "rtc_class_open" [drivers/industrialio/industrialio.ko] undefined!
> ERROR: "rtc_irq_unregister" [drivers/industrialio/industrialio.ko] undefined!
> ERROR: "rtc_irq_register" [drivers/industrialio/industrialio.ko] undefined!
> ERROR: "rtc_irq_set_freq" [drivers/industrialio/industrialio.ko] undefined!
> ERROR: "rtc_class_close" [drivers/industrialio/industrialio.ko] undefined!
> 

As I'm a bit pushed for time today, there is a temporary git repos at

git://www.srcf.ucam.org/jic23-git

with an iio-devel branch that is the current state of the industrialio subsystem
(complete with bug fix for the compile bug you found!)

As the subsystem is still in somewhat of a state of flux the git history is a bit
bare (only one commit and that includes all the drivers etc)

Feel free to have a play. I've compile tested this set no x86 but not arm
as yet, so weird stuff may occur ;)
